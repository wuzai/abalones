//
//  WZStore+NetWorks.h
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStore.h"
#import "WZNetworkHelper.h"

@interface WZStore (NetWorks)<WZNetworkBeggar>
- (BOOL)fetchStore;
@end
