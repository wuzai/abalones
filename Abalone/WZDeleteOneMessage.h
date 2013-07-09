//
//  WZDeleteOneMessage.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-9.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"
#import "WZUSer.h"
#import "WZMessage.h"

#define kDELETEONEMESSAGESUCCESSNOTIFICTION @"deleteOneMessageSuccess"
#define kDELETEONEMESSAGEFAILNOTIFICTION @"deleteOneMessageFail"

@interface WZDeleteOneMessage : NSObject <WZNetworkBeggar>

+(BOOL)deleteOneMessage:(WZMessage *)message;

@end
