//
//  WZSignup.m
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZSignup.h"
#import "WZUser+Mapping.h"
#import "WZKeychain.h"

NSString *const WZRegisterSucceedNotification = @"RegisterSucceed";
NSString *const WZRegisterFailedNotification = @"RegisterFailed";

@implementation WZSignup
#pragma mark - Protocol
+ (NSString *)resoucePath
{
    return @"signup";
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
    return WZRegisterSucceedNotification;
}

+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZRegisterFailedNotification;
}

+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method
{
    NSString *message = nil;
    switch (statusCode) {
        case 201: {
            //成功
        }   break;
        case 400: {
            message = @"验证码错误";
        }   break;
        case 409: {
            message = @"手机号已经注册过了";
        }   break;
        default:
            break;
    }
    return message;
}

#pragma mark - Interface
+ (BOOL)signup:(NSString *)username withPassword:(NSString *)password andCaptcha:(NSString *)captcha
{
    [[WZKeychain keychain] prepareForUsername:username password:password];
    return [[WZNetworkHelper helper] help:[self class] with:nil object:@{@"username":username,@"password":password,@"captcha":captcha} by:RKRequestMethodPOST];
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
