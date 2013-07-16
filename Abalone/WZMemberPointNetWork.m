//
//  WZMemberPointNetWork.m
//  Abalone
//
//  Created by 陈 海涛 on 13-7-15.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZMemberPointNetWork.h"
#import "RKObjectMapping+Null.h"
#import "WZMember+Mapping.h"

@implementation WZMemberPointNetWork

/* 会员积分转赠
 >* 请求方式 ： POST
 >* 路由地址 ： /api/v1/memberPointToMember
 >* 请求接受类型 ： application/json
 >* 请求实体 : {"fromMember_id":"转赠人Id","toUserName":"接收人名称","point":"转赠积分数","merchant_id":"会员所属商户Id"}
 >* 返回代码JSON实体 : {}
 >* 返回值 ：
 * 200 - 成功
 * 400 - 请求的参数有问题
 * 403 - 转赠失败
 * 404 - 会员未找到/积分记录未找到，可能是数据错误
 */
+ (BOOL) sendMemberPoint:(NSInteger)pointNum fromMember:(NSString *)fromMemberID toUserName:(NSString *)toUserName inMerchant:(NSString *)merchantID
{
    NSDictionary *dic = @{@"fromMember_id":fromMemberID,@"toUserName":toUserName,@"point":[NSNumber numberWithInteger:pointNum],@"merchant_id":merchantID};
    return [[WZNetworkHelper helper]  help:[self class] with:nil object:dic by:RKRequestMethodPOST];
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}
+ (NSString *)resoucePath
{
    return @"memberPointToMember";
}
+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [WZMember memberMapping];
}

+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"fromMember_id",@"toUserName",@"point",@"merchant_id", nil];
    return mapping;
}

+(void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSENDMEMBERPOINTTOUSERSUCCESSNOTIFICTION object:results];
}

+(void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSENDMEMBERPOINTTOUSERFAILNOTIFICTION object:[error localizedDescription]];
}


@end
