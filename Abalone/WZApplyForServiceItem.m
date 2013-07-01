//
//  WZApplyForServiceItem.m
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZApplyForServiceItem.h"
#import <RestKit/RestKit.h>
#import "WZMember+Mapping.h"

NSString *const ApplyServiceItemSuccess = @"applyServiceItemSuccess";
NSString *const ApplyServiceItemFail = @"applyServiceItemFail";

@implementation WZApplyForServiceItem
+(void) applyForSericeItem:(WZServiceItem *)serviceItem forUser:(WZUser*)user InMerchant:(WZMerchant*)merchant
{
    NSDictionary *dic = @{@"serviceItem_id":serviceItem.gid,@"merchant_id":merchant.gid,@"user_id":user.gid};
    [[WZNetworkHelper helper]help:[self class] with:nil object:dic by:RKRequestMethodPOST];
}

+(RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [WZMember memberMapping];
}

+(RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"serviceItem_id",@"merchant_id",@"user_id", nil];
    return mapping;
}

+(NSString *)resoucePath
{
    return @"applicableServiceItem";
}

+(RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+(void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    NSLog(@"%@",results);
    
    if (loader.response.statusCode == 203) {
         [[NSNotificationCenter defaultCenter] postNotificationName:ApplyServiceItemFail object:@"申领请求已发出，等待商户审核."];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:ApplyServiceItemSuccess object:results];
    }
    
}

+(void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ApplyServiceItemFail object:error.localizedDescription];
}

@end
