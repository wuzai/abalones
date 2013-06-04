//
//  WZAdvertisementCell.h
//  Abalone
//
//  Created by 吾在 on 13-4-11.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZAdvertisementCell : UITableViewCell
@property (nonatomic,weak) IBOutlet EGOImageView *logoView;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *merchantLabel;
@property (nonatomic,weak) IBOutlet UIImageView *backgroundImageView;
@end
