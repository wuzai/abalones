//
//  WZKeychain.m
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZKeychain.h"

static WZKeychain *_keychain = nil;
static NSString *const kWZUserDefaultsUernameKey = @"Username";
static NSString *const kWZUserDefaultsPasswordKey = @"Password";

@interface WZKeychain ()
{
    NSString *_username;
    NSString *_password;
}
@end
@implementation WZKeychain

+ (instancetype)keychain
{
    @synchronized (_keychain) {
        if (!_keychain) {
            _keychain = [WZKeychain new];
        }
    }
    return _keychain;
}

- (NSString *)username
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kWZUserDefaultsUernameKey];
}

- (NSString *)password
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kWZUserDefaultsPasswordKey];
}

- (void)prepareForUsername:(NSString *)username password:(NSString *)password
{
    _username = username;
    _password = password;
}

- (void)synchronize
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (_username) {
        [defaults setObject:_username forKey:kWZUserDefaultsUernameKey];
    }
    else
    {
        [defaults removeObjectForKey:kWZUserDefaultsUernameKey];
    }
    if (_password) {
        [defaults setObject:_password forKey:kWZUserDefaultsPasswordKey];
    }
    else
    {
        [defaults removeObjectForKey:kWZUserDefaultsPasswordKey];
    }
    [defaults synchronize];
}

- (void)invalid
{
    _username = nil;
    _password = nil;
}

@end
