//
//  WZStoreDetailInfoViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStoreDetailInfoViewController.h"
#import "WZMerchant.h"
#import "WZStoreDetailViewController.h"

@interface WZStoreDetailInfoViewController ()

@end

@implementation WZStoreDetailInfoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)updateViews
{
    self.storeAddressTextView.text = self.store.address;
    self.storeCellPhoneLabel.text = self.store.cellPhone;
    self.merchantIntro.text = self.store.merchant.intro;
    self.webURL.text = self.store.merchant.url;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window) {
       
    }
}



#pragma mark - 
#pragma mark UITableViewDelegate and UITableViewDataSource Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 44;
    }else if(indexPath.section == 0 &&indexPath.row == 2){
        CGSize size = [self.webURL.text sizeWithFont:[UIFont systemFontOfSize:14]  constrainedToSize:CGSizeMake(self.webURL.frame.size.width, 9999999) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 12 > 44 ? size.height + 12 : 44;
    }else if(indexPath.section == 0 && indexPath.row ==1){
        CGSize size = [self.storeAddressTextView.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.storeAddressTextView.frame.size.width, 9999999) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 12 > 44 ? size.height + 12 : 44;
    }else if(indexPath.section == 1 && indexPath.row == 0){
        CGSize size = [self.merchantIntro.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.merchantIntro.frame.size.width, 9999999) lineBreakMode:NSLineBreakByWordWrapping];
         return size.height + 12 > 44 ? size.height + 12 : 44;
    }else if(indexPath.section == 2 && indexPath.row == 0){
        return 44;
    }
    
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 2) {
        [self.parentViewController performSegueWithIdentifier:@"showOtherStores" sender:nil];
    }else if(indexPath.row == 1 &&indexPath.section == 0){
        [self.parentViewController performSegueWithIdentifier:@"showMap" sender:nil];
    }else if(indexPath.row == 0 && indexPath.section == 0){
        NSString *message = [NSString stringWithFormat:@"您确定拨打 %@ 吗？",self.store.cellPhone];
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 44, 300, 100)];
        messageLabel.text = message;
        messageLabel.numberOfLines = 0;
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor redColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提示\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [actionSheet addSubview:messageLabel];
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
    }else if(indexPath.section == 0 && indexPath.row == 2  ){
        if (self.store.merchant.url.length) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.store.merchant.url]]];
        }
    
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.store.cellPhone]]];
    }
}


- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIImage *image = [UIImage imageNamed:@"联系信息"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
         return imageView;
    }else if(section == 1){
        UIImage *image = [UIImage imageNamed:@"商户简介"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        return imageView;

    }
    return nil;
}
@end















