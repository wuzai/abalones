//
//  WZUser+Me.h
//  Abalone
//
//  Created by 吾在 on 13-4-10.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUser.h"

@interface WZUser (Me)
+ (WZUser *)me;
+ (void)leave;
@end
