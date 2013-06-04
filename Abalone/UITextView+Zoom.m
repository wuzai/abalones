//
//  UITextView+Zoom.m
//  TextViewZoom
//
//  Created by 吾在 on 12-10-25.
//  Copyright (c) 2012年 吾在. All rights reserved.
//

#import "UITextView+Zoom.h"


@implementation UITextView (Zoom)
- (void)zoom
{
    if ([self.text length]) {
        CGRect frame = self.frame;
        CGSize size = [self.text sizeWithFont:self.font];
        CGFloat width = frame.size.width-self.font.capHeight;
        NSInteger line = size.width/width;
        while (size.width > line * width) {
            line++;
        }
        NSRange range = {0,1};
        for (int index = 0; index < [self.text length]; index ++) {
            range.location = index;
            if ([[self.text substringWithRange:range] isEqualToString:@"\n"]) {
                line ++;
            }
        }
        frame.size.height = line * self.font.lineHeight + self.font.ascender + self.font.descender;
        self.frame = frame;
    }
    else
    {
        CGRect frame = self.frame;
        frame.size.height = 0;
        self.frame = frame;
    }
}
@end
