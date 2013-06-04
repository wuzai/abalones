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
    static NSString *const host = @"http://172.168.1.110:3000";
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
}

@end




















