//
//  WZResetPasswordViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-9.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZResetPasswordViewController : UIViewController
@property (nonatomic,copy) NSString *username;
- (IBAction)reset:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)cancel:(id)sender;

@end
