//
//  WZLocation+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZLocation+Mapping.h"

@implementation WZLocation (Mapping)
+ (RKObjectMapping *)locationMapping
{
    RKManagedObjectMapping *locationMapping = [RKManagedObjectMapping mappingForClass:[WZLocation class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    [locationMapping mapAttributes:@"longitude",@"latitude",@"relevantText", nil];
    
    return locationMapping;
}
@end
