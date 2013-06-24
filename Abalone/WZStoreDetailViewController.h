//
//  WZStoreDetailViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-11.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZStore.h"
#import "WZStoreDetailInfoViewController.h"
#import "EGOImageView.h"
#import "WZServiceItemListViewController.h"
#import "SDSegmentedControl.h"
#import "WZCommentListViewController.h"
#import "WZStoreAdListViewController.h"


@interface WZStoreDetailViewController : UITableViewController
- (IBAction)changeView:(id)sender;
@property (nonatomic,strong) WZStore *store;
@property (weak, nonatomic) IBOutlet EGOImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet SDSegmentedControl *segmentedControl;
@property (nonatomic,strong) NSMutableArray *contentTableViews;

@property (nonatomic,strong) WZStoreDetailInfoViewController *storeDetailInfoViewController;
@property (nonatomic,strong) WZServiceItemListViewController *serviceItemListViewController;
@property (nonatomic,strong) WZCommentListViewController *commentListViewController;
@property (nonatomic,strong) WZStoreAdListViewController *storeAdListViewController;
@end
