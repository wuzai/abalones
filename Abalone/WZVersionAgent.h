//
//  WZVersionAgent.h
//  Abalone
//
//  Created by 陈 海涛 on 13-9-22.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kupdateVersionKey @"updateVersionKey"

@interface WZVersionAgent : NSObject

@property (nonatomic,strong) NSString *appVersion;
@property (nonatomic,strong) NSString *appName;

- (void)checkVersionForUpdate;

- (BOOL)isUpdate;

+ (id)shareInstance;
@end
