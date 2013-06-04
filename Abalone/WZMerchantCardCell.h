//
//  WZMerchantCardCell.h
//  Abalone
//
//  Created by 吾在 on 13-4-16.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZMerchantCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *merchantCardImageView;
@property (weak, nonatomic) IBOutlet UIButton *pointChangeButton;
@property (weak, nonatomic) IBOutlet UIButton *merchantInfoButton;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;

@end
