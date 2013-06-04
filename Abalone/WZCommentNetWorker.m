//
//  WZCommentNetWorker.m
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZCommentNetWorker.h"
#import <RestKit/RestKit.h>


NSString *const SendCommentSuccess = @"发送评论成功";
NSString *const SendCommentFail = @"发送评论失败";

@implementation WZCommentNetWorker
+ (void)sendCommentByUser:(WZUser *)user toMerchant:(WZMerchant *)merchant withContent:(NSString *)content andRating:(NSNumber *)rating
{
    NSDictionary *dic = @{@"merchant_id":merchant.gid,@"user_id":user.gid,@"content":content,@"rating":rating};
    [[WZNetworkHelper helper]help:[self class] with:nil object:dic by:RKRequestMethodPOST];
}

+(RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
   [mapping mapAttributes:@"merchant_id",@"user_id",@"content",@"rating", nil];
    return mapping;
}

+(NSString *)resoucePath
{
    return @"comments";
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [WZComment commentMapping];
}

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SendCommentSuccess object:results];
}
+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter]  postNotificationName:SendCommentFail object:error];
}



    
@end
