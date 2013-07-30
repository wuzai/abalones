//
//  WZMyStoreServiceCell.h
//  Abalone
//
//  Created by 吾在 on 13-5-6.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZMyStoreServiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet EGOImageView *storeServiceImage;
@property (weak, nonatomic) IBOutlet UILabel *storeServiceName;
@property (weak, nonatomic) IBOutlet UIButton *givingAwayButton;
@property (weak, nonatomic) IBOutlet UIButton *useButton;

@property (weak, nonatomic) IBOutlet UILabel *meteringCardNum;
@property (weak, nonatomic) IBOutlet UIImageView *meteringCardNumImage;
@property (strong, nonatomic) IBOutlet UILabel *type;

@end
