//
//  WZContentViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZPointRecord.h"
#import "WZMyMerchantPointRecordListViewController.h"

@interface WZContentViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *merchantName;

@property (weak, nonatomic) IBOutlet UILabel *opTime;
@property (weak, nonatomic) IBOutlet UILabel *opContent;
@property (weak, nonatomic) IBOutlet UILabel *opPeople;
@property (weak, nonatomic) IBOutlet UILabel *opAddress;
@property (nonatomic,strong) WZPointRecord *pointRecord;
@property (nonatomic,assign) PointRecordType type;
@property (weak, nonatomic) IBOutlet UILabel *totalPoint;

@end
