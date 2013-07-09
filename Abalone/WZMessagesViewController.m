//
//  WZMessagesViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-2.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessagesViewController.h"
#import "WZMessageCell.h"
#import "WZMessage.h"
#import "WZUser+Me.h"
#import "WZUser.h"
#import "NSDate+Approximation.h"
#import <RestKit/RestKit.h>
#import "UILabel+Zoom.h"
#import <RestKit/RestKit.h>
#import "WZMessage+Image.h"
#import "WZMerchant.h"
#import "WZMessage+Networks.h"
#import "WZUser+Networks.h"
#import "WZStore.h"
#import "WZMyStoreDetailViewController.h"
#import "WZUser+Equal.h"

@interface WZMessagesViewController ()<UIAlertViewDelegate> {
    IBOutlet UITableView *_tableView;
    NSMutableArray *_messages;
    UIBarButtonItem *_cleanupItem;
    NSIndexPath *_selectedIndexPath;
    UILabel *_testLabel;
    UIImage *_cellBackgroundImage;
    WZUser *_last;
}
- (void)download;
- (void)downloadSucceed:(NSNotification *)notification;
- (void)load;
- (void)reload;
@end

@implementation WZMessagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading;
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date];
}
- (void)reloadTableViewDataSource{
    NSLog(@"==开始加载数据");
   [self download];
    _reloading = YES;
}
- (void)doneLoadingTableViewData{
    NSLog(@"===加载完数据");
    _reloading = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadSucceed:) name:WZDownloadMessageSucceedNotification object:nil];
    
    if([_messages count]>0)
    {
        [_tableView reloadData];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无短消息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
       // [alert release];
    }
    
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
     [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _cleanupItem = self.navigationItem.rightBarButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadSucceed:) name:WZDownloadMessageSucceedNotification object:nil];
    _cellBackgroundImage = [[UIImage imageNamed:@"cell.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30)];
    
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view1 = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f-_tableView.bounds.size.height, _tableView.frame.size.width, self.view.bounds.size.height)];
        view1.backgroundColor=[UIColor clearColor];
        view1.delegate = self;
        [_tableView addSubview:view1];
        _refreshHeaderView = view1;
       // [view1 release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WZUser *me = [WZUser me];
    if (![me isEqualToUser:_last]) {
        [self reload];
    }
    _last = me;
    [self download];
}

#pragma mark - Reload
- (void)load
{
    if (!_messages) {
        _messages = [NSMutableArray new];
    }
    WZUser *me = [WZUser me];
    if (!me) {
        [_messages removeAllObjects];
        [_tableView reloadData];
        self.navigationItem.rightBarButtonItem = nil;
    }
    else if (![_messages count])
    {
        [_messages addObjectsFromArray:[me.messages allObjects]];
        [_tableView reloadData];
        self.navigationItem.rightBarButtonItem = [_messages count]>0?_cleanupItem:nil;
    }
    
    
}

- (void)reload
{
    if (!_messages) {
        _messages = [NSMutableArray new];
    }
    [_messages removeAllObjects];
    _selectedIndexPath = nil;
    [self load];
}

#pragma mark - TableView DataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messages count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 90;
    if ([_selectedIndexPath isEqual:indexPath]) {
        WZMessage *message = [_messages objectAtIndex:indexPath.row];
        if (!_testLabel) {
            _testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 10)];
            _testLabel.numberOfLines = 0;
            _testLabel.font = [UIFont systemFontOfSize:12];
        }
        _testLabel.text = message.content;
        [_testLabel zoom];
        CGFloat newHeight = (height-42)+_testLabel.frame.size.height;
        height = MAX(height, newHeight);
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    WZMessage *message = [_messages objectAtIndex:indexPath.row];
    cell.titleLabel.text = message.title;
    cell.dateLabel.text = [message.sentTime approximationSinceNow];
    cell.contentLabel.text = message.content;
    cell.logoView.imageURL = message.imageURL;
    if ([_selectedIndexPath isEqual:indexPath]) {
        _testLabel.text = message.content;
        [_testLabel zoom];
        if (_testLabel.frame.size.height>42) {
            [cell.contentLabel zoom];
        }
    }
    else
    {
        CGRect frame = cell.contentLabel.frame;
        frame.size.height = 42;
        cell.contentLabel.frame = frame;
    }
    [cell.backgroundImageView setImage:_cellBackgroundImage];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删 除";
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle==UITableViewCellEditingStyleDelete) {
//        //        获取选中删除行索引值
//        NSInteger row = [indexPath row];
//        //        通过获取的索引值删除数组中的值
//        [_messages removeObjectAtIndex:row];
//        //        删除单元格的某一行时，在用动画效果实现删除过程
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }  
//}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *indexPaths = [NSMutableArray new];
    if ([_selectedIndexPath isEqual:indexPath]) {
        _selectedIndexPath = nil;
        [indexPaths addObject:indexPath];
    }
    else if (_selectedIndexPath) {
        NSIndexPath *copy = [_selectedIndexPath copy];
        _selectedIndexPath = indexPath;
        [indexPaths addObject:copy];
        [indexPaths addObject:indexPath];
    }
    else
    {
        _selectedIndexPath = indexPath;
        [indexPaths addObject:indexPath];
    }
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _selectedIndexPath==nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        WZMessage *message = [_messages objectAtIndex:indexPath.row];
        [message deleteEntity];
        [_messages removeObject:message];
        [[RKObjectManager sharedManager].objectStore save:nil];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.navigationItem.rightBarButtonItem = [_messages count]>0?_cleanupItem:nil;
    }
}

#pragma mark - Cleanup

- (IBAction)cleanup:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定清空" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)_cleanup
{
    [_messages makeObjectsPerformSelector:@selector(deleteEntity)];
    [[RKObjectManager sharedManager].objectStore save:nil];
    [self reload];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==alertView.firstOtherButtonIndex) {
        [self _cleanup];
    }
}

#pragma mark -
- (IBAction)lookupMerchant:(id)sender
{
    UIView *view = sender;
    while (view && ![view isKindOfClass:[UITableViewCell class]]) {
        view = view.superview;
    }
    if ([view isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell *)view];
        WZMessage *message = [_messages objectAtIndex:indexPath.row];
        WZStore *store = message.store;
        if (store) {
            [self performSegueWithIdentifier:@"Store" sender:store];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Store"]) {
        WZMyStoreDetailViewController *detailVC = segue.destinationViewController;
        detailVC.store = sender;
    }
}

#pragma mark -

- (void)download
{
    [[WZUser me] downloadMessages];
}

- (void)downloadSucceed:(NSNotification *)notification
{
    NSArray *results = [[notification userInfo] objectForKey:kWZNetworkResultsKey];
    if ([results count]) {
        [self reload];
    }
}
@end
