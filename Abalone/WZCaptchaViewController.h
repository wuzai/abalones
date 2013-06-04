//
//  WZCaptchaViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-10.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZCaptchaViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *usernameField;
- (IBAction)reset:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
@end
