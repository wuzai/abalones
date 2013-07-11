//
//  WZUserProfileViewController.m
//  MyCard
//
//  Created by 吾在 on 13-3-20.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUserProfileViewController.h"
#import "WZUser+Me.h"
#import "WZUser+Gender.h"
#import "WZProfileModifier.h"
#import "WZUser+Networks.h"
#import "NSString+Format.h"
#import "UIWindow+Lock.h"

@interface WZUserProfileViewController () <UIActionSheetDelegate,UIAlertViewDelegate>
- (NSString *)warning;
- (void)record;
- (void)reload;
- (void)succeed:(NSNotification *)notification;
- (void)failed:(NSNotification *)notification;
@end

@implementation WZUserProfileViewController
@synthesize nameField = _nameField;
@synthesize genderSwitch = _genderSwitch;
@synthesize emailField = _emailField;
@synthesize birthButton = _birthButton;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[WZProfileModifier modifier] invalid];
}
#pragma mark - 
- (NSString *)warning
{
    NSString *warning = nil;
    if (_emailField.text && ![_emailField.text isValidEmail]) {
        warning = @"邮箱不合法";
    }
    return warning;
}

- (void)reload
{
    WZUser *user = [WZUser me];
    _nameField.text = user.name;
    _genderSwitch.on = [user isMale];
    _emailField.text = user.email;
    NSDate *birth = user.birth;
    if (birth) {
        static NSDateFormatter *birthdayDateFormatter = nil;
        if (!birthdayDateFormatter) {
            birthdayDateFormatter = [NSDateFormatter new];
            birthdayDateFormatter.dateFormat = @"yyyy-MM-dd";
        }
        NSString *string =  [birthdayDateFormatter stringFromDate:birth];
        [self.birthButton setTitle:string forState:UIControlStateNormal];
        [self.birthButton setTitle:string forState:UIControlStateHighlighted];
    }
    else
    {
        [self.birthButton setTitle:@"请选择生日" forState:UIControlStateNormal];
        [self.birthButton setTitle:@"请选择生日" forState:UIControlStateHighlighted];
    }
    
}

- (void)record
{
    WZProfileModifier *modifier = [WZProfileModifier modifier];
    [modifier prepareChange:_nameField.text forKey:kWZUserProfileNameKey];
    //[self setSwitch:_genderSwitch onText:"是" offText:"否"];
    
    NSString *value = [_genderSwitch isOn]?@"男":@"女";
    [modifier prepareChange:_emailField.text forKey:kWZUserProfileEmailKey];
    [modifier prepareChange:value forKey:kWZUserProfileGenderKey];
}
#pragma mark -
- (IBAction)logout:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定注销" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)_logout
{
    [self closeKeyboard:nil];
    [WZUser leave];
    if (self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.firstOtherButtonIndex==buttonIndex) {
        [self _logout];
    }
}

#pragma mark -
- (IBAction)update:(id)sender
{
    [self closeKeyboard:nil];
    NSString *warning = [self warning];
    if (warning) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:warning delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self record];
        if ([WZProfileModifier modifier].changes) {
            [UIWindow lock];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succeed:) name:WZUserProfileUpdateSucceedNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failed:) name:WZUserProfileUpdateFailedNotification object:nil];
            [[WZUser me] update];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没有改动" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (IBAction)cancel:(id)sender
{
    [self closeKeyboard:nil];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)closeKeyboard:(id)sender
{
    if ([sender isKindOfClass:[UITextField class]]) {
        [sender resignFirstResponder];
    }
    else
    {
        [_nameField resignFirstResponder];
        [_emailField resignFirstResponder];
    }
}

- (IBAction)birthday:(id)sender
{
    [self closeKeyboard:nil];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择生日\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
    UIDatePicker *picker = [UIDatePicker new];
    picker.datePickerMode = UIDatePickerModeDate;
    picker.tag = 100;
    CGRect frame = picker.frame;
    frame.origin.y += 50;
    picker.frame = frame;
    [sheet addSubview:picker];
    if (self.navigationController.tabBarController) {
        [sheet showFromTabBar:self.navigationController.tabBarController.tabBar];
    }
    else
    {
        [sheet showInView:self.view];
    }
}

#pragma mark -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        UIView *picker = [actionSheet viewWithTag:100];
        if ([picker isKindOfClass:[UIDatePicker class]]) {
            NSDate *date = [(UIDatePicker *)picker date];
            if ([date timeIntervalSinceNow] > 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"不合法的日期" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            else
            {
                static NSDateFormatter *birthdayDateFormatter = nil;
                if (!birthdayDateFormatter) {
                    birthdayDateFormatter = [NSDateFormatter new];
                    birthdayDateFormatter.dateFormat = @"yyyy-MM-dd";
                }
                
                NSString *string =  [birthdayDateFormatter stringFromDate:date];
                [self.birthButton setTitle:string forState:UIControlStateNormal];
                [self.birthButton setTitle:string forState:UIControlStateHighlighted];
               
                [[WZProfileModifier modifier] prepareChange:date forKey:kWZUserProfileBirthKey];
            }
            
        }
    }
}
#pragma mark - 
- (void)succeed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileUpdateSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileUpdateFailedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}

- (void)failed:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileUpdateSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileUpdateFailedNotification object:nil];
    [UIWindow unlock];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改失败" message:[notification object] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}
@end
