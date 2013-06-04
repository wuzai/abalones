//
//  WZUseServiceViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-9.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZUseServiceViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *serviceTitle;

@property (weak, nonatomic) IBOutlet UILabel *serviceDescription;

@property (weak, nonatomic) IBOutlet EGOImageView *serviceImage;

@property (weak, nonatomic) IBOutlet UILabel *serviceCode;
@property (weak, nonatomic) IBOutlet UIButton *useButton;


- (IBAction)useService:(id)sender;
@property (nonatomic,strong)id service;
@property (nonatomic,strong)NSString *sendStoreID;
@end
