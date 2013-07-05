//
//  WZShowMyStoreDetailViewController.h
//  Abalone
//
//  Created by 陈 海涛 on 13-7-5.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZStore.h"
#import "iCarousel.h"

@interface WZShowMyStoreDetailViewController : UIViewController<iCarouselDataSource,iCarouselDelegate,UIActionSheetDelegate>

@property (nonatomic,strong)WZStore *store;



@end

