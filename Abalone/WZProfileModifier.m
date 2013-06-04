//
//  WZProfileModifier.m
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZProfileModifier.h"
#import "WZUser+Me.h"
#import <RestKit/RestKit.h>

NSString *const kWZUserProfileNameKey = @"name";
NSString *const kWZUserProfileGenderKey = @"gender";
NSString *const kWZUserProfileEmailKey = @"email";
NSString *const kWZUserProfileBirthKey = @"birth";


@interface WZProfileModifier ()
{
    NSMutableDictionary *_changes;
}
@end
@implementation WZProfileModifier
+ (instancetype)modifier
{
    static WZProfileModifier *_modifier = nil;
    @synchronized (_modifier) {
        if (!_modifier) {
            _modifier = [[self class] new];
        }
    }
    return _modifier;
}

- (id)init
{
    self = [super init];
    if (self) {
        _changes = [NSMutableDictionary new];
    }
    return self;
}

- (NSDictionary *)changes
{
    return [_changes count]?[NSDictionary dictionaryWithDictionary:_changes]:nil;
}

- (void)synchronize
{
    WZUser *me = [WZUser me];
    if (me) {
        NSArray *keys = [_changes allKeys];
        for (NSString *key in keys) {
            if ([me respondsToSelector:NSSelectorFromString(key)]) {
                [me setValue:[_changes objectForKey:key] forKey:key];
            }
        }
        [[RKObjectManager sharedManager].objectStore save:nil];
    }
    [self invalid];
}

- (void)invalid
{
    [_changes removeAllObjects];
}

- (void)invalidChangeForKey:(NSString *)key
{
    [_changes removeObjectForKey:key];
}

- (void)prepareChange:(id)value forKey:(NSString *)key
{
    WZUser *me = [WZUser me];
    if ([me respondsToSelector:NSSelectorFromString(key)]) {
        id old = [me valueForKey:key];
        BOOL equal = NO;
        if ([value isKindOfClass:[NSString class]]) {
            equal = [value isEqualToString:old];
        }
        else if ([value isKindOfClass:[NSDate class]])
        {
            equal = [value isEqualToDate:old];
        }
        else if ([value isKindOfClass:[NSNumber class]])
        {
            equal = [value isEqualToNumber:old];
        }
        else
        {
            equal = ([value isEqual:old]||value==old);
        }
        if (!equal) {
            [_changes setObject:value forKey:key];
        }
    }
    
}


@end
