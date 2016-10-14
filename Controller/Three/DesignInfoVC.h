//
//  DesignInfoVC.h
//  ClothingMaster
//
//  Created by Lym on 16/4/14.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DesignInfoVC : UIViewController
@property(nonatomic,copy,readonly)NSString *DesignTitle;
-(void)setInfo:(NSString *)Info;
@end
