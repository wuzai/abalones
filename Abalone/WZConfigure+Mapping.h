//
//  WZConfigure+Mapping.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-16.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZConfigure.h"
#import <RestKit/RestKit.h>

@interface WZConfigure (Mapping)

+ (RKManagedObjectMapping *)configMapping;

@end
