//
//  WZUser+Gender.m
//  Abalone
//
//  Created by 吾在 on 13-4-11.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUser+Gender.h"

@implementation WZUser (Gender)
- (BOOL)isMale
{
    return [self.gender isEqualToString:@"男"];
}

- (void)setMale:(BOOL)male
{
    NSString *value = male?@"男":@"女";
    self.gender = value;
}
@end
