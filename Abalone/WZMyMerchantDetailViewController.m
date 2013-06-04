//
//  WZMyMerchantDetailViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-16.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMyMerchantDetailViewController.h"
#import "WZMerchantCardCell.h"
#import "WZMerchantServiceCell.h"

@interface WZMyMerchantDetailViewController ()

@end

static NSString *serviceCellIdentifier = @"merchantServiceCell";
static NSString *merchantCardCellIdentifier = @"merchantCardCell";

@implementation WZMyMerchantDetailViewController

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
    NSBundle *classBundle = [NSBundle bundleForClass:[WZMerchantCardCell class]];
    UINib *merchantCardCellNib = [UINib nibWithNibName:@"merchantCardCell" bundle:classBundle];
    [self.tableView registerNib:merchantCardCellNib forCellReuseIdentifier:merchantCardCellIdentifier];
    
    classBundle = [NSBundle bundleForClass:[WZMerchantServiceCell class]];
    UINib *merchantServiceCellNib = [UINib nibWithNibName:@"servicesCell" bundle:classBundle];
    [self.tableView registerNib:merchantServiceCellNib forCellReuseIdentifier:serviceCellIdentifier];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSInteger row = indexPath.row;
    if (row == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:merchantCardCellIdentifier];
        if ([cell isKindOfClass:[WZMerchantCardCell class]]) {
            WZMerchantCardCell *merchantCell = (WZMerchantCardCell *)cell;
            [merchantCell.pointChangeButton addTarget:self action:@selector(pointChange:) forControlEvents:UIControlEventTouchUpInside];
            [merchantCell.merchantInfoButton addTarget:self action:@selector(merchantInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        cell = [self.tableView dequeueReusableCellWithIdentifier:serviceCellIdentifier];
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        return 230;
    }else{
        return 70;
    }
}


-(void)pointChange:(UIButton *)button
{
    
}

-(void)merchantInfo:(UIButton *)button
{
    [self performSegueWithIdentifier:@"showTheMerchantInfo" sender:nil];
}

@end




