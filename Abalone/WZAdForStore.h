//
//  WZAd+ForStore.h
//  Abalone
//
//  Created by wz on 13-6-24.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZAd.h"
#import "WZNetworkHelper.h"
#import "WZStore.h"

extern  NSString *const kFetchAdsForStoreSuccessNotification;
extern  NSString *const kFetchAdsForStoreFailNotification;

@interface WZAdForStore :NSObject <WZNetworkBeggar>

+ (void) fetchAdsForStore:(WZStore *)store;
@end
