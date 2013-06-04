//
//  WZServiceItemListViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZStore+serviceItems.h"

@interface WZServiceItemListViewController : UITableViewController
@property (nonatomic,strong) WZStore *store;
@property (nonatomic,strong) NSMutableArray *serviceItems;

-(void)updateViews;
@end
