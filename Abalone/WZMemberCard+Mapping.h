//
//  WZMemberCard+Mapping.h
//  Abalone
//
//  Created by 吾在 on 13-4-26.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMemberCard.h"
#import <RestKit/RestKit.h>
#import "WZUser+Mapping.h"

@interface WZMemberCard (Mapping)
+ (RKObjectMapping *)memberCardMapping;
@end
