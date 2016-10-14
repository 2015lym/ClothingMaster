//
//  AdviseViewController.m
//  ClothingMaster
//
//  Created by Lym on 16/4/6.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "AdviseViewController.h"
#import "AdvTestVC.h"
#import "Masonry.h"
#import "RESideMenu.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface AdviseViewController ()

@end

@implementation AdviseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
   
    [self createFourBtn];
    
    
}

-(void)createFourBtn
{
    
    /*体型推荐按钮和标签*/
    UIButton *BodyTestBtn=[[UIButton alloc]init];
    BodyTestBtn.tag=1;
    [BodyTestBtn setBackgroundImage:[UIImage imageNamed:@"Test1.png"]forState:UIControlStateNormal];
    [BodyTestBtn addTarget:self action:@selector(buttonChoose:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BodyTestBtn];
    [BodyTestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/3, ScreenWidth/3));
        make.left.mas_equalTo(self.view).offset(ScreenWidth/10);
        make.top.mas_equalTo(self.view).offset(ScreenWidth/8);
    }];
    UILabel *BodyTestLbl=[[UILabel alloc]init];
    BodyTestLbl.text=@"体型推荐";
    BodyTestLbl.textAlignment = NSTextAlignmentCenter;
    [BodyTestLbl setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [BodyTestLbl setTextColor:[UIColor grayColor]];
    [self.view addSubview:BodyTestLbl];
    [BodyTestLbl mas_makeConstraints:^(MASConstraintMaker *make) {         //标签 X轴居于按钮中央，Y轴位于按钮正下方
        make.bottom.mas_equalTo(BodyTestBtn).offset(ScreenWidth/10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/4.1, ScreenWidth/10));
        make.centerX.mas_equalTo(BodyTestBtn);
    }];
    
    
    /*场合推荐按钮和标签*/
    UIButton *OccasionTestBtn=[[UIButton alloc]init];
    OccasionTestBtn.tag=2;
    [OccasionTestBtn setBackgroundImage:[UIImage imageNamed:@"Test2.png"]forState:UIControlStateNormal];
    [OccasionTestBtn addTarget:self action:@selector(buttonChoose:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OccasionTestBtn];
    [OccasionTestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/3, ScreenWidth/3));
        make.right.mas_equalTo(self.view).offset(-ScreenWidth/10);
        make.top.mas_equalTo(self.view).offset(ScreenWidth/8);
    }];
    UILabel *OccasionTestLbl=[[UILabel alloc]init];
    OccasionTestLbl.text=@"场合推荐";
    OccasionTestLbl.textAlignment = NSTextAlignmentCenter;
    [OccasionTestLbl setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [OccasionTestLbl setTextColor:[UIColor grayColor]];
    [self.view addSubview:OccasionTestLbl];
    [OccasionTestLbl mas_makeConstraints:^(MASConstraintMaker *make) {     //标签 X轴居于按钮中央，Y轴位于按钮正下方
        make.bottom.mas_equalTo(OccasionTestBtn).offset(ScreenWidth/10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/4.1, ScreenWidth/10));
        make.centerX.mas_equalTo(OccasionTestBtn);
    }];
    
    
    /*情节推荐按钮和标签*/
    UIButton *ActionTestBtn=[[UIButton alloc]init];
    ActionTestBtn.tag=3;
    [ActionTestBtn setBackgroundImage:[UIImage imageNamed:@"Test3.png"]forState:UIControlStateNormal];
    [ActionTestBtn addTarget:self action:@selector(buttonChoose:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ActionTestBtn];
    [ActionTestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/3, ScreenWidth/3));
        make.left.mas_equalTo(self.view).offset(ScreenWidth/10);
        make.top.mas_equalTo(BodyTestBtn).offset(ScreenWidth/1.8);
    }];
    UILabel *ActionTestLbl=[[UILabel alloc]init];
    ActionTestLbl.text=@"情节推荐";
    ActionTestLbl.textAlignment = NSTextAlignmentCenter;
    [ActionTestLbl setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [ActionTestLbl setTextColor:[UIColor grayColor]];
    [self.view addSubview:ActionTestLbl];
    [ActionTestLbl mas_makeConstraints:^(MASConstraintMaker *make) {       //标签 X轴居于按钮中央，Y轴位于按钮正下方
        make.bottom.mas_equalTo(ActionTestBtn).offset(ScreenWidth/10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/4.1, ScreenWidth/10));
        make.centerX.mas_equalTo(ActionTestBtn);
    }];
    
    
    /*性格推荐按钮和标签*/
    UIButton *PersonalityTestBtn=[[UIButton alloc]init];
    PersonalityTestBtn.tag=4;
    [PersonalityTestBtn setBackgroundImage:[UIImage imageNamed:@"Test4.png"]forState:UIControlStateNormal];
    [PersonalityTestBtn addTarget:self action:@selector(buttonChoose:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PersonalityTestBtn];
    [PersonalityTestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/3, ScreenWidth/3));
        make.right.mas_equalTo(self.view).offset(-ScreenWidth/10);
        make.top.mas_equalTo(OccasionTestBtn).offset(ScreenWidth/1.8);
    }];
    UILabel *PersonalityTestLbl=[[UILabel alloc]init];
    PersonalityTestLbl.text=@"性格推荐";
    PersonalityTestLbl.textAlignment = NSTextAlignmentCenter;
    [PersonalityTestLbl setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [PersonalityTestLbl setTextColor:[UIColor grayColor]];
    [self.view addSubview:PersonalityTestLbl];
    [PersonalityTestLbl mas_makeConstraints:^(MASConstraintMaker *make) {   //标签 X轴居于按钮中央，Y轴位于按钮正下方
        make.bottom.mas_equalTo(PersonalityTestBtn).offset(ScreenWidth/10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/4.1, ScreenWidth/10));
        make.centerX.mas_equalTo(PersonalityTestBtn);
    }];
    
}

#pragma mark 按钮效果 标签控制
-(void)buttonChoose:(id)Btn
{
    UIButton *ButtonControl=Btn;
    switch (ButtonControl.tag) {
        case 1:
        {
            AdvTestVC *InfoVC=[[AdvTestVC alloc]init];
            
            extern void getData(NSString* name);
            
            getData(@"体型推荐");
            
            [self.navigationController pushViewController:InfoVC animated:YES];
            
            break;
        }
        case 2:
        {
            AdvTestVC *InfoVC=[[AdvTestVC alloc]init];
            
            extern void getData(NSString* name);
            
            getData(@"场合推荐");
            
            [self.navigationController pushViewController:InfoVC animated:YES];
            break;
        }
        case 3:
        {
            AdvTestVC *InfoVC=[[AdvTestVC alloc]init];
            
            extern void getData(NSString* name);
            
            getData(@"情节推荐");
            
            [self.navigationController pushViewController:InfoVC animated:YES];
            break;
        }
        case 4:
        {
            AdvTestVC *InfoVC=[[AdvTestVC alloc]init];
            
            extern void getData(NSString* name);
            
            getData(@"性格推荐");
            
            [self.navigationController pushViewController:InfoVC animated:YES];
            break;
        }
        default:
            break;
    }
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
