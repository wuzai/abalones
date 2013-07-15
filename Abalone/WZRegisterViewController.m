//
//  WZRegisterViewController.m
//  MyCard
//
//  Created by 吾在 on 13-3-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZRegisterViewController.h"
#import "NSString+Format.h"
#import "WZUser.h"
#import "WZUser+Me.h"
#import "WZSignup.h"
#import "UIWindow+Lock.h"

@interface WZRegisterViewController ()
- (NSString *)warning;
- (void)registerSucceed:(NSNotification *)notification;
- (void)registerFailed:(NSNotification *)notification;
@end

@implementation WZRegisterViewController
@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;

@synthesize confirmField = _confirmField;
@synthesize licenseSwitch = _licenseSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([WZUser me]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - Register
- (NSString *)warning
{
    NSString *warning = nil;
    if (![_usernameField.text isValidTelphone]) {
        warning = @"手机号不正确";
    }
    else if (![_passwordField.text length]) {
        warning = @"密码不能为空";
    }
    else if (![_passwordField.text isValidPassword]) {
        warning = @"密码不合法";
    }
    else if (![_confirmField.text isEqualToString:_passwordField.text]) {
        warning = @"密码不一致";
    }
//    else if (![_captchaField.text isValidCaptcha]) {
//        warning = @"验证码不能为空";
//    }
//    else if (![_captchaField.text isValidPassword]) {
//        warning = @"验证码不正确";
//    }
    else if ([_licenseSwitch isOn]==NO) {
        warning = @"请先阅读服务条款";
    }
    
    return warning;
}

- (IBAction)register_:(id)sender
{
    [self closeKeyboard:nil];
    NSString *warning = [self warning];
    if (warning) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:warning message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [UIWindow lock];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerSucceed:) name:WZRegisterSucceedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerFailed:) name:WZRegisterFailedNotification object:nil];
        [WZSignup signup:_usernameField.text withPassword:_passwordField.text andCaptcha:_passwordField.text];
    }
}

- (IBAction)cancel:(id)sender
{
    [self closeKeyboard:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)closeKeyboard:(id)sender
{
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_confirmField resignFirstResponder];
//    [_captchaField resignFirstResponder];
}

#pragma mark - Callbacks
- (void)registerSucceed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZRegisterSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZRegisterFailedNotification object:nil];
    [UIWindow unlock];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)registerFailed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZRegisterSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZRegisterFailedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册失败" message:[notification object] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}
@end
