//
//  WZMeteringCard+Mapping.h
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMeteringCard.h"
#import <RestKit/RestKit.h>

@interface WZMeteringCard (Mapping)
+ (RKObjectMapping *)meteringCardMapping;
@end
