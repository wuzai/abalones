//
//  UIViewController+Background.m
//  Abalone
//
//  Created by 吾在 on 13-5-5.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "UIViewController+Background.h"
#import "WZTheme.h"

@implementation UIViewController (Background)
- (void)awakeFromNib
{
    [self.view setBackgroundColor:[WZTheme backColor]];
  //  self.hidesBottomBarWhenPushed = YES;
}
@end
