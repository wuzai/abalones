//
//  WZMerchantPointToUserViewController.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-17.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WZMerchant;

@interface WZMerchantPointToUserViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *explain;

@property (weak, nonatomic) IBOutlet UILabel *rate;

@property (weak, nonatomic) IBOutlet UITextField *pintNum;

@property (nonatomic,strong) WZMerchant *merchant;
@property (nonatomic,strong) UITableViewController *lastVC;

- (IBAction)memberPointToUser:(id)sender;
@end
