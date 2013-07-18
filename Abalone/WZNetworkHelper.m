//
//  WZNetworkHelper.m
//  Abalone
//
//  Created by 吾在 on 13-4-11.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZNetworkHelper.h"
#import "RKObjectMapping+Null.h"
#import "WZSchemeManager.h"
#import "RKObjectLoader+Scheme.h"

NSString *kWZNetworkLoaderKey = @"Loader";
NSString *kWZNetworkResultsKey = @"Results";
NSString *kWZNetworkErrorKey = @"Error";

NSString *kWZGeneralIdentifierKey = @"gid";
NSString *kWZTimeStampKey = @"timestamp";

@interface WZNetworkHelper () <RKObjectLoaderDelegate>
@end

@implementation WZNetworkHelper 
+ (instancetype)helper
{
    static WZNetworkHelper *_helper = nil;
    @synchronized (_helper) {
        if (!_helper) {
            _helper = [[self class] new];
        }
    }
    return _helper;
}

- (BOOL)help:(Class<WZNetworkBeggar>)beggar with:(NSDictionary *)query object:(id)object by:(RKRequestMethod)method
{
    static NSString *const prefix = @"/api/v1/";
    RKObjectManager *manager = [beggar manager];
    NSString *path = [beggar resoucePath];

    if ([object respondsToSelector:NSSelectorFromString(kWZGeneralIdentifierKey)] || [object isKindOfClass:[NSDictionary class]]) {
        NSString *gid = [object valueForKey:kWZGeneralIdentifierKey];
        if (gid) {
            path = [NSString stringWithFormat:@"%@/%@",path,gid];
        }
    }
    
    WZNetworkScheme *scheme = [[WZSchemeManager manager] schemeForRoute:path method:method];
    if (scheme) {
        if ([scheme isBusyNow]) {
            return NO;
        }
        scheme.busy = YES;
    }
    else {
        scheme = [WZNetworkScheme new];
        scheme.route = path;
        scheme.method = method;
        scheme.beggar = beggar;
        [[WZSchemeManager manager] addScheme:scheme];
    }
    path = [NSString stringWithFormat:@"%@%@",prefix,path];
    if (query) {
        path = [path stringByAppendingQueryParameters:query];
    }
    [manager loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader *loader) {
        loader.delegate = self;
        loader.method = method;
        RKObjectMapping *serial = [RKObjectMapping nullMapping];
        if ([(id)beggar respondsToSelector:@selector(sourceMappingForMethod:)]) {
            serial = [beggar sourceMappingForMethod:method];
        }
        loader.serializationMapping = serial;
        loader.sourceObject = object;
        loader.objectMapping = [beggar objectMappingForMethod:method];
    }];
    return YES;
}
     
#pragma mark - delegate
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    WZNetworkScheme *scheme = objectLoader.scheme;
    Class<WZNetworkBeggar> beggar = scheme.beggar;
    scheme.busy = NO;
    if (error.code == -1001 || error.code ==-1004 ||error.code == 2) {
        NSLog(@"%@",error.userInfo.allKeys.lastObject);
        NSMutableDictionary *details = [NSMutableDictionary dictionary];
         [details setValue:NETWORKERROR forKey:NSLocalizedDescriptionKey];
        error = [NSError errorWithDomain:error.domain code:error.code userInfo:details];
    }
    
    if ([(id)beggar respondsToSelector:@selector(failedIn:withError:)]) {
        [beggar failedIn:objectLoader withError:error];
    }
    
    if ([(id)beggar respondsToSelector:@selector(failedNotificationNameForPath:method:)]) {
        NSString *notificationName = [beggar failedNotificationNameForPath:scheme.route method:scheme.method];
        if (notificationName) {
            NSString *message = nil;
            if ([(id)beggar respondsToSelector:@selector(messageForStatusCode:path:method:)]) {
                message = [beggar messageForStatusCode:objectLoader.response.statusCode path:scheme.route method:scheme.method];
            }            
            if (!message) {
                switch (error.code) {
                    case -1001:
                        message = @"连接超时";
                        break;
                    case -1004:
                        message = @"没有服务";
                        break;
                    case 2:
                        message = @"没有网络";
                        break;
                    default:
                        break;
                }
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:message userInfo:@{kWZNetworkLoaderKey: objectLoader,kWZNetworkErrorKey:error}];
        }
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    WZNetworkScheme *scheme = objectLoader.scheme;
    Class<WZNetworkBeggar> beggar = scheme.beggar;
    scheme.busy = NO;
    if ([(id)beggar respondsToSelector:@selector(succeedIn:withResults:)]) {
        [beggar succeedIn:objectLoader withResults:objects];
    }
    if ([(id)beggar respondsToSelector:@selector(succeedNotificationNameForPath:method:)]) {
        NSString *notificationName = [beggar succeedNotificationNameForPath:scheme.route method:scheme.method];
        if (notificationName) {
            NSString *message = nil;
            if ([(id)beggar respondsToSelector:@selector(messageForStatusCode:path:method:)]) {
                message = [beggar messageForStatusCode:objectLoader.response.statusCode path:scheme.route method:scheme.method];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:message userInfo:@{kWZNetworkLoaderKey: objectLoader,kWZNetworkResultsKey:objects}];
        }
    }
}
@end
