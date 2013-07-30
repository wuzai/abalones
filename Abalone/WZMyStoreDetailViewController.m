//
//  WZMyStoreDetailViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-28.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMyStoreDetailViewController.h"
#import "WZStore+Mine.h"
#import "WZMyStoreDetailHeaderCell.h"
#import "WZMerchant.h"
#import "WZMyStoreServiceCell.h"
#import "WZFetchService.h"
#import "WZUser+Me.h"
#import "WZMyStoreAddServiceCell.h"
#import "WZUser+Equal.h"
#import "WZSubmitCancelService.h"
#import "WZSubmitOKService.h"
#import "WZMemberCard.h"
#import "WZCoupon.h"
#import "WZMeteringCard.h"
#import <RestKit/RestKit.h>
#import "WZMyMerchantPointRecordListViewController.h"
#import "WZMyMerchantPointCell.h"
#import "WZMember.h"
#import "WZMeteringCard.h"
#import <ShareSDK/ShareSDK.h>
#import "WZMerchantPointSendViewController.h"
#import "WZMerchantPointToUserViewController.h"
#import "WZServiceItem.h"
#import "WZMemberService.h"


@interface WZMyStoreDetailViewController ()
@property (nonatomic,strong) NSMutableArray *services;
@property (nonatomic,strong) WZUser *last;
@end


NSString *const headerCellIdentifier = @"myStoreDetailHeader";
NSString *const myStoreServiceCellIdentifier = @"myStoreServiceCell";
NSString *const myStoreAddServiceCellIdentifier = @"myStoreAddServiceCell";
NSString *const myMerchantPointCellIdentifier = @"merchantPointCell";

@implementation WZMyStoreDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSBundle *classBundle = [NSBundle bundleForClass:[WZMyStoreDetailHeaderCell class]];
    UINib *nib = [UINib nibWithNibName:@"MyStoreDetailHeader" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:headerCellIdentifier];
    
    classBundle = [NSBundle bundleForClass:[WZMyStoreServiceCell class]];
    nib = [UINib nibWithNibName:@"MyStoreServiceCell" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:myStoreServiceCellIdentifier];
    
    classBundle = [NSBundle bundleForClass:[WZMyStoreAddServiceCell class]];
    nib = [UINib nibWithNibName:@"MyStoreAddServiceCell" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:myStoreAddServiceCellIdentifier];
    
    classBundle = [NSBundle bundleForClass:[WZMyMerchantPointCell class]];
    nib = [UINib nibWithNibName:@"MyMerchantPointCell" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:myMerchantPointCellIdentifier];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.services = self.store.myServicesInTheStore;
    self.title = [NSString stringWithFormat:@"%@", self.store.storeName ];

    [WZFetchService fetchServiceByUser:[WZUser me]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchServiceSuccess:) name:kFetchServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchServiceFail:) name:kFetchServiceFailNotificationKey object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchServiceFailNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchServiceSuccessNotificationKey object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    WZUser *user = [WZUser me];
    if (![self.last isEqualToUser:user] && self.last ) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    self.last = user;
}

