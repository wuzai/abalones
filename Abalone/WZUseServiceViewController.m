//
//  WZUseServiceViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-9.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUseServiceViewController.h"
#import "WZCoupon.h"
#import "WZMeteringCard.h"
#import "WZMemberCard.h"
#import "WZUseService.h"
#import "WZUser+Me.h"
#import "WZServiceItem.h"
#import "WZMemberService.h"


@interface WZUseServiceViewController ()

@end

@implementation WZUseServiceViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)loadData
{
    if ([self.service isKindOfClass:[WZCoupon class]]) {
        WZCoupon *coupon = (WZCoupon *)self.service;
        self.serviceTitle.text = coupon.couponName;
        self.serviceDescription.text = coupon.intro;
        
    }else if([self.service isKindOfClass:[WZMemberCard class]]){
        WZMemberCard *memberCard = (WZMemberCard *)self.service;
        self.serviceTitle.text = memberCard.memberCardName;
        self.serviceDescription.text = memberCard.intro;
    }else if([self.service isKindOfClass:[WZMeteringCard class]]){
        WZMeteringCard *meteringCard = (WZMeteringCard *)self.service;
        self.serviceTitle.text = meteringCard.meteringCardName;
        self.serviceDescription.text = meteringCard.intro;
    }
    
    
    else if ([self.service isKindOfClass:[WZMemberService class]])
    {
        WZMemberService *serviceItem = (WZMemberService *)self.service;
        self.serviceTitle.text = serviceItem.memberServiceName;
        self.serviceDescription.text = serviceItem.intro;
    }
    self.serviceImage.imageURL = [NSURL URLWithString:[self.service iconImage]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    if (indexPath.row == 0) {
        size = [self.serviceTitle.text sizeWithFont:self.serviceTitle.font constrainedToSize:CGSizeMake(self.serviceTitle.frame.size.width, 9999999) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 30;
    }else if(indexPath.row == 1){
        return 150.0f;
    }else if(indexPath.row == 2){
        size = [self.serviceDescription.text sizeWithFont:self.serviceDescription.font constrainedToSize:CGSizeMake(self.serviceDescription.frame.size.width, 99999999) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 30;
    }else if(indexPath.row == 3){
        return 150;
    }
    
    return 0.0f;
}

- (IBAction)useService:(id)sender {
    
    NSString *serviceType = nil;
    //(MemberCard/Coupon/MeteringCard)
//    if (self.service isKindOfClass:WZS)
    if ([self.service isKindOfClass:[WZMemberCard class]]) {
        serviceType = @"MemberCard";
    }else if([self.service isKindOfClass:[WZCoupon class]]){
        serviceType = @"Coupon";
    }else if([self.service isKindOfClass:[WZMeteringCard class]]){
        serviceType = @"MeteringCard";
    }
    //扩展类型
    else if([self.service isKindOfClass:[WZMemberService class]]){
        WZMemberService *serviceItem = (WZMemberService *)self.service;
        serviceType = serviceItem.memberServiceType;
    }
   
    WZUser *user = [WZUser me];
    if([WZUseService userviceWithType:serviceType forServiceID:[self.service gid] inStoreID:self.sendStoreID byUserID:user.gid]){
        UIButton *button = (UIButton *)sender;
        button.alpha = 0.4;
        button.enabled = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(useServiceSuccess:) name:kUseServiceSuccessNotificationKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(useServiceFail:) name:kUseServiceFailNotificationKey object:nil];
    }
}


-(void)useServiceSuccess:(NSNotification *)notification
{
    self.serviceCode.text = [NSString stringWithFormat:@"验证码：%@", notification.object ];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUseServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUseServiceFailNotificationKey object:nil];
}
-(void)useServiceFail:(NSNotification *)notification
{
   UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"提示" message:notification.object delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUseServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUseServiceFailNotificationKey object:nil];
}



@end
