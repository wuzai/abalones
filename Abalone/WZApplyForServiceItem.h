//
//  WZApplyForServiceItem.h
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"
#import "WZServiceItem.h"
#import "WZUser.h"
#import "WZMerchant.h"

extern NSString *const ApplyServiceItemSuccess;
extern NSString *const ApplyServiceItemFail;

@interface WZApplyForServiceItem : NSObject <WZNetworkBeggar>
+(void) applyForSericeItem:(WZServiceItem *)serviceItem forUser:(WZUser*)user InMerchant:(WZMerchant*)merchant;
@end
