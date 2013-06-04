//
//  WZMyMerchantPointRecordListViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-7.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZMerchant.h"

typedef NS_ENUM(NSInteger, PointRecordType)
{
    WZUserType,
    WZMerchantType,
    WZMemberType,
};

@interface WZMyMerchantPointRecordListViewController : UITableViewController
@property (nonatomic,strong) WZMerchant *merchant;
@property (nonatomic,assign) PointRecordType type;
@end