-(void)fetchServiceSuccess:(NSNotification *)notification
{
    self.services = self.store.myServicesInTheStore;
    [self.tableView reloadData];
}
-(void)fetchServiceFail:(NSNotification *)notification
{
    NSLog(@"fetch services fail:%@",notification.object);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.store.myServicesInTheStore.count ? self.store.myServicesInTheStore.count+2 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell =nil;
    if (indexPath.row == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:headerCellIdentifier];
        if([cell isKindOfClass:[WZMyStoreDetailHeaderCell class]]){
            WZMyStoreDetailHeaderCell *myStoreDetailHeaderCell = (WZMyStoreDetailHeaderCell *)cell;
            myStoreDetailHeaderCell.cellHeaderImage.imageURL = [NSURL URLWithString:self.store.vipImage];
            myStoreDetailHeaderCell.merchantPointLabel.text = [NSString stringWithFormat:@"%i", self.store.merchant.score.intValue ];
            [myStoreDetailHeaderCell.dealsButton addTarget:self action:@selector(showRecords:) forControlEvents:UIControlEventTouchUpInside];
            [myStoreDetailHeaderCell.merchantDetailButton addTarget:self action:@selector(showStoreDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else if(indexPath.row == 1){
        cell = [self.tableView dequeueReusableCellWithIdentifier:myMerchantPointCellIdentifier];
        if([cell isKindOfClass:[WZMyMerchantPointCell class]]){
            WZMyMerchantPointCell *pointCell = (WZMyMerchantPointCell *)cell;
            pointCell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pointCellBg"]];
            WZUser *user = [WZUser me];
            [pointCell.platformPoint setTitle:[NSString stringWithFormat:@"%i",user.point.integerValue] forState:UIControlStateNormal];
            if (user.point.integerValue == 0) {
                pointCell.platformPoint.enabled = NO;
            }else{
                pointCell.platformPoint.enabled = YES;
            }
            
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"WZMember"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"merchantID = %@ and user.gid = %@",self.store.merchant.gid,[WZUser me].gid];
            request.predicate = predicate;
            NSArray *members = [WZMember executeFetchRequest:request];
            if (members.count) {
                WZMember *member = members.lastObject;
                NSLog(@"%@",member);
                [pointCell.pointButton setTitle: [NSString stringWithFormat:@"%i",[[members.lastObject point]intValue]] forState:UIControlStateNormal];
                [pointCell.pointButton addTarget:self action:@selector(showRecords:) forControlEvents:UIControlEventTouchUpInside];
                pointCell.merchantPointSend.enabled = YES;
            }
            if ([[members.lastObject point]intValue] == 0) {
                [pointCell.pointButton setTitle: [NSString stringWithFormat:@"%i",0] forState:UIControlStateNormal];
                pointCell.merchantPointSend.enabled = NO;
            }else{
                pointCell.merchantPointSend.enabled = YES;
            }
            
            
          
            [pointCell.platformPoint addTarget:self action:@selector(platformPointRecord:) forControlEvents:UIControlEventTouchUpInside];
            
            [pointCell.merchantPointSend addTarget:self action:@selector(merchantPointSend:) forControlEvents:UIControlEventTouchUpInside];
            [pointCell.platformSend addTarget:self action:@selector(userPointSend:) forControlEvents:UIControlEventTouchUpInside];
            
            [pointCell.merchantPointChange addTarget:self action:@selector(merchantPointToUserPoint:) forControlEvents:UIControlEventTouchUpInside];
            if (self.store.merchant.rate.integerValue == 0) {
                pointCell.merchantPointChange.enabled = NO;
            }else{
                pointCell.merchantPointChange.enabled = YES;
            }
          
        }
    }else{
        id service = self.services[indexPath.row -2];
        if ([service respondsToSelector:@selector(submitState)]) {
            BOOL submitState = [[service performSelector:@selector(submitState)] boolValue];
            if (submitState) {
                cell = [self.tableView dequeueReusableCellWithIdentifier:myStoreAddServiceCellIdentifier];
                if([cell isKindOfClass:[WZMyStoreAddServiceCell class]]){
                    WZMyStoreAddServiceCell *mystoreAddServiceCell = (WZMyStoreAddServiceCell *)cell;
                    if ([service respondsToSelector:@selector(iconImage)]) {
                        mystoreAddServiceCell.storeServiceImage.imageURL = [NSURL URLWithString:[service performSelector:@selector(iconImage)]];
                       
                    }
                    NSString *serviceName = nil;
                    if ([service respondsToSelector:@selector(couponName)]) {
                        serviceName = [service performSelector:@selector(couponName)];
                    }else if ([service respondsToSelector:@selector(memberCardName)]) {
                        serviceName = [service performSelector:@selector(memberCardName)];
                    }else if ([service respondsToSelector:@selector(meteringCardName)]) {
                        serviceName = [service performSelector:@selector(meteringCardName)];
                    }
                    mystoreAddServiceCell.storeServiceName.text = serviceName;
                    
                    [mystoreAddServiceCell.okButton addTarget:self action:@selector(okService:) forControlEvents:UIControlEventTouchUpInside];
                    [mystoreAddServiceCell.cancelButton addTarget:self action:@selector(cancelService:) forControlEvents:UIControlEventTouchUpInside];
                    mystoreAddServiceCell.okButton.alpha = 1.0;
                    mystoreAddServiceCell.cancelButton.alpha = 1.0;
                    mystoreAddServiceCell.okButton.enabled = YES;
                    mystoreAddServiceCell.cancelButton.enabled = YES;
                    
                    if ([service respondsToSelector:@selector(memberServiceNumber)]) {
                        mystoreAddServiceCell.meteringCardNum.hidden = NO;
                        mystoreAddServiceCell.meteringCardNumImage.hidden = NO;
                        int serviceNumber = [[service performSelector:@selector(memberServiceNumber)] intValue];
                        if (serviceNumber  < 0) {
                            mystoreAddServiceCell.meteringCardNum.text = @"无限";
                        }else{
                            mystoreAddServiceCell.meteringCardNum.text = [NSString stringWithFormat:@"余 %i 元",serviceNumber ];
                        }
                    }
                    
                    
                    else if ([service respondsToSelector:@selector(remainCount)]) {
                        mystoreAddServiceCell.meteringCardNum.hidden = NO;
                        mystoreAddServiceCell.meteringCardNumImage.hidden = NO;
                        int count = [[service performSelector:@selector(remainCount)] intValue];
                                                if (count  < 0) {
                            mystoreAddServiceCell.meteringCardNum.text = @"无限";
                        }else{
                            mystoreAddServiceCell.meteringCardNum.text = [NSString stringWithFormat:@"%i次",count ];
                        }
                    }else{
                        mystoreAddServiceCell.meteringCardNum.hidden = YES;
                        mystoreAddServiceCell.meteringCardNumImage.hidden = YES;
                    }
                    
                    
                } 
            }else{
                cell = [self.tableView dequeueReusableCellWithIdentifier:myStoreServiceCellIdentifier];
                if([cell isKindOfClass:[WZMyStoreServiceCell class]]){
                    WZMyStoreServiceCell *mystoreServiceCell = (WZMyStoreServiceCell *)cell;
                    if ([service respondsToSelector:@selector(iconImage)]) {
                        mystoreServiceCell.storeServiceImage.imageURL = [NSURL URLWithString:[service performSelector:@selector(iconImage)]];
                        NSLog(@"hello:%@",mystoreServiceCell.storeServiceImage.imageURL);
                    }
                    NSString *serviceName = nil;
                    NSString *serviceType = nil;
                    if ([service respondsToSelector:@selector(couponName)]) {
                        serviceName = [service performSelector:@selector(couponName)];
                        mystoreServiceCell.type.text = @"优惠券";
                    }else if ([service respondsToSelector:@selector(memberCardName)]) {
                        serviceName = [service performSelector:@selector(memberCardName)];
                        mystoreServiceCell.type.text = @"会员卡";
                    }else if ([service respondsToSelector:@selector(meteringCardName)]) {
                        serviceName = [service performSelector:@selector(meteringCardName)];
                        mystoreServiceCell.type.text  = @"计次卡";
                    }
                    //扩展类型
                    else if ([service respondsToSelector:@selector(memberServiceName)]) {
                        serviceName = [service performSelector:@selector(memberServiceName)];
                        serviceType = [service performSelector:@selector(memberServiceType)];
                        
                    }
                    mystoreServiceCell.storeServiceName.text = serviceName;
                    
                    if([serviceType  isEqualToString:@"GroupOn"])
                    {
                        mystoreServiceCell.type.text = @"团购券";
                    }
                    else if([serviceType isEqualToString:@"StoreCard"])
                    {
                        mystoreServiceCell.type.text = @"储值卡";
                    }
                    else if([serviceType isEqualToString:@"Voucher"])
                    {
                        mystoreServiceCell.type.text = @"代金券";
                    }                    
                    
                    if ([service respondsToSelector:@selector(allowLargess)]) {
                                       if ([[service performSelector:@selector(allowLargess)] intValue]) {
                                           mystoreServiceCell.givingAwayButton.enabled = YES;
                                           mystoreServiceCell.givingAwayButton.alpha = 1.0;
                                        }else{
                                            mystoreServiceCell.givingAwayButton.enabled = NO ;
                                             mystoreServiceCell.givingAwayButton.alpha = 0.4;
                                        }
                    }
                    [mystoreServiceCell.givingAwayButton addTarget:self action:@selector(givingAwway:) forControlEvents:UIControlEventTouchUpInside];
                    [mystoreServiceCell.useButton addTarget:self action:@selector(useService:) forControlEvents:UIControlEventTouchUpInside];
                    
                    if ([service respondsToSelector:@selector(memberServiceNumber)]) {
                        mystoreServiceCell.meteringCardNum.hidden = NO;
                        mystoreServiceCell.meteringCardNumImage.hidden = NO;
                        int serviceNumber = [[service performSelector:@selector(memberServiceNumber)] intValue];
                        if (serviceNumber  < 0) {
                            mystoreServiceCell.meteringCardNum.text = @"无限";
                        }else{
                            mystoreServiceCell.meteringCardNum.text = [NSString stringWithFormat:@"余 %i 元",serviceNumber ];
                        }                        
                    }                    
                    else if ([service respondsToSelector:@selector(remainCount)]) {
                        mystoreServiceCell.meteringCardNum.hidden = NO;
                        mystoreServiceCell.meteringCardNumImage.hidden = NO;
                        
                        int count = [[service performSelector:@selector(remainCount)] intValue];                        
                        
                        if (count  < 0) {
                            mystoreServiceCell.meteringCardNum.text = @"无限";
                        }else{
                            mystoreServiceCell.meteringCardNum.text = [NSString stringWithFormat:@"余 %i 次",count ];
                        }
                    }else{
                        mystoreServiceCell.meteringCardNum.hidden = YES;
                        mystoreServiceCell.meteringCardNumImage.hidden = YES;
                    }
                    
                }
                
                
            }
        }
    }
    
    
    return cell;
}

- (void) merchantPointToUserPoint:(UIButton *)button
{
   
    WZMerchantPointToUserViewController *mtu = (WZMerchantPointToUserViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"merchantPointToUser"];
    mtu.merchant = self.store.merchant;
    mtu.lastVC = self;
    [self.navigationController pushViewController:mtu animated:YES];
}

-(void) userPointSend:(UIButton *)button
{
    WZUserPointSendViewController *pointSend = (WZUserPointSendViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UserPointSend"];
    pointSend.merchant = self.store.merchant;
    pointSend.lastVC = self;
    [self.navigationController pushViewController:pointSend animated:YES];
}

-(void)merchantPointSend:(UIButton *)button
{
    WZMerchantPointSendViewController *psVc = (WZMerchantPointSendViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"merchantPointSend"];
    psVc.merchant = self.store.merchant;
    psVc.lastVC = self;
    [self.navigationController pushViewController:psVc animated:YES];
}

-(void)platformPointRecord:(UIButton *)button
{
    WZMyMerchantPointRecordListViewController *mpl = (WZMyMerchantPointRecordListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"pointRecordView"];
 //   mpl.merchant = self.store.merchant;
    mpl.type  = WZUserType;
    
    [self.navigationController pushViewController:mpl animated:YES];
}

-(void)showRecords:(id)button
{
    [self performSegueWithIdentifier:@"myMerchantPointRecordList" sender:self.store.merchant];
}

-(void)showStoreDetail:(id)button
{
    [self performSegueWithIdentifier:@"showStoreDetail" sender:self.store];
}

-(void)okService:(UIButton *)sender
{
    UIView *view = (UIView *)sender;
    while (view && ![view isKindOfClass:[UITableViewCell class]]) {
        view = view.superview;
    }
    
    if ([view isKindOfClass:[WZMyStoreAddServiceCell class]]) {
        WZMyStoreAddServiceCell *cell = (WZMyStoreAddServiceCell *)view;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        id service = self.services[indexPath.row-2];
        
        NSString *serviceType = nil;
        //(MemberCard/Coupon/MeteringCard)
        if ([service isKindOfClass:[WZMemberCard class]]) {
            serviceType = @"MemberCard";
        }else if([service isKindOfClass:[WZCoupon class]]){
            serviceType = @"Coupon";
        }else if([service isKindOfClass:[WZMeteringCard class]]){
            serviceType = @"MeteringCard";
        }
        //扩展类型
        
        else if ([service isKindOfClass:[WZMemberService class]]) 
            {
                WZMemberService *serviceItem = (WZMemberService *)service;
                serviceType = serviceItem.memberServiceType;
            }

        if([WZSubmitOKService submitOkForLargessServiceID:[service gid] withType:serviceType byUserID:[[WZUser me] gid] withStoreID:self.store.gid]){
            cell.okButton.alpha = 0.6;
            cell.cancelButton.alpha = 0.6;
            cell.okButton.enabled = NO;
            cell.cancelButton.enabled = NO;
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitOkServiceSuccess:) name:kSubmitOkServiceSuccessNotificationKey object:nil];
             [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitOKServiceFail:) name:kSubmitOKServiceFailNotificationKey object:nil];
        }
    }
}

