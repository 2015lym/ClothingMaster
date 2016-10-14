//
//  FiveTableViewCell.h
//  ClothingMaster
//
//  Created by Lym on 16/4/12.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiveTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView * imgViewBored;
@property (nonatomic,strong) UILabel * label;

- (id)initWithMyOfReuseIdentifier:(NSString *)reuseIdentifier andSection:(NSInteger)section;

- (id)initWithCollectionOfReuseIdentifier:(NSString *)reuseIdentifier;
@end
