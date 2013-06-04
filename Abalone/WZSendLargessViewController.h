//
//  WZSendLargessViewController.h
//  Abalone
//
//  Created by 吾在 on 13-5-6.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZLargess.h"

@interface WZSendLargessViewController : UITableViewController
@property (strong,nonatomic) id service;
@property (nonatomic,strong) NSString *sendStoreID;
@property (weak, nonatomic) IBOutlet UILabel *serviceTitle;
@property (weak, nonatomic) IBOutlet UILabel *serviceDescription;
@property (weak, nonatomic) IBOutlet UITextField *largessToCellPhone;
- (IBAction)sendLargess:(UIButton *)sender;

- (IBAction)checkCellPhone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *senderButton;


@end
