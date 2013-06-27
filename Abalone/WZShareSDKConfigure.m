//
//  WZShareSDKConfigure.m
//  Abalone
//
//  Created by 吾在 on 13-5-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZShareSDKConfigure.h"
#import <ShareSDK/ShareSDK.h>
#import"WXApi.h"
#import<QQApi/QQApi.h>

@implementation WZShareSDKConfigure

+(void)sharedInit
{
    
    [ShareSDK registerApp:@"3b407e1939c"];
    [ShareSDK connectWeChatWithAppId:@"wx6dd7a9b94f3dd72a" wechatCls:[WXApi class]];
    [ShareSDK connectQQWithAppId:@"QQ0F0A941E" qqApiCls:[QQApi class]];
    
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"3201194191" appSecret:@"0334252914651e8f76bad63337b3b78f"
                             redirectUri:@"http://appgo.cn"];
    //添加腾讯微博应用
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650" appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"];
    //添加QQ空间应用
    [ShareSDK connectQZoneWithAppKey:@"100371282" appSecret:@"aed9b0303e3ed1e27bae87c33761161d"];
    //添加网易微博应用
    [ShareSDK connect163WeiboWithAppKey:@"T5EI7BXe13vfyDuy" appSecret:@"gZxwyNOvjFYpxwwlnuizHRRtBRZ2lV1j"
                            redirectUri:@"http://www.shareSDK.cn"];
    //添加搜狐微博应用
    [ShareSDK connectSohuWeiboWithConsumerKey:@"SAfm TG1blxZY3HztESWx"
                               consumerSecret:@"yfTZf)!rVwh*3dqQuVJVs UL37!F)!yS9S!Orcs ij" redirectUri:@"http://www.sharesdk.cn"];
  
    //添加豆瓣应用
    [ShareSDK connectDoubanWithAppKey:@"07d08fbfc1210e931771af3f43632bb9" appSecret:@"e32896161e72be91"
                          redirectUri:@"http://dev.kumoway.com/braininference/infos.php"];
    //添加人人网应用
    [ShareSDK connectRenRenWithAppKey:@"fc5b8aed373c4c27a05b712acba0f8c3" appSecret:@"f29df781abdd4f49beca5a2194676ca4"];
    //添加开心网应用
    [ShareSDK connectKaiXinWithAppKey:@"358443394194887cee81ff5890870c7c"
                            appSecret:@"da32179d859c016169f66d90b6db2a23" redirectUri:@"http://www.sharesdk.cn/"];
    //添加Ins tapaper应用
    [ShareSDK connectInstapaperWithAppKey:@"4rDJORm cOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc61FA" appSecret:@"GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe"];
    //添加有道云笔记应用
    [ShareSDK connectYouDaoNoteWithConsumerKey:@"dcde25dca105bcc36884ed4534dab940" consumerSecret:@"d98217b4020e7f1874263795f44838fe"
                                   redirectUri:@"http://www.sharesdk.cn/"];
    //添加Facebook应用
    [ShareSDK connectFacebookWithAppKey:@"107704292745179" appSecret:@"38053202e1a5fe26c80c753071f0b573"];
    //添加Twitter应用
    [ShareSDK connectTwitterWithConsumerKey:@"mnTGqtXk0TYMXYTN7qUxg"
                             consumerSecret:@"ROkFqr8c3m1HXqS3rm3TJ0WkAJuwBOSaWhPbZ9Ojuc" redirectUri:@"http://www.sharesdk.cn"]; 
}

@end
