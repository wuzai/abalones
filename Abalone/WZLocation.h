//
//  WZLocation.h
//  Abalone
//
//  Created by 吾在 on 13-5-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
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
