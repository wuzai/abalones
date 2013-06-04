//
//  WZMessageCell.m
//  Abalone
//
//  Created by 吾在 on 13-4-2.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessageCell.h"

@implementation WZMessageCell
@synthesize logoView = _logoView;
@synthesize titleLabel = _titleLabel;
//@synthesize detailView = _detailView;
@synthesize contentLabel = _contentLabel;
@synthesize dateLabel = _dateLabel;
@synthesize merchantButton = _merchantButton;
@synthesize backgroundImageView = _backgroundImageView;

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

@end
