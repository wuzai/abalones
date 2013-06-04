//
//  UIView+Exclusive.m
//  MyCard
//
//  Created by 吾在 on 13-3-27.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "UIView+Exclusive.h"

@implementation UIView (Exclusive)
- (void)didMoveToSuperview
{
    self.exclusiveTouch = YES;
}

@end
