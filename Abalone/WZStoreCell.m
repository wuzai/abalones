//
//  WZStoreCell.m
//  Abalone
//
//  Created by 吾在 on 13-4-3.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStoreCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation WZStoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
//    self.storeImage.layer.borderWidth = 1.0;
//    self.storeImage.layer.borderColor = [[UIColor colorWithRed:255 green:0 blue:50 alpha:1] CGColor];
//    self.merchantLogoImage.layer.cornerRadius = 3.0;
//    self.merchantLogoImage.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
