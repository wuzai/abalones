//
//  WZSendLargessViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-6.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZSendLargessViewController.h"
#import "WZMemberCard.h"
#import "WZMeteringCard.h"
#import "WZCoupon.h"
#import "NSString+Format.h"
#import "WZLargess.h"
#import "WZUser+Me.h"
#import "WZUser+Equal.h"
#import "WZServiceItem.h"
#import "WZMemberService.h"

@interface WZSendLargessViewController ()
@property (nonatomic,strong) NSString *serviceName;
@property (nonatomic,strong) NSString *serviceIntro;
@property (nonatomic,strong) WZUser *last;
@end

@implementation WZSendLargessViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    WZUser *user = [WZUser me];
    if (![self.last isEqualToUser:user] && self.last ) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    self.last = user;
}

-(void)loadData
{
    if ([self.service respondsToSelector:@selector(couponName)]) {
       self.serviceName = [self.service performSelector:@selector(couponName)];
    }else if ([self.service respondsToSelector:@selector(memberCardName)]) {
        self.serviceName = [self.service performSelector:@selector(memberCardName)];
    }else if ([self.service respondsToSelector:@selector(meteringCardName)]) {
        self.serviceName = [self.service performSelector:@selector(meteringCardName)];
    }
    if ([self.service respondsToSelector:@selector(intro)]) {
        self.serviceIntro = [self.service performSelector:@selector(intro)];
    }
    self.serviceTitle.text = self.serviceName;
    self.serviceDescription.text = self.serviceIntro;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.tableView addGestureRecognizer:tap];
}

-(void)dismissKeyboard:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self.largessToCellPhone resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [self heightForLabel:self.serviceTitle withString:self.serviceName];
            break;
        case 1:
            return [self heightForLabel:self.serviceDescription  withString:self.serviceIntro];
            break;
        case 2:
            return 150.0;
            break;
        default:
            break;
    }
    return 0.0;
}

-(CGFloat)heightForLabel:(UILabel *)label withString:(NSString *)str
{
    if (!str) {
        return 44;
    }
    CGSize size = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, 999999) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height + 10;
}

- (IBAction)sendLargess:(UIButton *)sender {
     [self.largessToCellPhone resignFirstResponder];
    WZUser *user = (WZUser *)[WZUser me];
    if ([self.largessToCellPhone.text isEqualToString:user.username]) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"不能转赠给自己" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    if ([self checkcellPhoneNum]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendLargessSuccess:) name:kSendLargessSuccessNotificationKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendLargessFail:) name:kSendLargessFailNotificationKey object:nil];
        
        NSString *serviceType = nil;
        //(MemberCard/Coupon/MeteringCard)
        if ([self.service isKindOfClass:[WZMemberCard class]]) {
            serviceType = @"MemberCard";
        }else if([self.service isKindOfClass:[WZCoupon class]]){
            serviceType = @"Coupon";
        }else if([self.service isKindOfClass:[WZMeteringCard class]]){
            serviceType = @"MeteringCard";
        }
        //扩展类型
        else if ([self.service isKindOfClass:[WZMemberService class]])
        {
            WZMemberService *serviceItem = (WZMemberService *)self.service;
            serviceType = serviceItem.memberServiceType;
        }
        if([WZLargess sendLargessTo:self.largessToCellPhone.text withType:serviceType withServiceID:[self.service gid] withStoreID:self.sendStoreID]){
            sender.enabled = NO;
            sender.alpha = 0.4;
        }
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }
    
}

-(void)sendLargessSuccess:(NSNotification *)notification
{
    [[[UIAlertView alloc] initWithTitle:@"提示 " message:@"转赠成功" delegate:nil cancelButtonTitle:@"确定 " otherButtonTitles:nil, nil] show];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSendLargessSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSendLargessFailNotificationKey object:nil];
}

-(void)sendLargessFail:(NSNotification *)notification
{
    NSError *error = [notification object];
    if (error) {
        [[[UIAlertView alloc] initWithTitle:@"提示 " message:[notification object] delegate:nil cancelButtonTitle:@"确定 " otherButtonTitles:nil, nil] show];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示 " message:[notification object] delegate:nil cancelButtonTitle:@"确定 " otherButtonTitles:nil, nil] show];
    }
    self.senderButton.enabled = YES;
    self.senderButton.alpha = 1.0;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSendLargessSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSendLargessFailNotificationKey object:nil];
}

- (IBAction)checkCellPhone:(id)sender {
    if ([self checkcellPhoneNum]) {
        self.largessToCellPhone.textColor = [UIColor greenColor];
    }else{
         self.largessToCellPhone.textColor = [UIColor redColor];
    }
}

-(BOOL)checkcellPhoneNum
{
    NSString * regex  = @"^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch  = [pred evaluateWithObject:self.largessToCellPhone.text];
    if (!isMatch) {
        return NO;
    }else{
        return YES;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.largessToCellPhone resignFirstResponder];
}

@end
