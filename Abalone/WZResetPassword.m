//
//  WZResetPassword.m
//  Abalone
//
//  Created by 吾在 on 13-5-9.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZResetPassword.h"
#import "WZKeychain.h"
#import "WZUser+Mapping.h"

NSString *const WZResetPasswordSucceedNotification = @"ResetPasswordSucceed";
NSString *const WZResetPasswordFailedNotification = @"ResetPasswordFailed";

@implementation WZResetPassword
#pragma mark -
+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"resetPassword";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [WZUser userMapping];
}

+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"cellphone",@"password",@"captcha", nil];
    return mapping;
}

+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method
{
    NSString *message = nil;
    switch (statusCode) {
        case 400:
            message = @"手机号码不正确";
            break;
        case 404:
            message = @"该号码尚未注册";
            break;
        case 410:
            message = @"验证码错误";
            break;
        default:
            break;
    }
    return message;
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZResetPasswordSucceedNotification;
}

+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZResetPasswordFailedNotification;
}

+ (BOOL)resetPassword:(NSString *)password forUser:(NSString *)username withCaptcha:(NSString *)captcha
{
    [[WZKeychain keychain] prepareForUsername:username password:password];
    return [[WZNetworkHelper helper] help:[self class] with:nil object:@{@"cellphone": username,@"password":password,@"captcha":captcha} by:RKRequestMethodPUT];
}

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[WZKeychain keychain] synchronize];
}

@end
