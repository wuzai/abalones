//
//  WZMyStoreListCell.h
//  Abalone
//
//  Created by 吾在 on 13-5-4.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZMyStoreListCell.h"
#import "EGOImageView.h"

@interface WZMyStoreListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet EGOImageView *storeBigImage;
@property (weak, nonatomic) IBOutlet EGOImageView *LogoImge;
@property (weak, nonatomic) IBOutlet UILabel *storeText;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *distanceFromHere;

@end
