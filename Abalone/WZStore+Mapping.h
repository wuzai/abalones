//
//  WZStore+Mapping.h
//  Abalone
//
//  Created by 吾在 on 13-4-18.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStore.h"
#import <RestKit/RestKit.h>

@interface WZStore (Mapping)
+(RKObjectMapping *)storeMapping;
@end
