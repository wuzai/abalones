//
//  WZGenderSwitch.m
//  Switch
//
//  Created by 吾在 on 13-4-7.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZGenderSwitch.h"

@implementation WZGenderSwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.onImage = [UIImage imageNamed:@"男.png"];
        self.offImage = [UIImage imageNamed:@"女.png"];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.onImage = [UIImage imageNamed:@"男.png"];
    self.offImage = [UIImage imageNamed:@"女.png"];
}

@end
