//
//  WebViewController.h
//  ClothingMaster
//
//  Created by Lym on 16/4/19.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property(nonatomic,strong,readonly)NSArray *WebArray;
@property(nonatomic,strong,readonly)NSArray *WebDataArray;
@property(nonatomic,copy)NSString *WebData;
-(NSString *)getWebURL:(NSString *)WebName;
@end
