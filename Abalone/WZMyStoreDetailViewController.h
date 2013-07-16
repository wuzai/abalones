//
//  WZMyStoreDetailViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZStore.h"
#import "WZUserPointSendViewController.h"

@interface WZMyStoreDetailViewController : UITableViewController
@property (nonatomic,strong) WZStore *store;

- (IBAction)shareMyStore:(UIBarButtonItem *)sender;

@end
