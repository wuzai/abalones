//
//  WZServiceItem+Mapping.h
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZServiceItem.h"
#import  <RestKit/RestKit.h>

@interface WZServiceItem (Mapping)
+ (RKObjectMapping *)serviceItemMapping;
@end
