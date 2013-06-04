//
//  WZMyMerchantPointRecordListViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-7.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMyMerchantPointRecordListViewController.h"
#import "WZPointRecord+NetWorks.h"
#import "WZUser+Me.h"
#import "WZPointRecordCell.h"
#import "WZPointRecordDetailViewController.h"
#import "WZPointRecord.h"

@interface WZMyMerchantPointRecordListViewController ()
@property (nonatomic,strong)NSMutableArray *records;
@end


NSString *const cellIdentifier = @"pointRecordCell";
@implementation WZMyMerchantPointRecordListViewController
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"积分记录";
    [self addRefreshViewController];
    
    NSBundle *classBundle = [NSBundle bundleForClass:[WZPointRecordCell class]];
    UINib *nib = [UINib nibWithNibName:@"PointRecordCell" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
}

-(void)loadData
{
    WZUser *me = [WZUser me];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"WZPointRecord"];
    NSPredicate *predicate = nil;
    if (self.merchant) {
       predicate = [NSPredicate predicateWithFormat:@"userId=%@ and merchantId=%@ and type=%@",me.gid,self.merchant.gid,@"member"];
    }else{
        predicate = [NSPredicate predicateWithFormat:@"userId=%@ and type=%@",me.gid,@"user"];
    }
    request.predicate = predicate;
    NSArray *result = [WZPointRecord executeFetchRequest:request];
    self.records = [NSMutableArray arrayWithArray:result];
    [self.records sortUsingComparator:^(WZPointRecord *r1,WZPointRecord *r2){
        return [r2.createdAt compare:r1.createdAt];
    }];
}

-(BOOL)fetchPointRecord
{
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchPointRecordSuccess:) name:kFetchPointRecordSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchPointRecordFail:) name:KFetchPointRecordFailNotificationKey object:nil];
    NSString *theType = nil;
    switch (self.type) {
        case WZMemberType:
            theType = @"member";
            break;
        case WZUserType:
            theType = @"user";
            break;
        case WZMerchantType:
            theType = @"merchant";
            break;
        default:
            break;
    }
    if (!self.merchant) {
        self.type = WZUserType;
        theType = @"user";
    }

    return   [WZPointRecord fetchPointRecordForUserID:[[WZUser me] gid] andMerchantID:self.merchant.gid withType:theType];
   
   
    
}

-(void)fetchPointRecordSuccess:(NSNotification *)notification
{
    [self endRefreshViewController];
   
    if ([notification.object count]) {
        [self loadData];
        [self.tableView reloadData];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchPointRecordSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KFetchPointRecordFailNotificationKey object:nil];
}

-(void)fetchPointRecordFail:(NSNotification *)notification
{
    [self endRefreshViewController];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFetchPointRecordSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KFetchPointRecordFailNotificationKey object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    if([self fetchPointRecord]){
        [self.refreshControl beginRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中。。。。"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)addRefreshViewController
{
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(refreshViewControllerEventValueChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)refreshViewControllerEventValueChanged
{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中。。。。"];
    [self fetchPointRecord];
}

-(void)endRefreshViewController
{
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle =  [[NSAttributedString alloc] initWithString:@"下拉刷新"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.records.count ? self.records.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.records.count) {
        WZPointRecord *pointRecord = self.records[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ([cell isKindOfClass:[WZPointRecordCell class]] ) {
            WZPointRecordCell *prCell = (WZPointRecordCell *)cell;
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
            [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateStr = [dateFormater stringFromDate:pointRecord.createdAt];
            prCell.recordDate.text = dateStr;
            if (pointRecord.addPoint.intValue) {
                prCell.changeCount.text = [NSString stringWithFormat:@"%i",pointRecord.addPoint.intValue ];
                prCell.operateImage.image = [UIImage imageNamed:@"积分增加"];
            }else{
                prCell.changeCount.text = [NSString stringWithFormat:@"%i",pointRecord.decPoint.intValue ];
                 prCell.operateImage.image = [UIImage imageNamed:@"积分减少"];
            }
        prCell.totalPointCount.text = [NSString stringWithFormat:@"%i",pointRecord.surplusPoint.intValue];
        }
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.records.count) {
        return 60.0f;
    }
    return 0.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.records.count) {
        [self performSegueWithIdentifier:@"pointRecordDetail" sender:self.records[indexPath.row]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"pointRecordDetail" isEqualToString:segue.identifier]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setPointRecord:)]) {
            [segue.destinationViewController performSelector:@selector(setPointRecord:) withObject:sender];
        }
        if ([segue.destinationViewController isKindOfClass:[WZPointRecordDetailViewController class]]) {
            WZPointRecordDetailViewController *pointRecord = (WZPointRecordDetailViewController *)segue.destinationViewController;
            pointRecord.type = self.type;
        }
    }
}

@end





