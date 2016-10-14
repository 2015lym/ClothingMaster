//
//  DesignInfoVC.m
//  ClothingMaster
//
//  Created by Lym on 16/4/14.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "DesignInfoVC.h"
#import "DesignData.h"
#import "Masonry.h"
#import "Like.h"
#import "CoreDataBase+Query.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface DesignInfoVC ()
{
        UIButton *LikeBtn;
        NSMutableArray *CoreDatasArray;
}
@end

@implementation DesignInfoVC
@synthesize DesignTitle;
-(void)setInfo:(NSString *)Info
{
    DesignTitle=Info;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=DesignTitle;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];                //title字体颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];  //返回按钮颜色
    
    
    
    
    DesignData *__DesignData=[[DesignData alloc]init];
    
    UIView *DesignInfoView=[[UIView alloc]init];
    DesignInfoView.backgroundColor=[UIColor colorWithRed:20/255.0 green:200/255.0 blue:240/255.0 alpha:0.3];
    [DesignInfoView.layer setCornerRadius:12.0]; //边框变圆滑
    [self.view addSubview:DesignInfoView];
    [DesignInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(4*ScreenWidth/5, ScreenHeight-160));
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *DesignInfo=[[UILabel alloc]init];
    DesignInfo.text=[__DesignData getData:DesignTitle];
    DesignInfo.textAlignment = NSTextAlignmentCenter;
    [DesignInfo setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [DesignInfo setTextColor:[UIColor grayColor]];
    DesignInfo.numberOfLines=0;
    [DesignInfoView addSubview:DesignInfo];
    [DesignInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(DesignInfoView);
        make.left.mas_equalTo(DesignInfoView).offset(ScreenWidth/15);
        make.size.mas_equalTo(CGSizeMake(2*ScreenWidth/3, ScreenHeight-160));
       
    }];
    
    LikeBtn=[[UIButton alloc]init];
    LikeBtn.backgroundColor=[UIColor greenColor];
    [LikeBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [LikeBtn addTarget:self action:@selector(creatCoreData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LikeBtn];
    [LikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(DesignInfoView).offset(15);
        make.left.mas_equalTo(DesignInfoView).offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/5, ScreenWidth/12));
        
    }];
    
    
    CoreDataBase *cdb = [CoreDataBase shardCoreDataBase];
    CoreDatasArray=[cdb queryEntityName:@"Like" Where:nil];
    for (int i=0; i<CoreDatasArray.count; i++) {
        Like *searchlike=CoreDatasArray[i];
        if ([DesignTitle isEqualToString:searchlike.name]) {
            [LikeBtn setTitle:@"已收藏" forState:UIControlStateNormal];
            break;
        }
    }
}
-(void)creatCoreData
{
    [LikeBtn setTitle:@"已收藏" forState:UIControlStateNormal];
    int Cnametest=0;
    CoreDataBase *cdb = [CoreDataBase shardCoreDataBase];
    CoreDatasArray=[cdb queryEntityName:@"Like" Where:nil];
    for (int i=0; i<CoreDatasArray.count; i++) {
        Like *searchlike=CoreDatasArray[i];
        if ([DesignTitle isEqualToString:searchlike.name]) {  //字符串不能用==
            Cnametest=1;
            break;
        }
    }
    
    if(Cnametest==0)
    {
        Like *newlike=[NSEntityDescription insertNewObjectForEntityForName:@"Like" inManagedObjectContext:cdb.managedObjectContext];
        newlike.name=DesignTitle;
        [cdb saveContext];
        NSLog(@"添加收藏：%@",newlike.name);
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
