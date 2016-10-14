//
//  ControlVC.m
//  ClothingMaster
//
//  Created by Lym on 16/4/17.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "ControlVC.h"
#import "ControlTabbarController.h"
#import "AppDelegate.h"
#import "NewDayViewController.h"
#import "AdviseViewController.h"
#import "DesignViewController.h"
#import "BrandViewController.h"
#import "PrivateViewController.h"
#import "MJRefresh.h"
#import "PrivateViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString * const kYCLeftViewControllerCellReuseId = @"kYCLeftViewControllerCellReuseId";
@interface ControlVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UILabel *WeatherDate;
    
    UILabel *LastRefreshTime;
    
    UILabel *CurrentTemperature;
    
    UILabel *CurrentTemperature2;
    
    UILabel *ColthingAdvise;
    
    UIButton *WeatherRefreshBtn;
    
    NSDictionary *InfoDict;
    
    NSMutableData *WeatherData;
    
    UIView *WeatherView;
}
@property (nonatomic, strong) NSArray *lefs;
@property (nonatomic, assign) NSInteger previousRow;
@property (nonatomic,strong) NSArray * imgArr;

@end

@implementation ControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.imgArr=@[@"Control1",@"Control2",@"Control3",@"Control4"];

    self.view.backgroundColor=[UIColor cyanColor];
    _lefs=@[@"首页",@"穿衣推荐",@"搭配技巧",@"个人设置"];
    _tableView=[[UITableView alloc]init];
    _tableView.frame=CGRectMake(0, 50, ScreenWidth, 160);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    //没有能重用的cell，则自动生成一个
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kYCLeftViewControllerCellReuseId];
    //去掉tableview每个cell之间的那条线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.tableView];

    
    WeatherView=[[UIView alloc]init];
    WeatherView.backgroundColor=[UIColor colorWithRed:20/255.0 green:200/255.0 blue:5/255.0 alpha:0.3];
    [WeatherView.layer setCornerRadius:12.0]; //边框变圆滑
    [self.view addSubview:WeatherView];
    [WeatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tableView).offset(170+ScreenWidth/10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2, ScreenWidth/2));
        make.left.mas_equalTo(self.view).offset(10);
    }];
    
    UILabel *WeatherTitle=[[UILabel alloc]init];
    WeatherTitle.text=@"－今日天气－";
        /*   **---文字居中---**   */
    WeatherTitle.textAlignment = NSTextAlignmentCenter;
    [WeatherTitle setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [WeatherTitle setTextColor:[UIColor grayColor]];
    [self.view addSubview:WeatherTitle];
    [WeatherTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_tableView).offset(ScreenWidth/10+10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/4.1, ScreenWidth/10));
        make.centerX.mas_equalTo(WeatherView);
    }];
    
    /*   ---初始化天气表格---   */
    [self weatherDataList];
    /*   ---获得天气数据---   */
    [self creatWeatherInfo];
    /*   ---刷新天气按钮---   */
    WeatherRefreshBtn=[[UIButton alloc]init];
    [WeatherRefreshBtn setBackgroundImage:[UIImage imageNamed:@"WeatherRefresh"]forState:UIControlStateNormal];
    [WeatherRefreshBtn addTarget:self action:@selector(refreshAnimationStart) forControlEvents:UIControlEventAllEvents];
    [WeatherView addSubview:WeatherRefreshBtn];
    [WeatherRefreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WeatherView).offset(5);
        make.left.mas_equalTo(WeatherView).offset(5);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/12, ScreenWidth/12));
        
    }];
    
}
-(void)refreshAnimationStart  //刷新动画 然后跳转到数据
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 4.0 ];
    rotationAnimation.duration = 0.8;
    rotationAnimation.cumulative = NO;
    [WeatherRefreshBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self creatWeatherInfo];
}
-(void)creatWeatherInfo
{
    NSString *WebString=@"http://op.juhe.cn/onebox/weather/query";
    NSDictionary *parameters=@{@"cityname":@"沈阳",@"key":@"54592bacd9d3d983300139078a138beb"};
    NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer]requestWithMethod:@"POST" URLString:WebString parameters:parameters error:nil];
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager=[[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURLSessionDataTask *datatask=[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            CurrentTemperature.text=@"好像没有联网!😓";
        }
        else
        {
            InfoDict=responseObject;
            WeatherData=responseObject[@"result"][@"data"][@"realtime"];
            
            
            /*   日期数据   */
            WeatherDate.text=[WeatherData valueForKey:@"date"];
            /*   最后刷新时间数据   */
            NSMutableString *LRTHead=[NSMutableString stringWithString:@"最后刷新时间:"];
            [LRTHead appendString:[WeatherData valueForKey:@"time"]];
            LastRefreshTime.text=LRTHead;
            /*   天气数据   */
            NSMutableString *CTHead1=[NSMutableString stringWithString:@"天气:"];
            [CTHead1 appendString:[InfoDict[@"result"][@"data"][@"realtime"][@"weather"] valueForKey:@"info"]];
            CurrentTemperature.text=CTHead1;
            /*   温度数据   */
            NSMutableString *CTHead2=[NSMutableString stringWithString:@"当前温度:"];
            [CTHead2 appendString:[InfoDict[@"result"][@"data"][@"realtime"][@"weather"] valueForKey:@"temperature"]];
            [CTHead2 appendString:@"℃"];
             CurrentTemperature2.text=CTHead2;
            /*   穿衣建议数据   */
            NSMutableString *CAHead=[NSMutableString stringWithString:@"    穿衣建议:"];
            NSMutableArray *CAInfoArray=InfoDict[@"result"][@"data"][@"life"][@"info"][@"chuanyi"];
            [CAHead appendString:CAInfoArray.lastObject];
            ColthingAdvise.text=CAHead;
        }
    }];
    [datatask resume];
}

