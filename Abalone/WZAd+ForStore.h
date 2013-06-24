//
//  WZAd+ForStore.h
//  Abalone
//
//  Created by 陈 海涛 on 13-6-24.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZAd.h"
#import "WZNetworkHelper.h"
#import "WZStore.h"

extern  NSString *const kFetchAdsForStoreSuccessNotification;
extern  NSString *const kFetchAdsForStoreFailNotification;

@interface WZAd (ForStore) <WZNetworkBeggar>

+ (void) fetchAdsForStore:(WZStore *)store;
@end
