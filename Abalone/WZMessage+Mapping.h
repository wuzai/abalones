//
//  WZMessage+Mapping.h
//  Abalone
//
//  Created by 吾在 on 13-4-19.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessage.h"
#import <RestKit/RestKit.h>

@interface WZMessage (Mapping)
+ (RKObjectMapping *)messageMapping;

+(RKObjectMapping *)serialMessageMapping;
@end
