//
//  WZUserPointNetWork.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-15.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

#define kSENDPOINTTOUSERSUCCESSNOTIFICTION @"sendPOintToUserSuccess"
#define kSENDPOINTTOUSERFAILNOTIFICTION @"sendPointToUserFail"

@interface WZUserPointNetWork : NSObject <WZNetworkBeggar>

/** 用户积分转赠
>* 请求方式 ： POST
>* 路由地址 ： /api/v1/userPointToUser
>* 请求接受类型 ： application/json
>* 请求实体 : {"fromUser_id":"转赠人Id","toUserName":"接收人名称","point":"转赠积分数"}
>* 返回代码JSON实体 : {}
>* 返回值 ：
* 200 - 成功
* 400 - 请求的参数有问题
* 403 - 转赠失败
* 404 - 会员未找到/积分记录未找到，可能是数据错误
 */
+(BOOL) UserPointSendToUser:(NSString *)toUserName fromUser:(NSString *)fromUserID withPoint:(NSInteger)pointNum;

@end







