//
//  WZUseService.m
//  Abalone
//
//  Created by 吾在 on 13-5-9.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUseService.h"
#import "RKObjectMapping+Null.h"

NSString *const kUseServiceSuccessNotificationKey = @"useServiceSuccess";
NSString *const kUseServiceFailNotificationKey =@"useServiceFail";

@implementation WZUseService
+(BOOL)userviceWithType:(NSString *)type forServiceID:(NSString *)serviceID inStoreID:(NSString *)storeID byUserID:(NSString *)userID
{
  return   [[WZNetworkHelper helper] help:[self class] with:@{@"type":type , @"activity_id":serviceID ,@"store_id":storeID,@"user_id":userID} object:nil by:RKRequestMethodGET];
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"useServiceItem";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [mapping mapAttributes:@"error",@"code", nil];
    return mapping;
}

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    NSString *message = nil;
    if (loader.response.statusCode == 203) {
        message = [results lastObject][@"error"];
        [[NSNotificationCenter defaultCenter]postNotificationName:kUseServiceFailNotificationKey object:message];
    }else if(loader.response.statusCode == 200){
        message  = [results lastObject][@"code"];
        [[NSNotificationCenter defaultCenter]postNotificationName:kUseServiceSuccessNotificationKey object:message];
    }
   
    
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
     NSString *message = nil;
    if (loader.response.statusCode == 404) {
        message = @"相应服务未能找到";
    }else if(loader.response.statusCode == 400){
        message = @"使用失败！";
    }else{
        message = error.localizedDescription;
    }
  
    [[NSNotificationCenter defaultCenter] postNotificationName:kUseServiceFailNotificationKey object:message];
}

@end
