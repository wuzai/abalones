//
//  WZMyStoreListViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WZMyStoreListViewController : UITableViewController
@property (nonatomic,strong) NSArray *comparator;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,strong) CLLocation *here;

@property (nonatomic,assign)NSInteger items;
-(void)sort;
-(void)loadData;
@end
