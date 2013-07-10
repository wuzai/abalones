//
//  WZAd+Networks.m
//  Abalone
//
//  Created by 吾在 on 13-4-19.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZAd+Networks.h"
#import "WZAd+Mapping.h"
#import "WZMerchant.h"
#import "WZServiceItem.h"

NSString *const WZAdvertisementsDownloadSucceedNotification = @"AdvertisementsDownloadSucceed";
NSString *const WZAdvertisementsDownloadFailedNotification = @"AdvertisementsDownloadFailed";

static NSString *const kUserDefaultsAdverisementsKey = @"AdvertisementsTimeStamp";

@implementation WZAd (Networks)
#pragma mark - Protocol
+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"advertisements";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [WZAd advertisementMapping];
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZAdvertisementsDownloadSucceedNotification;
}

#pragma mark - Interface
+ (BOOL)download
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *timeStamp = [defaults objectForKey:kUserDefaultsAdverisementsKey];
    if (!timeStamp) {
        timeStamp = [NSDate dateWithTimeIntervalSince1970:0];
        [defaults setObject:timeStamp forKey:kUserDefaultsAdverisementsKey];
        [defaults synchronize];
    }
    return [[WZNetworkHelper helper] help:[self class] with:@{kWZTimeStampKey:timeStamp} object:nil by:RKRequestMethodGET];
}

#pragma mark - Callbacks
+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSDate date] forKey:kUserDefaultsAdverisementsKey];
    [defaults synchronize];
    if ([results count]) {
        for (WZAd *ad in results) {
            if (ad.serviceItem && ad.merchant) {
                ad.serviceItem.merchant = ad.merchant;
            }
        }
        [[RKObjectManager sharedManager].objectStore save:nil];
    }
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter]  postNotificationName:WZAdvertisementsDownloadFailedNotification object:error];
}
@end
