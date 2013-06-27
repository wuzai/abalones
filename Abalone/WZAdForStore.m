//
//  WZAd+ForStore.m
//  Abalone
//
//  Created by wz on 13-6-24.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZAdForStore.h"
#import "WZAd+Mapping.h"
#import "WZStore.h"
#import "WZmerchant.h"

NSString *const kFetchAdsForStoreSuccessNotification = @"fetchAdsForStoreSuccessNotification";
NSString *const kFetchAdsForStoreFailNotification = @"fetchAdsForStoreFailNotification";

@implementation WZAdForStore

#pragma mark - Protocol
+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"findAdvertisementOfMerchant";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [WZAd advertisementMapping];
}

+ (void) fetchAdsForStore:(WZStore *)store
{
    //merchant_id="商户Id"&store_id=
    NSDictionary *dic = @{@"merchant_id":store.merchant.gid,@"store_id":store.gid};
    [[WZNetworkHelper helper] help:[self class] with:dic object:nil by:RKRequestMethodGET];
}

#pragma mark - Callbacks
+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kFetchAdsForStoreSuccessNotification object:nil userInfo:@{@"results": results}];
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kFetchAdsForStoreFailNotification object:nil];
}

@end
