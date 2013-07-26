//
//  WZLocation.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZStore;

@interface WZLocation : NSManagedObject

@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * relevantText;
@property (nonatomic, retain) WZStore *store;

@end