-(void)submitOkServiceSuccess:(NSNotification *)notification
{
    NSArray *results = (NSArray *)notification.object;
    if (results.count) {
        if ([results.lastObject respondsToSelector:@selector(setSubmitState:)]) {
            [results.lastObject performSelector:@selector(setSubmitState:) withObject:[NSNumber numberWithBool:NO]];
        }
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"领取成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSubmitOkServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSubmitOKServiceFailNotificationKey object:nil];
}
-(void)submitOKServiceFail:(NSNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"领取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSubmitOkServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSubmitOKServiceFailNotificationKey object:nil];
}

-(void)cancelService:(UIButton *)sender
{
    UIView *view = (UIView *)sender;
    while (view && ![view isKindOfClass:[UITableViewCell class]]) {
        view = view.superview;
    }
    
    if ([view isKindOfClass:[WZMyStoreAddServiceCell class]]) {
        WZMyStoreAddServiceCell *cell = (WZMyStoreAddServiceCell *)view;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        id service = self.services[indexPath.row-2];
        
        NSString *serviceType = nil;
        //(MemberCard/Coupon/MeteringCard)
        if ([service isKindOfClass:[WZMemberCard class]]) {
            serviceType = @"MemberCard";
        }else if([service isKindOfClass:[WZCoupon class]]){
            serviceType = @"Coupon";
        }else if([service isKindOfClass:[WZMeteringCard class]]){
            serviceType = @"MeteringCard";
        }
        if([WZSubmitCancelService submitCancelForLargessServiceID:[service gid] withType:serviceType byUserID:[[WZUser me] gid] withStoreID:self.store.gid]){
            cell.okButton.alpha = 0.6;
            cell.cancelButton.alpha = 0.6;
            cell.okButton.enabled = NO;
            cell.cancelButton.enabled = NO;
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitCancelServiceSuccess:) name:kSubmitCancelServiceSuccessNotificationKey object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitCancelServiceFail:) name:kSubmitCancelServiceFailNotificationKey object:nil];
        }
    }
}

