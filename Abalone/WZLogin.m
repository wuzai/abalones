//
//  WZLogin.m
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZLogin.h"
#import "WZUser+Mapping.h"
#import "WZKeychain.h"

NSString *const WZLoginSucceedNotification = @"LoginSucceed";
NSString *const WZLoginFailedNotification = @"LoginFailed";

@implementation WZLogin
#pragma mark - Protocol

+ (NSString *)resoucePath
{
    return @"signin";
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [WZUser userMapping];
}

+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    return [WZUser registerMapping];
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZLoginSucceedNotification;
}

+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZLoginFailedNotification;
}

+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method
{
    NSString *message = nil;
    switch (statusCode) {
        case 200: {
            //成功
        }   break;
        case 400: {
            message = @"未获得手机号";
        }   break;
        case 404: {
            message = @"用户不存在";
        }   break;
        case 410: {
            message = @"密码错误";
        }   break;
        default:
            break;
    }
    return message;
}

#pragma mark - Interface
+ (BOOL)login:(NSString *)username withPassword:(NSString *)password
{
    [[WZKeychain keychain] prepareForUsername:username password:password];
    return [[WZNetworkHelper helper] help:[self class] with:nil object:@{@"username": username,@"password":password} by:RKRequestMethodPOST];
}

#pragma mark - Callbacks
+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    WZKeychain *keychain = [WZKeychain keychain];
    [keychain synchronize];
    RKClient *client = [[[self class] manager] client];
    client.authenticationType = RKRequestAuthenticationTypeHTTPBasic;
    client.username = keychain.username;
    client.password = keychain.password;
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[WZKeychain keychain] invalid];
}
@end
