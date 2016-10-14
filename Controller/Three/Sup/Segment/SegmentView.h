//
//  SegmentView.h
//  Segment
//
//  Created by MyMac on 15/11/24.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentView;
@protocol SegmentViewDelegate <NSObject>

@optional
- (void)segmentView:(SegmentView *)segmentView DidClickedSegmentButton:(UIButton *)segmentButton;

@end

@interface SegmentView : UIView

@property (nonatomic,strong) NSArray *titles; /**< 分段选择按钮文字数组*/

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,assign) BOOL showBottomView; /**< 是否显示底部分割线 默认显示*/

@property (nonatomic,assign) NSInteger bottomLineHeight; /**< 线高*/

@property (nonatomic,strong) UIColor *normalTitleColor; /**< 正常的文字颜色*/

@property (nonatomic,strong) UIColor *selectedTitleColor; /**< 选中的文字颜色*/

@property (nonatomic,strong) UIColor *bottomViewColor; /**< 底部分割线颜色*/

@property (nonatomic,strong) UIColor *moveViewColor ;  /**< 移动横线颜色*/

@property (nonatomic,assign) BOOL isSameTextWidth; /**< 移动横线是否和文字长度一样*/

@property (nonatomic,strong) UIFont *fontSize; // 文字大小


@property (nonatomic,weak) id<SegmentViewDelegate> delegate;


@end
