//
//  WZStoreTypeSelectorViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-29.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZMenuCell.h"

@interface WZStoreTypeSelectorViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *types;
@property (nonatomic,strong) NSString *selectedType;
@end
