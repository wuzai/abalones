//
//  WZMemberService+Mapping.h
//  Abalone
//
//  Created by chen  on 13-7-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZMemberService.h"
#import <RestKit/RestKit.h>
@interface WZMemberService (Mapping)
+ (RKManagedObjectMapping *)memberServiceMapping;
@end
