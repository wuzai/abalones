//
//  WZDeleteUserMessage.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-9.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"
#import "WZUSer.h"
#import "WZMessage.h"

#define kDELETEUSERMESSAGESUCCESSNOTIFICTION @"deleteUserMessageSuccess"
#define kDELETEUSERMESSAGEFAILNOTIFICTION @"deleteUserMessageFail"

@interface WZDeleteUserMessage : NSObject  <WZNetworkBeggar>

+(BOOL)deleteMessagesForUser:(WZUser *)user;

@end
