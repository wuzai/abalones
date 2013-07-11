//
//  WZResetPasswordViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-9.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZResetPasswordViewController.h"
#import "WZUser+Me.h"
#import "NSString+Format.h"
#import "UIWindow+Lock.h"
#import "WZResetPassword.h"

@interface WZResetPasswordViewController ()
{
    IBOutlet UITextField *captchaField;
    IBOutlet UITextField *passwordField;
    IBOutlet UITextField *confirmField;
}
- (NSString *)warning;
- (void)resetSucceed:(NSNotification *)notification;
- (void)resetFailed:(NSNotification *)notification;
@end

@implementation WZResetPasswordViewController
@synthesize username = _username;

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([WZUser me] || ![_username isValidPassword]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (IBAction)closeKeyboard:(id)sender
{
    if ([sender isEqual:captchaField]) {
        [passwordField becomeFirstResponder];
    }
    else if ([sender isEqual:passwordField])
    {
        [confirmField becomeFirstResponder];
    }
    else if ([sender isEqual:confirmField]) {
        [self reset:nil];
    }
    else {
        [captchaField resignFirstResponder];
        [passwordField resignFirstResponder];
        [confirmField resignFirstResponder];
    }
}

- (IBAction)cancel:(id)sender {
    [self closeKeyboard:nil];
    [self.navigationController popViewControllerAnimated:YES];
}






- (NSString *)warning
{
    NSString *warning = nil;
    if (![captchaField.text length]) {
        warning = @"验证码不能为空";
    }
    else if (![captchaField.text isValidCaptcha]) {
        warning = @"验证码不合法";
    }
    else if (![passwordField.text length]) {
        warning = @"密码不能为空";
    }
    else if (![passwordField.text isValidPassword]) {
        warning = @"密码不合法";
    }
    else if (![confirmField.text isEqualToString:passwordField.text]) {
        warning = @"两次密码不一致";
    }
    return warning;
}
- (IBAction)reset:(id)sender
{
    [self closeKeyboard:nil];
    NSString *warning = [self warning];
    if (warning) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:warning delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [UIWindow lock];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetSucceed:) name:WZResetPasswordSucceedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetFailed:) name:WZResetPasswordFailedNotification object:nil];
        [WZResetPassword resetPassword:passwordField.text forUser:_username withCaptcha:captchaField.text];
    }
}

#pragma mark -
- (void)resetSucceed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZResetPasswordSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZResetPasswordFailedNotification object:nil];
    [UIWindow unlock];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)resetFailed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZResetPasswordSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZResetPasswordFailedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"找回失败" message:[notification object] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}
@end
