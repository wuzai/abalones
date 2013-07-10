//
//  WZAd+Networks.h
//  Abalone
//
//  Created by 吾在 on 13-4-19.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZAd.h"
#import "WZNetworkHelper.h"

extern NSString *const WZAdvertisementsDownloadSucceedNotification;
extern NSString *const WZAdvertisementsDownloadFailedNotification;

@interface WZAd (Networks) <WZNetworkBeggar>
+ (BOOL)download;
@end
