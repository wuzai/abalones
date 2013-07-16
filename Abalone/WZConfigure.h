//
//  WZConfigure.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-16.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZUser;

@interface WZConfigure : NSManagedObject

@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * pointLargessExplain;
@property (nonatomic, retain) NSDate * lastUpdateTime;
@property (nonatomic, retain) WZUser *user;

@end
