//
//  WZPointViewController.m
//  Abalone
//
//  Created by 吾在 on 13-5-6.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZPointViewController.h"
#import "WZUser+Me.h"
#import "WZUser+Networks.h"
#import "WZRegulation.h"
#import "UILabel+Zoom.h"
#import "WZRegulation+Network.h"

@interface WZPointViewController ()
{
    UILabel *_pointLabel;
    UIBarButtonItem *_pointItem;
}
- (void)reloadPoint;
- (void)reloadRegulation;
@end

@implementation WZPointViewController
@synthesize accessoryView = _accessoryView;
@synthesize imageView = _imageView;
@synthesize ruleLabel = _ruleLabel;

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
//    _imageView.images = @[@"积分1.jpg",@"积分2.jpg"];
    _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    _pointLabel.textAlignment = NSTextAlignmentRight;
    _pointLabel.backgroundColor = [UIColor clearColor];
    _pointLabel.font = [UIFont systemFontOfSize:20];
    _pointLabel.textColor = [UIColor whiteColor];
    _pointLabel.shadowColor = [UIColor darkGrayColor];
    _pointLabel.shadowOffset = CGSizeMake(0, -1);
    _pointItem = [[UIBarButtonItem alloc] initWithCustomView:_pointLabel];
    _pointItem = self.navigationItem.rightBarButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPoint) name:WZUserProfileGetSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRegulation) name:WZRegulationDidUpdatedNotification object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    static BOOL updated = NO;
    if (!updated) {
        [self reloadRegulation];
        [self reloadPoint];
        updated = YES;
    }
    
    [[WZUser me] fetch];
    WZUser *me = [WZUser me];
   
    if (me.gid) {
//        self.navigationItem.rightBarButtonItem = nil;
    }else{
         self.navigationItem.rightBarButtonItem = nil;
    }
    [WZRegulation updateRegulationVersion];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        CGRect frame = _ruleLabel.frame;
        return frame.size.height+10;
    }
    return 44;
}

#pragma mark - Table view delegate

#pragma mark -
- (void)reloadPoint
{
    self.navigationItem.rightBarButtonItem = [WZUser me]?_pointItem:nil;
//    WZUser *user = [WZUser me];
//    if (user) {
//        NSInteger point = user.point.intValue;
//        _pointLabel.text = [NSString stringWithFormat:@"%d粒",point];
//        self.navigationItem.rightBarButtonItem = _pointItem;
//    }
//    else {
//        self.navigationItem.rightBarButtonItem = nil;
//    }
}

- (void)reloadRegulation
{
    WZRegulation *regulation = [WZRegulation defaultRegulation];
    _imageView.images = regulation.pictures;
    _ruleLabel.text = regulation.rules;
    [_ruleLabel zoom];
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
}

@end
