//
//  WZStoreTypeSelectorViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-29.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStoreTypeSelectorViewController.h"
#import "WZStore+AllTypes.h"
#import "WZStoresViewController.h"

@interface WZStoreTypeSelectorViewController ()

@end

static NSString *CellIdentifier = @"MenuCell";

@implementation WZStoreTypeSelectorViewController

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.myTableView];
    
    NSBundle *classBundle = [NSBundle bundleForClass:[WZMenuCell class]];
    UINib *nib = [UINib nibWithNibName:@"MenuCell" bundle:classBundle];
    [self.myTableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
   
}

-(void)loadData
{
    self.types = [NSMutableArray arrayWithArray:[WZStore allTypes]];
    if (self.types.count) {
        [self.myTableView reloadData];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.types.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ([cell isKindOfClass:[WZMenuCell class]]) {
        WZMenuCell *menuCell = (WZMenuCell *)cell;
        menuCell.MenuTitle.text = self.types[indexPath.row];
        if ([self.selectedType isEqualToString:self.types[indexPath.row]]) {
            menuCell.MenubackgroudView.image = [UIImage imageNamed:@"MenuSelected"];
        }else{
             menuCell.MenubackgroudView.image = [UIImage imageNamed:@"Menu"];
        }
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.title = self.types[indexPath.row];
    if ([self.parentViewController isKindOfClass:[WZStoresViewController class]]) {
        WZStoresViewController *storeContrl = (WZStoresViewController *) self.parentViewController;
        storeContrl.title = self.types[indexPath.row];
        self.selectedType = self.types[indexPath.row];
      //  [storeContrl.storeListViewController loadData];
        [tableView reloadData];
    }
   
}

@end





















