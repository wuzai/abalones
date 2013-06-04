//
//  WZMessage+Image.m
//  Abalone
//
//  Created by 吾在 on 13-4-25.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessage+Image.h"

@implementation WZMessage (imageURL)
- (NSURL *)imageURL
{
    NSString *url = self.iconImage;
    return url?[NSURL URLWithString:url]:nil;
}
@end
