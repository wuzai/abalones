//
//  WZButton.h
//  Abalone
//
//  Created by chen  on 13-10-25.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol QCheckBoxDelegate;

@interface WZButton : UIButton {
    id<QCheckBoxDelegate> _delegate;
    BOOL _checked;
    id _userInfo;
}

@property(nonatomic, strong)id<QCheckBoxDelegate> delegate;
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, strong)id userInfo;

- (id)initWithDelegate:(id)delegate;

@end

@protocol QCheckBoxDelegate <NSObject>

@optional

- (void)didSelectedCheckBox:(WZButton *)checkbox checked:(BOOL)checked;

@end
