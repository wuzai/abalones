//
//  WZContentViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZContentViewController.h"
#import "WZstore.h"
#import "WZMerchant.h"
#import "WZPointRecord.h"


@interface WZContentViewController ()

@end

@implementation WZContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	 [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_paper"]] ];
    self.tableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if (self.type == WZUserType) {
         self.merchantName.text = @"平台";
    }else{
        self.merchantName.text = self.pointRecord.merchant.name;
        self.opPeople.text = self.pointRecord.operater;
        self.opAddress.text = self.pointRecord.store.address;
    }
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy年MM月dd日  HH时mm分"];
    NSString *dateStr = [dateFormater stringFromDate:self.pointRecord.createdAt];
    self.opTime.text = dateStr;
   
    if (self.pointRecord.addPoint.intValue) {
        self.opContent.text = [NSString stringWithFormat:@"积分增加 %i",self.pointRecord.addPoint.intValue ];
    }else{
        self.opContent.text = [NSString stringWithFormat:@"积分减少 %i",self.pointRecord.decPoint.intValue ];
    }
    self.totalPoint.text = [NSString stringWithFormat:@" %i",self.pointRecord.surplusPoint.intValue ];
   
}

@end
