//
//  ConstellFlowLayoutCell.m
//  ConstellationMaster
//
//  Created by Lym on 16/3/27.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "ConstellFlowLayoutCell.h"
#import "Masonry.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ConstellFlowLayoutCell
@synthesize CellImg,CellText;
-(void)initContent
{
    CellImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/4, ScreenWidth/4)];
    [self.contentView addSubview:CellImg];

    CellText=[[UILabel alloc]init];
    CellText.font=[UIFont systemFontOfSize:ScreenWidth/25];
    
    /*   **---文字居中---**   */
    CellText.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:CellText];
    [CellText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(CellImg).offset(ScreenWidth/20);
        make.centerX.mas_equalTo(CellImg);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/5, ScreenWidth/20));          =     }];

}
@end
