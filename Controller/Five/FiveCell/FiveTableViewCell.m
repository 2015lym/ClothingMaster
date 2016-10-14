//
//  FiveTableViewCell.m
//  ClothingMaster
//
//  Created by Lym on 16/4/12.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "FiveTableViewCell.h"
#import "Masonry.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


@implementation FiveTableViewCell
- (id)initWithMyOfReuseIdentifier:(NSString *)reuseIdentifier andSection:(NSInteger)section{
    
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.imgViewBored = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgViewBored];
        self.imgViewBored.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        [self.imgViewBored mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.left.mas_equalTo(5);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10, 0.9));   //每个Cell都有0.9的间隔
        }];
    }
    return self;
}

- (id)initWithCollectionOfReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        self.imgViewBored = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgViewBored];
        [self.imgViewBored mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(100, 70));
        }];
        
        self.label = [[UILabel alloc]init];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(120);
            make.size.mas_equalTo(CGSizeMake(200, 30));
        }];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
