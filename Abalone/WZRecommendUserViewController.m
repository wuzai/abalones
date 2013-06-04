//
//  WZRecommendUserViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-10.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZRecommendUserViewController.h"
#import "NSString+Format.h"
#import "UIWindow+Lock.h"
#import "WZRecommendUser.h"
#import "WZUser+Me.h"
#import "WZUser+Networks.h"

@interface WZRecommendUserViewController ()
- (NSString *)warning;
- (void)succeed:(NSNotification *)notification;
- (void)failed:(NSNotification *)notification;
@end

@implementation WZRecommendUserViewController

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
    NSString *warning = nil;
    if (![self.telphoneField.text length]) {
        warning = @"电话不能为空";
    }
    else if (![self.telphoneField.text isValidTelphone])
    {
        warning = @"手机号不合法";
    }
    return warning;
}

- (IBAction)recomend:(id)sender
{
    [self closeKeyboard:nil];
    NSString *warning = [self warning];
    if (warning) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:warning delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }
    else {
        WZUser *me = [WZUser me];
        if (me) {
            [UIWindow lock];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succeed:) name:WZRecommendUserSucceedNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failed:) name:WZRecommendUserFailedNotification object:nil];
            [me recommend:_telphoneField.text];
        }
    }
}

- (IBAction)cancel:(id)sender
{
    [self closeKeyboard:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)closeKeyboard:(id)sender
{
    [_telphoneField resignFirstResponder];
}

#pragma mark -
- (void)succeed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZRecommendUserSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZRecommendUserFailedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"推荐成功" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}

- (void)failed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZRecommendUserSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZRecommendUserFailedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"推荐失败" message:[notification object] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}
@end
