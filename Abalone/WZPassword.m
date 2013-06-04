//
//  WZPassword.m
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZPassword.h"
#import "RKObjectMapping+Null.h"
#import "WZKeychain.h"
#import "WZUser+Me.h"

NSString *const kWZOldPasswordKey = @"old_password";
NSString *const kWZNewPasswordKey = @"new_password";

NSString *const WZUpdatePasswordSucceedNotification = @"UpdatePasswordSucceed";
NSString *const WZUpdatePasswordFailedNotification = @"UpdatePasswordFailed";

@implementation WZPassword
#pragma mark - Protocol

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"password";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [RKObjectMapping nullMapping];
}

+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:kWZOldPasswordKey,kWZNewPasswordKey, nil];
    return mapping;
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZUpdatePasswordSucceedNotification;
}

+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZUpdatePasswordFailedNotification;
}

+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method
{
    NSString *message = nil;
    switch (statusCode) {
        case 410:
            message = @"密码错误";
            break;
        case 404:
            message = @"用户不存在";
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark - Interface
+ (BOOL)replace:(NSString *)oldPassword with:(NSString *)password
{
    WZUser *me = [WZUser me];
    if (me) {
        WZKeychain *keychain = [WZKeychain keychain];
        [keychain prepareForUsername:keychain.username password:password];
        return [[WZNetworkHelper helper]help:[self class] with:nil object:@{@"gid":me.gid,kWZOldPasswordKey:oldPassword,kWZNewPasswordKey:password} by:RKRequestMethodPUT];
    }
    return NO;
}

#pragma mark - Callbacks
+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[WZKeychain keychain] synchronize];
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[WZKeychain keychain] invalid];
}
@end
