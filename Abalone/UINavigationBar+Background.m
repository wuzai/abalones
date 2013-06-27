//
//  UINavigationBar+Background.m
//  Abalone
//
//  Created by 陈 海涛 on 13-6-25.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "UINavigationBar+Background.h"

@implementation UINavigationBar (Background)

-(void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"Menu"];
    [image drawInRect:rect];
}

@end
