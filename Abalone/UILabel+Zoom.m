//
//  UILabel+Zoom.m
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "UILabel+Zoom.h"

@implementation UILabel (Zoom)
- (void)zoom
{
    NSString *string = self.text;
    if (string) {
        CGSize size = [string sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        CGRect frame = self.frame;
        frame.size.height = size.height;
        self.frame = frame;
    }
}
@end
