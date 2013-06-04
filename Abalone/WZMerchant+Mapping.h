//
//  WZMerchant+Mapping.h
//  Abalone
//
//  Created by 吾在 on 13-4-11.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMerchant.h"
#import <RestKit/RestKit.h>
#import "WZStore+Mapping.h"

@interface WZMerchant (Mapping)
+(RKObjectMapping *)merchntMapping;
@end
