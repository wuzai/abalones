//
//  WZPointViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-6.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZMultiImageView.h"

@interface WZPointViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIView *accessoryView;
@property (weak, nonatomic) IBOutlet UILabel *ruleLabel;
@property (weak, nonatomic) IBOutlet WZMultiImageView *imageView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *detailButton;

@end
