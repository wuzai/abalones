//
//  WZPointRecordDetailViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZPointRecord.h"
#import "WZMyMerchantPointRecordListViewController.h"

@interface WZPointRecordDetailViewController : UIViewController
@property (nonatomic,strong) WZPointRecord *pointRecord;
@property (nonatomic,assign) PointRecordType type;

@property (weak, nonatomic) IBOutlet UIView *contentView;


@end
