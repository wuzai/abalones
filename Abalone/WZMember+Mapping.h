//
//  WZMember+Mapping.h
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMember.h"
#import <RestKit/RestKit.h>

@interface WZMember (Mapping)
+(RKObjectMapping *)memberMapping;
@end
