//
//  WZMyStoreDetailHeaderCell.h
//  Abalone
//
//  Created by 吾在 on 13-5-5.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZMyStoreDetailHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet EGOImageView *cellHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *merchantPointLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealsButton;
@property (weak, nonatomic) IBOutlet UIButton *merchantDetailButton;


@end
