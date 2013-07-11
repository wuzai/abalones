//
//  WZMessagesViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-2.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface WZMessagesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}
- (IBAction)cleanup:(id)sender;
- (IBAction)lookupMerchant:(id)sender;
- (void)reloadTableViewDataSource;

- (void)doneLoadingTableViewData;
@end
