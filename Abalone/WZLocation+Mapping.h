//
//  WZLocation+Mapping.h
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZLocation.h"
#import <RestKit/RestKit.h>

@interface WZLocation (Mapping)
+ (RKObjectMapping *)locationMapping;
@end
