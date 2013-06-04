//
//  WZUser+Me.m
//  Abalone
//
//  Created by 吾在 on 13-4-10.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUser+Me.h"
#import <RestKit/RestKit.h>
#import "WZKeychain.h"

@implementation WZUser (Me)

+(WZUser *)me
{
    NSString *phone = [WZKeychain keychain].username;
    if (phone) {
        return [[self class] objectWithPredicate:[NSPredicate predicateWithFormat:@"username==%@",phone]];
    }
    return nil;
}

+ (void)leave
{
    [[WZKeychain keychain] prepareForUsername:nil password:nil];
    [[WZKeychain keychain] synchronize];
}
@end
