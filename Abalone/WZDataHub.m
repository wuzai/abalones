//
//  WZDataHub.m
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZDataHub.h"
#import "WZUser+Networks.h"
#import "WZLogin.h"
#import "WZMerchant+Networks.h"
#import "WZUser+Me.h"
#import "WZAd+Networks.h"

@interface WZDataHub ()
- (void)merchantsListGetSucceed:(NSNotification *)notification;
//- (void)merchantsListGetFailed:(NSNotification *)notification;
- (void)userDidLogin:(NSNotification *)notification;
@end

@implementation WZDataHub
+ (instancetype)hub
{
    static WZDataHub *_hub = nil;
    @synchronized (_hub) {
        if (!_hub) {
            _hub = [[self class] new];
        }
    }
    return _hub;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin:) name:WZLoginSucceedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(merchantsListGetSucceed:) name:SynMerchantListSuccess object:nil];
    }
    return self;
}

- (void)startup
{
    [WZMerchant fetchMerchantList];
    [[WZUser me] fetch];
}

#pragma mark - 
- (void)merchantsListGetSucceed:(NSNotification *)notification
{
    [WZAd download];
    [[WZUser me] downloadMessages];
}

- (void)userDidLogin:(NSNotification *)notification
{
    [[WZUser me] downloadMessages];
}
@end
