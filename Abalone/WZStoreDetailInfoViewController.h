//
//  WZStoreDetailInfoViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextView+Zoom.h"
#import "WZStore.h"

@interface WZStoreDetailInfoViewController : UITableViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *storeCellPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeAddressTextView;
@property (weak, nonatomic) IBOutlet UILabel *merchantIntro;
@property (weak, nonatomic) IBOutlet UILabel *webURL;


@property (strong,nonatomic) WZStore *store;

-(void)updateViews;
@end
