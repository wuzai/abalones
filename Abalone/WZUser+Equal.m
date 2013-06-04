//
//  WZUser+Equal.m
//  Abalone
//
//  Created by 吾在 on 13-5-7.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUser+Equal.h"

@implementation WZUser (Equal)
- (BOOL)isEqualToUser:(WZUser *)user
{
    return [self.gid isEqualToString:user.gid];
}
@end
