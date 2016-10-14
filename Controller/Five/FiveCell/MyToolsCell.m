//
//  MyToolsCell.m
//  ClothingMaster
//
//  Created by Lym on 16/4/12.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "MyToolsCell.h"

@implementation MyToolsCell
- (id) initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.imgBtn = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.imgBtn];
    }
    return self;
}
@end
