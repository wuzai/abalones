//
//  WZMerchantCardCell.m
//  Abalone
//
//  Created by 吾在 on 13-4-16.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMerchantCardCell.h"

@implementation WZMerchantCardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pointChanged:(id)sender {
}

- (IBAction)merchantInfo:(id)sender {
}
@end
