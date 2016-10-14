//
//  TestInfoVC.h
//  ClothingMaster
//
//  Created by Lym on 16/4/18.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestInfoVC : UIViewController
@property(nonatomic,copy,readonly)NSString *TestTitle;
-(void)setInfo:(NSString *)Info;
@end
