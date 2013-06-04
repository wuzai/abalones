//
//  WZPointRecord+Mapping.h
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZPointRecord.h"
#import <RestKit/RestKit.h>

@interface WZPointRecord (Mapping)
+(RKObjectMapping *)pointRecordMapping;
@end
