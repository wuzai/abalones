//
//  WZMemberPointToUserPointNetWork.m
//  Abalone
//
//  Created by 陈 海涛 on 13-7-15.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZMemberPointToUserPointNetWork.h"
#import "RKObjectMapping+Null.h"

@implementation WZMemberPointToUserPointNetWork

/* 会员积分兑换
 >* 请求方式 ： POST
 >* 路由地址 ： /api/v1/memberPointToUser
 >* 请求接受类型 ： application/json
 >* 请求实体 : {"member_id":"会员Id","point":"要兑换的平台用户积分数"}
 >* 返回代码JSON实体 : {}
 >* 返回值 ：
 * 200 - 成功
 * 400 - 请求的参数有问题
 * 403 - 转赠失败
 * 404 - 会员未找到/积分记录未找到，可能是数据错误
 */

+(BOOL) member:(NSString *)memberID setMemberPointToUserPoint:(NSInteger)pointNum
{
    NSDictionary *dic = @{@"member_id":memberID,@"point":[NSNumber numberWithInteger:pointNum]};
    return [[WZNetworkHelper helper] help:[self class] with:nil object:dic by:RKRequestMethodPOST];
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}
+ (NSString *)resoucePath
{
    return @"memberPointToUser";
}
+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [RKObjectMapping nullMapping];
}

+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"member_id",@"point", nil];
    return mapping;
}

+(void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMEMBERPOINTTOUSERPOINTSUCCESSNOTIFICTION object:results];
}

+(void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMEMBERPOINTTOUSERPOINTFAILNOTIFICTION object:[error localizedDescription]];
}





@end
