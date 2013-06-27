//
//  WZADCell.h
//  Abalone
//
//  Created by wz on 13-6-24.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZADCell : UITableViewCell
@property (weak, nonatomic) IBOutlet EGOImageView *AdImage;
@property (weak, nonatomic) IBOutlet UILabel *adTitle;
@property (weak, nonatomic) IBOutlet UILabel *adContent;



@end
