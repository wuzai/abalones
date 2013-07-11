//
//  WZPasswordViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZPasswordViewController.h"
#import "NSString+Format.h"
#import "WZPassword.h"
#import "UIWindow+Lock.h"

@interface WZPasswordViewController ()
{
    IBOutlet UITextField *oldPasswordField;
    IBOutlet UITextField *newPasswordField;
    IBOutlet UITextField *confirmField;
}
- (NSString *)warning;
- (void)succeed:(NSNotification *)notification;
- (void)failed:(NSNotification *)notification;
@end

@implementation WZPasswordViewController

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

#pragma mark - 
- (NSString *)warning
{
    if (![oldPasswordField.text length] || ![newPasswordField.text length]) {
        return @"密码不能为空";
    }
    else if (![oldPasswordField.text isValidPassword] || ![newPasswordField.text isValidPassword]) {
        return @"密码不合法";
    }
    else if (![newPasswordField.text isEqualToString:confirmField.text]) {
        return @"新密码两次输入不一致";
    }
    return nil;
}

- (IBAction)cancel:(id)sender {
    
    [self closeKeyboard:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)reset:(id)sender
{
    [self closeKeyboard:nil];
    NSString *warning = [self warning];
    if (warning) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:warning delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        [UIWindow lock];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succeed:) name:WZUpdatePasswordSucceedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failed:) name:WZUpdatePasswordFailedNotification object:nil];
        [WZPassword replace:oldPasswordField.text with:newPasswordField.text];
    }
}

- (IBAction)closeKeyboard:(id)sender
{
    if ([sender isEqual:oldPasswordField]) {
        [newPasswordField becomeFirstResponder];
    }
    else if ([sender isEqual:newPasswordField]) {
        [confirmField becomeFirstResponder];
    }
    else if ([sender isEqual:confirmField]) {
        [self reset:nil];
    }
    else {
        [oldPasswordField resignFirstResponder];
        [newPasswordField resignFirstResponder];
        [confirmField resignFirstResponder];
    }
}
#pragma mark -
- (void)succeed:(NSNotification *)notification
{
    [UIWindow unlock];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpdatePasswordSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpdatePasswordFailedNotification object:nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改成功" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}

- (void)failed:(NSNotification *)notification
{
    [UIWindow unlock];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpdatePasswordSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUpdatePasswordFailedNotification object:nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改失败" message:[notification object] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}
@end
