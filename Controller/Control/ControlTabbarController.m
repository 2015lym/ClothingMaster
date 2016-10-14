//
//  ControlTabbarController.m
//  ClothingMaster
//
//  Created by Lym on 16/4/17.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "ControlTabbarController.h"
#import "NewDayViewController.h"
#import "AdviseViewController.h"
#import "DesignViewController.h"
#import "BrandViewController.h"
#import "PrivateViewController.h"
@interface ControlTabbarController ()<UITabBarControllerDelegate>
@property(nonatomic, strong) UIButton *openDrawerButton;
@end

@implementation ControlTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        NewDayViewController *VC1=[[NewDayViewController alloc]init];
        VC1.tabBarItem.image=[UIImage imageNamed:@"1"];
        VC1.title=@"今日推荐";
        UINavigationController *NC1=[[UINavigationController alloc]initWithRootViewController:VC1];
        [self addChildViewController:NC1];
    
        AdviseViewController *VC2=[[AdviseViewController alloc]init];
        VC2.tabBarItem.image=[UIImage imageNamed:@"2"];
        VC2.title=@"穿衣推荐";
        UINavigationController *NC2=[[UINavigationController alloc]initWithRootViewController:VC2];
        [self addChildViewController:NC2];
    
        DesignViewController *VC3=[[DesignViewController alloc]init];
        VC3.tabBarItem.image=[UIImage imageNamed:@"3"];
        VC3.title=@"搭配技巧";
        UINavigationController *NC3=[[UINavigationController alloc]initWithRootViewController:VC3];
        [self addChildViewController:NC3];
    
        BrandViewController *VC4=[[BrandViewController alloc]init];
        VC4.tabBarItem.image=[UIImage imageNamed:@"4"];
        VC4.title=@"知名品牌";
        UINavigationController *NC4=[[UINavigationController alloc]initWithRootViewController:VC4];
        [self addChildViewController:NC4];
    
        PrivateViewController *VC5=[[PrivateViewController alloc]init];
        VC5.tabBarItem.image=[UIImage imageNamed:@"5"];
        VC5.title=@"个人设置";
        UINavigationController *NC5=[[UINavigationController alloc]initWithRootViewController:VC5];
        [self addChildViewController:NC5];
    
    
            self.tabBar.layer.shadowColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1].CGColor;
            self.tabBar.layer.shadowOpacity = 1;
            self.tabBar.layer.shadowRadius = 10;
            self.tabBar.tintColor = [UIColor colorWithRed:1 green:157/255.0 blue:158/255.0 alpha:1];
            self.tabBar.translucent = NO;


}
//在控制器上层controller调用viewwillappear
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.selectedIndex=self.selectVCIndex;
}
//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return NO;
}
//修改状态栏的外观,亮色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
