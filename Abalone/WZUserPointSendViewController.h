//
//  WZUserPointSendViewController.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-16.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WZMerchant;

@interface WZUserPointSendViewController : UITableViewController <UIAlertViewDelegate>
@property (nonatomic,strong) WZMerchant *merchant;
@property (nonatomic,strong) UITableViewController *lastVC;
@property (weak, nonatomic) IBOutlet UILabel *sendExplain;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *pointNum;
- (IBAction)sendPoint:(id)sender;

- (void)done:(id)sender;
@end
