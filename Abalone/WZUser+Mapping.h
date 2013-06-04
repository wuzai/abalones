//
//  WZUser+Mapping.h
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUser.h"
#import <RestKit/RestKit.h>

@interface WZUser (Mapping)
+ (RKObjectMapping *)userMapping;
+ (RKObjectMapping *)registerMapping;
+ (RKObjectMapping *)serialMapping;
+ (RKObjectMapping *)serviceMapping;
@end
