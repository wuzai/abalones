//
//  WZMerchantPointSendViewController.m
//  Abalone
//
//  Created by 陈 海涛 on 13-7-16.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZMerchantPointSendViewController.h"
#import "NSString+Format.h"
#import "WZMemberPointNetWork.h"
#import "WZmerchant.h"
#import "WZUser+Me.h"
#import "WZMember.h"

@interface WZMerchantPointSendViewController ()

@end

@implementation WZMerchantPointSendViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"会员积分转赠";
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.sendExplain.text = self.merchant.largessExplain;
    self.sendExplain.numberOfLines = 0;
    
       self.LogoImge.imageURL = [NSURL URLWithString:self.merchant.logo];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMemberPointSuccess:) name:kSENDMEMBERPOINTTOUSERSUCCESSNOTIFICTION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMemberPointFail:) name:kSENDMEMBERPOINTTOUSERFAILNOTIFICTION object:nil];
}

-(void)sendMemberPointSuccess:(NSNotification *)notification
{
    [self.lastVC.tableView reloadData];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"积分转赠成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sendMemberPointFail:(NSNotification *)notification
{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[notification object]  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CGSize size =  [self.merchant.largessExplain sizeWithFont:self.sendExplain.font constrainedToSize:CGSizeMake(self.sendExplain.frame.size.width, 99999999) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height +100;
    }else{
        return 107;
    }
}


- (IBAction)sendPoint:(id)sender {
    [self done:nil];
    NSString *warning = [self warning];
    if (warning) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:warning message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }else{
        NSFetchRequest *request = [WZMember  fetchRequest];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user.gid = %@ and merchant.gid = %@",[WZUser me].gid,self.merchant.gid];
        request.predicate = predicate;
        NSArray *members = [WZMember executeFetchRequest:request];
        if (members.count) {
            WZMember *member = [members lastObject];
             [WZMemberPointNetWork sendMemberPoint:self.pointNum.text.intValue fromMember:member.gid toUserName:self.phoneNum.text inMerchant:self.merchant.gid];
        }else{
            NSLog(@"查无数据");
        }
       
    }
    
    
}

- (void)done:(id)sender
{
    [self.pointNum resignFirstResponder];
    [self.phoneNum resignFirstResponder];
}

- (NSString *)warning
{
    NSString *warning = nil;
    if (![self.phoneNum.text isValidTelphone]) {
        warning = @"手机号不正确";
    }
    else if (![self.pointNum.text length]) {
        warning = @"积分不能为空";
    }else if((self.pointNum.text.floatValue - self.pointNum.text.intValue) >0){
        warning = @"积分不能为小数";
    }
    return warning;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self done:nil];
}
@end
