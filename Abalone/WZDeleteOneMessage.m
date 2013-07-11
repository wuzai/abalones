//
//  WZDeleteOneMessage.m
//  Abalone
//
//  Created by 陈 海涛 on 13-7-9.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZDeleteOneMessage.h"
#import "RKObjectMapping+Null.h"
#import "WZMessage+Mapping.h"
#import "WZuser.h"

@implementation WZDeleteOneMessage

+(BOOL)deleteOneMessage:(WZMessage *)message;//deleteOneMessageSuccess
{
    NSDictionary *dic = @{@"sendMessageRecord_id":message.gid};
    
    return [[WZNetworkHelper helper] help:[self class] with:dic object:nil by:RKRequestMethodGET];
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}
+ (NSString *)resoucePath
{
    return @"deleteSendMessageRecords";
}
+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [RKObjectMapping nullMapping];
}

+(void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDELETEONEMESSAGESUCCESSNOTIFICTION object:results];
}

+(void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDELETEONEMESSAGEFAILNOTIFICTION object:error];
}

@end
