//
//  WZMerchantPointToUserViewController.m
//  Abalone
//
//  Created by 陈 海涛 on 13-7-17.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZMerchantPointToUserViewController.h"
#import "NSString+Format.h"
#import "WZMemberPointToUserPointNetWork.h"
#import "WZmerchant.h"
#import "WZUser+Me.h"
#import "WZMember.h"
#import "WZConfigure.h"
#import "WZMerchant.h"


@interface WZMerchantPointToUserViewController ()

@end

@implementation WZMerchantPointToUserViewController

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
    self.navigationItem.title = @"兑换贝客积分";
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.explain.text =  [WZUser me].config.pointLargessExplain ;
    self.rate.text = [NSString stringWithFormat:@"%i个会员积分兑换一个平台积分",self.merchant.rate.integerValue];
    self.explain.numberOfLines = 0;
    
    self.merchantLogo.imageURL = [NSURL URLWithString:self.merchant.logo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberPointToUserSuccess:) name:kMEMBERPOINTTOUSERPOINTSUCCESSNOTIFICTION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberPointToUserFail:) name:kMEMBERPOINTTOUSERPOINTFAILNOTIFICTION object:nil];
}

-(void)memberPointToUserSuccess:(NSNotification *)notification
{
    [self.lastVC.tableView reloadData];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"积分转换成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)memberPointToUserFail:(NSNotification *)notification
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
        CGSize size =  [[WZUser me].config.pointLargessExplain sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(238, 99999999) lineBreakMode:NSLineBreakByWordWrapping];
       
        return size.height + 90;
    }else{
        return 107;
    }
}


- (IBAction)memberPointToUser:(id)sender {
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
             [WZMemberPointToUserPointNetWork member:member.gid setMemberPointToUserPoint:self.pintNum.text.integerValue];
        }
       
        
    }
    
    
}



- (void)done:(id)sender
{
    [self.pintNum resignFirstResponder];
}

- (NSString *)warning
{
    NSString *warning = nil;
    
     if (![self.pintNum.text length]) {
        warning = @"积分不能为空";
    }else if((self.pintNum.text.floatValue - self.pintNum.text.intValue) >0){
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
