//
//  WZSchemeManager.m
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZSchemeManager.h"
@interface WZSchemeManager ()
{
    NSMutableArray *_schemes;
}
@end

@implementation WZSchemeManager
+ (instancetype)manager
{
    static WZSchemeManager *_manager = nil;
    @synchronized (_manager) {
        if (!_manager) {
            _manager = [[self class] new];
        }
    }
    return _manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        _schemes = [NSMutableArray new];
    }
    return self;
}

- (BOOL)addScheme:(WZNetworkScheme *)scheme
{
    if (![self schemeForRoute:scheme.route method:scheme.method]) {
        scheme.busy = YES;
        [_schemes addObject:scheme];
    }
    return NO;
}

- (WZNetworkScheme *)schemeForRoute:(NSString *)route method:(RKRequestMethod)method
{
    for (WZNetworkScheme *scheme in _schemes) {
        NSLog(@"test: %@ and %@",scheme.route,route);
        if ([scheme.route isEqualToString:route]&&(scheme.method==method)) {
            return scheme;
        }
    }
    return nil;
}
@end
