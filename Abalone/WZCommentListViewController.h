//
//  WZCommentListViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZMerchant.h"

@interface WZCommentListViewController : UITableViewController
@property (nonatomic,strong)WZMerchant *merchant;

- (void)updateViews;
@end
