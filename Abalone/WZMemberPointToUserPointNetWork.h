//
//  WZMemberPointToUserPointNetWork.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-15.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

#define kMEMBERPOINTTOUSERPOINTSUCCESSNOTIFICTION @"memberPointToUserPointSuccess"
#define kMEMBERPOINTTOUSERPOINTFAILNOTIFICTION @"memberPointToUserPointFail"


@interface WZMemberPointToUserPointNetWork : NSObject <WZNetworkBeggar>

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

+(BOOL) member:(NSString *)memberID setMemberPointToUserPoint:(NSInteger)pointNum;

@end
