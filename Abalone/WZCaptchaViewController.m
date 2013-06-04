//
//  WZCaptchaViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-10.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZCaptchaViewController.h"
#import "WZCaptcha.h"
#import "NSString+Format.h"
#import "UIWindow+Lock.h"
#import "WZResetPasswordViewController.h"
#import "WZUser+Me.h"

@interface WZCaptchaViewController ()
- (NSString *)warning;
- (void)createCaptchaSucceed:(NSNotification *)notification;
- (void)createCaptchaFailed:(NSNotification *)notification;
@end

@implementation WZCaptchaViewController
@synthesize usernameField = _usernameField;

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
    UIBarButtonItem *back = [UIBarButtonItem new];
    back.title = @"上一步";
    self.navigationItem.backBarButtonItem = back;
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([WZUser me]) {
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
    [_usernameField resignFirstResponder];
}

- (NSString *)warning
{
    NSString *warning = nil;
    if (![_usernameField.text length]) {
        warning = @"请输入您注册的手机号";
    }
    else if (![_usernameField.text isValidTelphone]) {
        warning = @"手机号不合法";
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createCaptchaSucceed:) name:WZCreateCaptchaSucceedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createCaptchaFailed:) name:WZCreateCaptchaFailedNotification object:nil];
        [WZCaptcha createCaptchaFor:_usernameField.text];
    }
}

#pragma mark -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"Reset"]) {
        [(WZResetPasswordViewController *)segue.destinationViewController setUsername:sender];
    }
}

#pragma mark -
- (void)createCaptchaSucceed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZCreateCaptchaSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZCreateCaptchaFailedNotification object:nil];
    [UIWindow unlock];
    [self performSegueWithIdentifier:@"Reset" sender:_usernameField.text];
}

- (void)createCaptchaFailed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZCreateCaptchaSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZCreateCaptchaFailedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"找回失败" message:[notification object] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}

@end