-(void)submitCancelServiceSuccess:(NSNotification *)notification
{
    NSArray *results = (NSArray *)notification.object;
    if (results.count) {
       // [self.store deleteEntity];
        if ([results.lastObject respondsToSelector:@selector(deleteEntity)]) {
            [self.services removeObject:[results lastObject]];
            [results.lastObject deleteEntity];
            [[RKObjectManager sharedManager].objectStore save:nil];
        }
        
        [self.tableView reloadData];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"拒绝成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSubmitCancelServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSubmitCancelServiceFailNotificationKey object:nil];
}
-(void)submitCancelServiceFail:(NSNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"拒绝失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSubmitCancelServiceSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSubmitCancelServiceFailNotificationKey object:nil];
}



-(void)givingAwway:(UIButton *)sender
{
    
    UIView *view = (UIView *)sender;
    while (view && ![view isKindOfClass:[UITableViewCell class]]) {
        view = view.superview;
    }
    
    if ([view isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)view;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self performSegueWithIdentifier:@"sendLargess" sender:self.services[indexPath.row-2]];
    }
    
}

-(void)useService:(UIButton *)sender
{
    
    UIView *view = (UIView *)sender;
    while (view && ![view isKindOfClass:[UITableViewCell class]]) {
        view = view.superview;
    }
    
    if ([view isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)view;
         NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self performSegueWithIdentifier:@"useService" sender:self.services[indexPath.row -2]];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }else if(indexPath.row == 1){
        return 120;
    }else{
        return 90;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >1) {
        [self performSegueWithIdentifier:@"showMyServiceDetail" sender:self.services[indexPath.row -2]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMyServiceDetail"]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setService:)]) {
            [segue.destinationViewController performSelector:@selector(setService:) withObject:sender];
        }
    }else if([segue.identifier isEqualToString:@"sendLargess"]){
        if ([segue.destinationViewController respondsToSelector:@selector(setService:)]) {
            [segue.destinationViewController performSelector:@selector(setService:) withObject:sender];
        }
        if ([segue.destinationViewController respondsToSelector:@selector(setSendStoreID:)]) {
            [segue.destinationViewController performSelector:@selector(setSendStoreID:) withObject:self.store.gid];
        }
    }else if([@"myMerchantPointRecordList"  isEqualToString:segue.identifier]){
        if([segue.destinationViewController respondsToSelector:@selector(setMerchant:)]){
            [segue.destinationViewController performSelector:@selector(setMerchant:) withObject:sender];
        }
        if ([segue.destinationViewController isKindOfClass:[WZMyMerchantPointRecordListViewController class]]) {
            WZMyMerchantPointRecordListViewController *pointRecord = (WZMyMerchantPointRecordListViewController *)segue.destinationViewController;
            pointRecord.type = WZMemberType;
        }
    }else if([@"showStoreDetail"  isEqualToString:segue.identifier]){
        if([segue.destinationViewController respondsToSelector:@selector(setStore:)]){
            [segue.destinationViewController performSelector:@selector(setStore:) withObject:sender];
        }
    }else if([@"useService" isEqualToString:segue.identifier]){
        if ([segue.destinationViewController respondsToSelector:@selector(setService:)]) {
            [segue.destinationViewController performSelector:@selector(setService:) withObject:sender];
        }
        if ([segue.destinationViewController respondsToSelector:@selector(setSendStoreID:)]) {
            [segue.destinationViewController performSelector:@selector(setSendStoreID:) withObject:self.store.gid];
        }
    }
}


- (IBAction)shareMyStore:(UIBarButtonItem *)sender {
    
    WZMyStoreDetailHeaderCell *cell = (WZMyStoreDetailHeaderCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    NSString *content = [NSString stringWithFormat:@"门店分享: 在贝客汇上发现一个很不错的地方 %@ ，分享给大家啊，希望大家喜欢! #贝客汇# http://www.5zzg.com/web/",self.store.storeName]; 
   
    id<ISSContent>publishContent=[ShareSDK content:content
                                    defaultContent:@"在贝客汇上发现一个很不错的地方，分享给大家啊，希望大家喜欢！"
                                             image:[ShareSDK jpegImageWithImage:cell.cellHeaderImage.image quality:1.0]
                                             title:@"分享"
                                            url:@"http://www.5zzg.com/web/"
                                       description:content
                                         mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil shareList:nil
                           content:publishContent
                     statusBarTips:YES
                      authOptions :nil
                      shareOptions:nil
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo>
                                     statusInfo,id<ICMErrorInfo>error,BOOL end){
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error  errorCode],[error errorDescription]);
                                }
                                
                            }];
}
@end
