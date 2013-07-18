//
//  WZMerchantPointToUserViewController.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-17.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@class WZMerchant;

@interface WZMerchantPointToUserViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *explain;

@property (weak, nonatomic) IBOutlet UILabel *rate;

@property (weak, nonatomic) IBOutlet UITextField *pintNum;
@property (weak, nonatomic) IBOutlet EGOImageView *merchantLogo;

@property (nonatomic,strong) WZMerchant *merchant;
@property (nonatomic,strong) UITableViewController *lastVC;

- (IBAction)memberPointToUser:(id)sender;
@end
