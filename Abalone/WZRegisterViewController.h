//
//  WZRegisterViewController.h
//  MyCard
//
//  Created by 吾在 on 13-3-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZRegisterViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *usernameField;
@property (nonatomic,weak) IBOutlet UITextField *passwordField;
@property (nonatomic,weak) IBOutlet UITextField *confirmField;
@property (nonatomic,weak) IBOutlet UITextField *captchaField;
@property (nonatomic,weak) IBOutlet UISwitch *licenseSwitch;
- (IBAction)register_:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
@end
