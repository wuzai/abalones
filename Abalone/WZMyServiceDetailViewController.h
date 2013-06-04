//
//  WZMyServiceDetailViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-6.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZMyServiceDetailViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *serviceTitle;
@property (weak, nonatomic) IBOutlet UILabel *servicePromptMessage;
@property (weak, nonatomic) IBOutlet UILabel *serviceDescription;
@property (weak, nonatomic) IBOutlet EGOImageView *serviceImageView;

@property (weak, nonatomic) IBOutlet UILabel *serviceRule;

@property (nonatomic,strong) id service;
@end
