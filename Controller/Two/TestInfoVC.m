//
//  TestInfoVC.m
//  ClothingMaster
//
//  Created by Lym on 16/4/18.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "TestInfoVC.h"
#import "Masonry.h"
#import "TestData.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface TestInfoVC ()

@end

@implementation TestInfoVC
@synthesize TestTitle;
-(void)setInfo:(NSString *)Info
{
    TestTitle=Info;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=TestTitle;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];                //title字体颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];  //返回按钮颜色

    TestData *__TestData=[[TestData alloc]init];
    
    UIView *TestInfoView=[[UIView alloc]init];
    TestInfoView.backgroundColor=[UIColor colorWithRed:20/255.0 green:200/255.0 blue:240/255.0 alpha:0.3];
    [TestInfoView.layer setCornerRadius:12.0]; //边框变圆滑
    [self.view addSubview:TestInfoView];
    [TestInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(4*ScreenWidth/5, ScreenHeight-160));
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *TestInfo=[[UILabel alloc]init];
    TestInfo.text=[__TestData getData:TestTitle];
    TestInfo.textAlignment = NSTextAlignmentCenter;
    [TestInfo setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [TestInfo setTextColor:[UIColor grayColor]];
    TestInfo.numberOfLines=0;
    [TestInfoView addSubview:TestInfo];
    [TestInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TestInfoView);
        make.left.mas_equalTo(TestInfoView).offset(ScreenWidth/15);
        make.size.mas_equalTo(CGSizeMake(2*ScreenWidth/3, ScreenHeight-160));
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
