//
//  WZLoginViewController.h
//  MyCard
//
//  Created by 吾在 on 13-3-20.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZLoginViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *usernameField;
@property (nonatomic,weak) IBOutlet UITextField *passwordField;
- (IBAction)login:(id)sender;
//- (IBAction)reset:(id)sender;
- (IBAction)done:(id)sender;
@end
