//
//  WZCommentNetWorker.h
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZUser.h"
#import "WZMerchant.h"
#import "WZComment+Mapping.h"
#import "WZNetworkHelper.h"

extern NSString *const SendCommentSuccess;
extern NSString *const SendCommentFail;

@interface WZCommentNetWorker : NSObject <WZNetworkBeggar>
+ (void)sendCommentByUser:(WZUser *)user toMerchant:(WZMerchant *)merchant withContent:(NSString *)content andRating:(NSNumber *)rating;
@end
