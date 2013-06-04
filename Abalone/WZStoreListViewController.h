//
//  WZStoreListViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-3.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WZStoreListViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *storesArray;
@property (nonatomic,strong) NSArray *comparator;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,strong) CLLocation *here;

@property (nonatomic,assign)NSInteger items;
-(void)sort;
-(void)loadData;
@end
