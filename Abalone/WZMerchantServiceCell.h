//
//  WZMerchantServiceCell.h
//  Abalone
//
//  Created by 吾在 on 13-4-16.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZMerchantServiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *serviceImageView;
@property (weak, nonatomic) IBOutlet UILabel *serviceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *serviceUsedButton;
@property (weak, nonatomic) IBOutlet UIButton *serviceSendToOtherButton;

@end
