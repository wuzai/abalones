//
//  WZRegulation.m
//  Abalone
//
//  Created by 吾在 on 13-5-8.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZRegulation.h"

static NSString *const kWZRegulationFileName = @"regulation";

@interface WZRegulation ()
+ (NSString *)filePath;
@end

@implementation WZRegulation
@synthesize pictures = _pictures;
@synthesize rules = _rules;

+ (NSString *)filePath
{
    NSString *lib = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    return [lib stringByAppendingPathComponent:kWZRegulationFileName];
}

+ (instancetype)defaultRegulation
{
    static WZRegulation *_regulation;
    if (!_regulation) {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *file = [[self class]filePath];
        BOOL dict = NO;
        if (![fm fileExistsAtPath:file isDirectory:&dict]) {
            _regulation = [[self class] new];
            [_regulation save];
        }
        else if (dict==YES) {
            [fm removeItemAtPath:file error:nil];
            _regulation = [[self class] new];
            [_regulation save];
        }
        else {
            NSData *data = [[NSData alloc] initWithContentsOfFile:file];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            _regulation = [unarchiver decodeObject];
            [unarchiver finishDecoding];
        }
    }
    return _regulation;
}

- (void)updateWithDicationary:(NSDictionary *)dicationary
{
    NSString *rules = [dicationary objectForKey:@"rules"];
    NSArray *pictures = [dicationary objectForKey:@"pictures"];
    if (rules) {
        self.rules = rules;
    }
    if (pictures) {
        self.pictures = pictures;
    }
    [self save];
}

- (void)save
{
    NSString *file = [[self class] filePath];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self];
    [archiver finishEncoding];
    [data writeToFile:file atomically:NO];
}

- (id)init
{
    self = [super init];
    if (self) {
        _pictures = @[@"积分1.jpg",@"积分2.jpg"];
        _rules = @"⦿ 成功注册会员，获赠200粒珍珠\n"
        @"⦿ 会员登录系统，获赠1粒系统珍珠\n"
        @"⦿ 会员资料填写完整，获赠20粒系统珍珠\n"
        @"⦿ 每邀请一位用户注册成为会员，获赠20粒系统珍珠";
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _rules = [aDecoder decodeObjectForKey:@"rules"];
        _pictures = [aDecoder decodeObjectForKey:@"pictures"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if (_rules) {
        [aCoder encodeObject:_rules forKey:@"rules"];
    }
    if (_pictures) {
        [aCoder encodeObject:_pictures forKey:@"pictures"];
    }
}
@end
