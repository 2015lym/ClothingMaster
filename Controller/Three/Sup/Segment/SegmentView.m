//
//  SegmentView.m
//  Segment
//
//  Created by MyMac on 15/11/24.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "SegmentView.h"
#import "UIView+Extension.h"


#define SINGLE_LINE_WIDTH   (1 / [UIScreen mainScreen].scale)

@interface SegmentView ()

@property (nonatomic,strong) NSMutableArray *segmentButtons; /**< 分段选择按钮数组*/

@property (nonatomic,strong) UIView *moveView; /**< 底部移动线*/

@property (nonatomic,strong) UIView *bottomView; /**< 底部分割线*/

@end

@implementation SegmentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

/**
 *  初始化
 */
- (void)initialize{
    self.backgroundColor = [UIColor whiteColor];
    _segmentButtons = [[NSMutableArray alloc] init];
    _showBottomView = YES;
    _selectedIndex = 0;
    _bottomLineHeight = 4 * SINGLE_LINE_WIDTH;
    _normalTitleColor = [UIColor blueColor];
    _selectedTitleColor = [UIColor greenColor];
    _isSameTextWidth = NO;
    _bottomViewColor = [UIColor grayColor];
    _moveViewColor = [UIColor redColor];
    _fontSize = [UIFont systemFontOfSize:14.0f];
}


- (void)addSegmentButton{
    
    CGFloat boundsW = self.frame.size.width;
    CGFloat boundsH = self.frame.size.height;
    
    CGFloat segmentW = boundsW / self.titles.count;
    if (self.titles.count > 0) {
        for (int i = 0; i < self.titles.count; i ++) {
            UIButton *segmentButton = [[UIButton alloc] init];
            [segmentButton setTitle:self.titles[i] forState:UIControlStateNormal];
            [segmentButton setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
            [segmentButton setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
            segmentButton.titleLabel.font = self.fontSize;
            segmentButton.tag = i + 1;
            [segmentButton addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            segmentButton.frame = CGRectMake(i * segmentW, 0, segmentW, boundsH - self.bottomLineHeight);
            [self.segmentButtons addObject:segmentButton];
            [self addSubview:segmentButton];
        }
        
        self.bottomView = [[UIView alloc] init];
        self.bottomView.backgroundColor = self.bottomViewColor;
        self.bottomView.frame = CGRectMake( 0, boundsH - self.bottomLineHeight, boundsW, self.bottomLineHeight);
        [self addSubview:self.bottomView];
        
        self.moveView = [[UIView alloc] init];
        self.moveView.backgroundColor = self.moveViewColor;
        [self addSubview:self.moveView];
        
        
        UIButton *segment = self.segmentButtons[self.selectedIndex];
        segment.selected = YES;
        
        if (self.isSameTextWidth) {
            CGSize textSize = [self titleSize:segment];
            self.moveView.frame = CGRectMake(segment.x + (segmentW - textSize.width) * 0.5, self.bottomView.y, textSize.width, self.bottomView.height);
        }else{
            self.moveView.frame = CGRectMake(self.selectedIndex * segmentW, self.bottomView.y, segmentW, self.bottomView.height);
        }
        
        self.bottomView.hidden = !self.showBottomView;
        
        
    }
}


- (void)segmentButtonClick:(UIButton *)sender{
    _selectedIndex = sender.tag - 1;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:DidClickedSegmentButton:)]) {
        [self.delegate segmentView:self DidClickedSegmentButton:sender];
    }
    CGFloat width = self.bounds.size.width / self.titles.count;
    [self moveWithCGRect:sender withWidth:width];
}

- (void)moveWithCGRect:(UIButton *)sender withWidth:(CGFloat)width{
    [UIView animateWithDuration:0.3f animations:^{
        [self chageSegmentButtonState:sender];
        self.moveView.frame = [self changeMoveViewFrame:sender withWidth:width];
    }];
}

//改变底部横线的位置
- (CGRect)changeMoveViewFrame:(UIButton *)sender withWidth:(CGFloat)width{
    CGSize textSize = [self titleSize:sender];
    CGRect moveViewFrame = self.moveView.frame;
    if (self.isSameTextWidth) {
        moveViewFrame.origin.x = sender.x + (width - textSize.width) * 0.5;
        moveViewFrame.size.width = textSize.width;
    }else{
        moveViewFrame.origin.x = (sender.tag - 1) * width;
        moveViewFrame.size.width = width;
    }
    return moveViewFrame;
}

//改变segmentButton按钮状态
- (void)chageSegmentButtonState:(UIButton *)sender{
    for (int i = 0; i < self.titles.count; i ++) {
        UIButton *segement = self.segmentButtons[i];
        if (i == sender.tag - 1) {
            segement.selected = YES;
        }else{
            segement.selected = NO;
        }
    }
}

//通过按钮计算对应title的CGSize
- (CGSize)titleSize:(UIButton *)segmentButton{
    NSDictionary *attr = @{NSFontAttributeName :segmentButton.titleLabel.font};
    return [segmentButton.titleLabel.text sizeWithAttributes:attr];
}

#pragma mark - getter and setter
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self addSegmentButton];
}

- (void)setShowBottomView:(BOOL)showBottomView{
    _showBottomView = showBottomView;
    self.bottomView.hidden = !showBottomView;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    
    for (int i = 0; i < self.titles.count; i ++) {
        UIButton *segement = self.segmentButtons[i];
        if (i == selectedIndex) {
            segement.selected = YES;
        }else{
            segement.selected = NO;
        }
    }
    
    UIButton *segment = self.segmentButtons[self.selectedIndex];
    segment.selected = YES;
    
    CGFloat boundsW = self.frame.size.width;
    CGFloat segmentW = boundsW / self.titles.count;
    
    if (self.isSameTextWidth) {
        CGSize textSize = [self titleSize:segment];
        self.moveView.frame = CGRectMake(segment.x + (segmentW - textSize.width) * 0.5, self.bottomView.y, textSize.width, self.bottomView.height);
    }else{
        self.moveView.frame = CGRectMake(self.selectedIndex * segmentW, self.bottomView.y, segmentW, self.bottomView.height);
    }
    
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor{
    _normalTitleColor = normalTitleColor;
    
    for (int i = 0; i < self.titles.count; i ++) {
        UIButton *segment = self.segmentButtons[i];
        [segment setTitleColor:normalTitleColor forState:UIControlStateNormal];
    }
    
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = selectedTitleColor;
    for (int i = 0; i < self.titles.count; i ++) {
        UIButton *segment = self.segmentButtons[i];
        [segment setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
}

- (void)setBottomLineHeight:(NSInteger)bottomLineHeight{
    _bottomLineHeight = bottomLineHeight;
    self.bottomView.height = bottomLineHeight;
    self.moveView.height = bottomLineHeight;
}

- (void)setBottomViewColor:(UIColor *)bottomViewColor{
    _bottomViewColor = bottomViewColor;
    self.bottomView.backgroundColor = bottomViewColor;
}

- (void)setMoveViewColor:(UIColor *)moveViewColor{
    _moveViewColor = moveViewColor;
    self.moveView.backgroundColor = moveViewColor;
}

- (void)setFontSize:(UIFont *)fontSize{
    _fontSize = fontSize;
    for (int i = 0; i < self.titles.count; i ++) {
        UIButton *segment = self.segmentButtons[i];
        segment.titleLabel.font = fontSize;
    }
}


@end
