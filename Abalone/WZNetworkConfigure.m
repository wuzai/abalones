//
//  WZNetworkConfigure.m
//  Abalone
//
//  Created by 吾在 on 13-4-10.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZNetworkConfigure.h"
#import <RestKit/RestKit.h>
#import "WZKeychain.h"

@implementation WZNetworkConfigure

+(void)startup
{
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
   // RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
    //服务器配置
    //内网开发服务器
    //static NSString *const host = @"http://172.168.1.110:3000";
    //内网测试服务器
   // static NSString *const host = @"http://172.168.1.100:3000";
    //外网服务器
    static NSString *const host = @"http://www.5zzg.com/sys";
    
    NSURL *baseURL = [NSURL URLWithString:host];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"Abalone.sqlite" usingSeedDatabaseName:nil managedObjectModel:nil delegate:self];
    objectManager.acceptMIMEType = RKMIMETypeJSON;
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    NSString *username = [WZKeychain keychain].username;
    NSString *password = [WZKeychain keychain].password;
    if (username && password) {
        RKClient *client = objectManager.client;
        client.authenticationType = RKRequestAuthenticationTypeHTTPBasic;
        client.username = username;
        client.password = password;
    }
    
//    objectManager.client.disableCertificateValidation = YES;
    //update date format
    //2012-02-14T13:36:55.000Z
    [RKObjectMapping addDefaultDateFormatterForString:@"yyyy-MM-dd'T'hh:mm:ss.SSS'Z'" inTimeZone:nil];
//    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
//    
//    [errorMapping mapKeyPath:@"error" toAttribute:@"error"];
//    [[RKObjectManager sharedManager].mappingProvider setMapping:errorMapping forKeyPath:@"error"];
}

@end




















