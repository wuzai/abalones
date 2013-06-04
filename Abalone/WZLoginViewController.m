//
//  WZLoginViewController.m
//  MyCard
//
//  Created by 吾在 on 13-3-20.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZLoginViewController.h"
#import "NSString+Format.h"
#import "WZUser.h"
#import "WZUser+Me.h"
#import "WZLogin.h"
#import "UIWindow+Lock.h"
#import "WZCaptcha.h"
#import "WZResetPasswordViewController.h"

@interface WZLoginViewController ()<UIAlertViewDelegate>
{
    NSString *_usernameForReset;
}
- (NSString *)warning;
//- (void)resetPassword;
- (void)loginSucceed:(NSNotification *)notification;
- (void)loginFailed:(NSNotification *)notification;
//- (void)createCaptchaSucceed:(NSNotification *)notification;
//- (void)createCaptchaFailed:(NSNotification *)notification;
@end

@implementation WZLoginViewController
@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;

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

#pragma mark - Check
- (NSString *)warning
{
    NSString *warning = nil;
    if (![_usernameField.text isValidTelphone]) {
        warning = @"手机号不正确";
    }
    else if (![_passwordField.text length]) {
        warning = @"密码不能为空";
    }
    return warning;
}

#pragma mark - Login

- (IBAction)login:(id)sender
{
    [self done:nil];
    NSString *warning = [self warning];
    if (warning) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:warning message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [UIWindow lock];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed:) name:WZLoginSucceedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailed:) name:WZLoginFailedNotification object:nil];
        [WZLogin login:_usernameField.text withPassword:_passwordField.text];
    }
}

//- (IBAction)reset:(id)sender
//{
//    [self done:nil];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入手机号" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"找回密码", nil];
//    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [alert show];
//}

- (IBAction)done:(id)sender
{
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

//- (void)resetPassword
//{
//    [self performSegueWithIdentifier:@"Reset" sender:_usernameForReset];
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqual:@"Reset"]) {
//        [(WZResetPasswordViewController *)segue.destinationViewController setUsername:_usernameForReset];
//    }
//}

#pragma mark -
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == alertView.firstOtherButtonIndex) {
//        NSString *phone = [alertView textFieldAtIndex:0].text;
//        if ([phone isValidTelphone]) {
//            _usernameForReset = [phone copy];
//            [UIWindow lock];
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createCaptchaSucceed:) name:WZCreateCaptchaSucceedNotification object:nil];
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createCaptchaFailed:) name:WZCreateCaptchaFailedNotification object:nil];
//            [WZCaptcha createCaptchaFor:phone];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号不合法" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//            [alert show];
//        }
//    }
//}

#pragma mark - Callbacks
- (void)loginSucceed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZLoginSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZLoginFailedNotification object:nil];
    [UIWindow unlock];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loginFailed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZLoginSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZLoginFailedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:[notification object] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}

//- (void)createCaptchaSucceed:(NSNotification *)notification
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZCreateCaptchaSucceedNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZCreateCaptchaFailedNotification object:nil];
//    [UIWindow unlock];
//    [self resetPassword];
//}
//
//- (void)createCaptchaFailed:(NSNotification *)notification
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZCreateCaptchaSucceedNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZCreateCaptchaFailedNotification object:nil];
//    [UIWindow unlock];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"找回失败" message:[notification object] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//    [alert show];
//}
@end
