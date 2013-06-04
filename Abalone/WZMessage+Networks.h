//
//  WZMessage+Networks.h
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessage.h"
#import "WZNetworkHelper.h"

extern NSString *const WZDownloadMessageSucceedNotification;
extern NSString *const WZDownloadMessageFailedNotification;

@class WZUser;
@interface WZMessage (Networks) <WZNetworkBeggar>
+ (BOOL)downloadMessagesForUser:(WZUser *)user;
@end
