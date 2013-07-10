//
//  WZActivitiesViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@interface WZActivitiesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SwipeViewDataSource,SwipeViewDelegate>
{
    IBOutlet UITableView *_tableView;
}
- (IBAction)header:(id)sender;
@end
