//
//  WZUserProfileViewController.h
//  MyCard
//
//  Created by 吾在 on 13-3-20.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZGenderSwitch.h"

@interface WZUserProfileViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet WZGenderSwitch *genderSwitch;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UIButton *birthButton;
- (IBAction)logout:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)birthday:(id)sender;
@end
