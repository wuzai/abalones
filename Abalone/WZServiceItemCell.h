//
//  WZServiceItemCell.h
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZServiceItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet EGOImageView *serviceItemImage;
@property (weak, nonatomic) IBOutlet UILabel *serviceItemTitle;

@property (weak, nonatomic) IBOutlet UILabel *serviceItemContent;



@end