-(void)weatherDataList
{
    CurrentTemperature=[[UILabel alloc]init];
    CurrentTemperature.textAlignment = NSTextAlignmentCenter;
    [CurrentTemperature setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [CurrentTemperature setTextColor:[UIColor grayColor]];
    [WeatherView addSubview:CurrentTemperature];
    [CurrentTemperature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WeatherView);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2.2, ScreenWidth/10));
        make.centerX.mas_equalTo(WeatherView);
    }];
    
    CurrentTemperature2=[[UILabel alloc]init];
    CurrentTemperature2.textAlignment = NSTextAlignmentCenter;
    [CurrentTemperature2 setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [CurrentTemperature2 setTextColor:[UIColor grayColor]];
    [WeatherView addSubview:CurrentTemperature2];
    [CurrentTemperature2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CurrentTemperature).offset(ScreenWidth/20);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2.2, ScreenWidth/10));
        make.centerX.mas_equalTo(WeatherView);
    }];
    
    ColthingAdvise=[[UILabel alloc]init];
    ColthingAdvise.numberOfLines=0;
    [ColthingAdvise setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [ColthingAdvise setTextColor:[UIColor grayColor]];
    [WeatherView addSubview:ColthingAdvise];
    [ColthingAdvise mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(CurrentTemperature2).offset(ScreenWidth/20);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2.2, ScreenWidth/3));
        make.centerX.mas_equalTo(WeatherView);
    }];
    
    WeatherDate=[[UILabel alloc]init];
    WeatherDate.textAlignment = NSTextAlignmentCenter;
    [WeatherDate setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [self.view addSubview:WeatherDate];
    [WeatherDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-ScreenWidth/10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2.2, ScreenWidth/10));
        make.centerX.mas_equalTo(WeatherView);
    }];
    
    
    LastRefreshTime=[[UILabel alloc]init];
    LastRefreshTime.textAlignment = NSTextAlignmentCenter;
    [LastRefreshTime setFont:[UIFont systemFontOfSize:ScreenWidth/25]];
    [self.view addSubview:LastRefreshTime];
    [LastRefreshTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(WeatherDate).offset(ScreenWidth/20);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2.2, ScreenWidth/10));
        make.centerX.mas_equalTo(WeatherView);
    }];
}
    
    
    
    



//MJRefresh
-(void)refreshScreen{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.mj_header = header;
}
-(void)loadNewData
{

        //刷新表格
        [_tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_tableView.mj_header endRefreshing];
}



//设置状态栏
-(BOOL)prefersStatusBarHidden{
    return NO;
}
//当前table就一个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//产生cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lefs.count;
}
/*
 **
 每个cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 40.f;
}
//重写cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //优化
    static NSString *identity=@"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    }
    cell.textLabel.text=self.lefs[indexPath.row];
    cell.textLabel.font= [UIFont fontWithName: @"Size" size:ScreenWidth/20];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:20.0];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.highlightedTextColor=[UIColor grayColor];
    cell.imageView.image=[UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.backgroundColor=[UIColor cyanColor];
    
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kYCLeftViewControllerCellReuseId forIndexPath:indexPath];
//    if (!cell) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kYCLeftViewControllerCellReuseId];
//    }
//    cell.textLabel.text=self.lefs[indexPath.row];
//    cell.textLabel.font=[UIFont boldSystemFontOfSize:20.0];
//    cell.textLabel.textColor=[UIColor blackColor];
//    cell.textLabel.highlightedTextColor=[UIColor grayColor];
//
//    cell.imageView.image=[UIImage imageNamed:self.imgArr[indexPath.row]];
//    
//    
//    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIViewController *center;
    if (indexPath.row==0) {
        center=self.sideMenuViewController.mainController;
    }else if (indexPath.row==1){
        AdviseViewController *seven=[[AdviseViewController alloc]init];
        center=[[UINavigationController alloc]initWithRootViewController:seven];
    }else if (indexPath.row==2){
        DesignViewController *eight=[[DesignViewController alloc]init];
        center=[[UINavigationController alloc]initWithRootViewController:eight];
    }else if (indexPath.row==3){
        BrandViewController *nine=[[BrandViewController alloc]init];
        center=[[UINavigationController alloc]initWithRootViewController:nine];
    }else if (indexPath.row==4){
        PrivateViewController *ten=[[PrivateViewController alloc]init];
        center=[[UINavigationController alloc]initWithRootViewController:ten];
    }
    
    [self.sideMenuViewController setContentViewController:center animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    self.previousRow=indexPath.row;
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
