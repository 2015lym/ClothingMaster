//
//  NewDayViewController.m
//  ClothingMaster
//
//  Created by Lym on 16/4/6.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "NewDayViewController.h"
#import "AFNetworking.h"
#import "WebViewController.h"
#import "Masonry.h"
#import "RESideMenu.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface NewDayViewController ()<UIScrollViewAccessibilityDelegate,UITableViewDelegate,UITableViewDataSource>
{
     UIPageControl *AdvPageControl;
     UIScrollView *MainScrollView;
    
    NSMutableArray * AdvImgArr;
    
    UIScrollView *AdvScrollView;
    
    UITableView *ClothTableView;
    
    NSArray *ClothArray1;
    NSArray *ClothPriceArray1;
    NSArray *ClothTitleArray1;
    NSArray *ClothArray2;
    NSArray *ClothPriceArray2;
    NSArray *ClothTitleArray2;
    NSArray *ClothArray3;
    NSArray *ClothPriceArray3;
    NSArray *ClothTitleArray3;
    NSArray *Cloth;
}
@end

@implementation NewDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Control"] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
        [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    /**
     整个屏幕的ScrollView,高度是上方Scroll+今日天气+天气View+流行服装+底部FlowLayout的尺寸+50
     */
    MainScrollView=[[UIScrollView alloc]init];
    MainScrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:MainScrollView];
    MainScrollView.contentSize=CGSizeMake(0, ScreenWidth*3);
    [MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenHeight));
    }];
    
    /*
     网址
     https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.1.7MdbDo&scm=1007.10186.18862.100200300000000&pvid=14654fab-a035-4c18-a242-6464f52424a7&id=528337975424
     
     https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.3.7MdbDo&scm=1007.10185.16153.100200300000000&pvid=6b83af1e-a494-4dc9-a2b2-1fdb5f5fb78a&id=528552328718
     
     https://item.taobao.com/item.htm?spm=a1z10.1-c.w11219927-13674661218.9.oY7Bw3&id=528223352812
     
     https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.22.7MdbDo&scm=1007.10185.16153.100200300000000&pvid=6b83af1e-a494-4dc9-a2b2-1fdb5f5fb78a&id=528951642536
     
     */
    
    /**
     上方的ScrollView
     */
    AdvScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/1.5)];
    [MainScrollView addSubview:AdvScrollView];
    AdvScrollView.contentSize=CGSizeMake(ScreenWidth*4, 0);
    
    AdvImgArr=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<4; i++) {
        [AdvImgArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"adv%d",i]]];
        UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenWidth/1.5)];
        view.image=AdvImgArr[i];
        [AdvScrollView addSubview:view];
    }

    AdvScrollView.showsVerticalScrollIndicator = FALSE;         /*隐藏垂直滚动条*/
    AdvScrollView.showsHorizontalScrollIndicator = FALSE;       /*隐藏水平滚动条*/
    AdvScrollView.pagingEnabled=YES;                            /*是否按页面滑动*/
    AdvScrollView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets=YES;
    /**
     ScrollView的点
     */
    AdvPageControl= [[UIPageControl alloc]init];
    AdvPageControl.currentPage = 0;    //初始页数
    AdvPageControl.numberOfPages = 4;  //总页数
    AdvPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];  //UIPageControl当前颜色
    AdvPageControl.pageIndicatorTintColor = [UIColor greenColor];         //UIPageControl未选中颜色
    AdvPageControl.tag=151;
    [MainScrollView addSubview:AdvPageControl];
    [AdvPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(AdvScrollView);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    
    
    UILabel *FishionClothing=[[UILabel alloc]init];
    FishionClothing.text=@"-优选美搭-";
    /*   **---文字居中---**   */
    FishionClothing.textAlignment = NSTextAlignmentCenter;
    [FishionClothing setFont:[UIFont systemFontOfSize:ScreenWidth/22]];
    [FishionClothing setTextColor:[UIColor grayColor]];
    [MainScrollView addSubview:FishionClothing];
    [FishionClothing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(AdvScrollView).offset(ScreenWidth/10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/3, ScreenWidth/12));
        make.centerX.mas_equalTo(AdvScrollView);
    }];
    //换一批按钮
    UIButton *RefreshClothing=[[UIButton alloc]init];
    [RefreshClothing setTitle:@"换一批" forState:UIControlStateNormal];
    RefreshClothing.backgroundColor=[UIColor cyanColor];
    [RefreshClothing.layer setCornerRadius:12.0]; //边框变圆滑
    [RefreshClothing addTarget:self action:@selector(refreshClothTableView) forControlEvents:UIControlEventAllEvents];
    [MainScrollView addSubview:RefreshClothing];
    [RefreshClothing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(AdvScrollView).offset(ScreenWidth/10+1);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/5, ScreenWidth/12));
        make.left.mas_equalTo(FishionClothing).offset(-ScreenWidth/4-20);
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(fanyeAction) userInfo:nil repeats:NO];
    
    ClothTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, ScreenWidth/1.5+ScreenWidth/12+ScreenWidth/10,ScreenWidth , ScreenWidth*3-ScreenWidth/1.5-ScreenWidth/12-ScreenWidth/10-120)];
    ClothTableView.backgroundColor=[UIColor whiteColor];
    ClothTableView.delegate=self;
    ClothTableView.dataSource=self;
    [MainScrollView addSubview:ClothTableView];
    
    Cloth=@[@"衬衫",@"连衣裙",@"T恤"];
    ClothArray1=@[@"CS1.jpg",@"CS2.jpg",@"CS3.jpg",@"CS4.jpg",@"CS5.jpg"];
    ClothPriceArray1=@[@"79.9￥",@"49.9￥",@"59￥",@"69￥",@"108￥"];
    ClothTitleArray1=@[@"立领雪纺衬衫七分袖韩范",@"上衣宽松休闲白衬衫V领",@"天天特价 春夏新款衬衣女",@"袖口隐藏不住的少女心",@"吊带一字领露肩袖衬衫"];
    
    ClothArray2=@[@"SJMQ1.jpg",@"SJMQ2.jpg",@"SJMQ3.jpg",@"SJMQ4.jpg",@"SJMQ5.jpg"];
    ClothPriceArray2=@[@"188￥",@"168￥",@"199￥",@"299￥",@"413￥"];
    ClothTitleArray2=@[@"古力娜扎同款露背连衣裙",@"无名喜欢 简约即是美",@"百分之一优雅黑色深V",@"优雅黑白纹蚕丝连衣裙",@"鱼尾裙摆透视蕾丝连衣裙"];
    
    ClothArray3=@[@"TX1.jpg",@"TX2.jpg",@"TX3.jpg",@"TX4.jpg",@"TX5.jpg"];
    ClothPriceArray3=@[@"55￥",@"69￥",@"49.7￥",@"69.99￥",@"59￥"];
    ClothTitleArray3=@[@"夏装新款韩国宽松短袖T恤",@"夏装新款显瘦条纹T恤",@"情侣装原宿潮情侣短袖t恤",@"爱爱丸 限量自制 小潮女",@"毛菇小象 新款修身显瘦T恤"];
}
-(void)refreshClothTableView
{
    int a=random()%2;
    if (a==0)
        
    {
        ClothArray1=@[@"CS1.jpg",@"CS2.jpg",@"CS3.jpg",@"CS4.jpg",@"CS5.jpg"];
        ClothPriceArray1=@[@"79.9￥",@"49.9￥",@"59￥",@"69￥",@"108￥"];
        ClothTitleArray1=@[@"立领雪纺衬衫七分袖韩范",@"上衣宽松休闲白衬衫V领",@"天天特价 春夏新款衬衣女",@"袖口隐藏不住的少女心",@"吊带一字领露肩袖衬衫"];
        
        ClothArray2=@[@"SJMQ1.jpg",@"SJMQ2.jpg",@"SJMQ3.jpg",@"SJMQ4.jpg",@"SJMQ5.jpg"];
        ClothPriceArray2=@[@"188￥",@"168￥",@"199￥",@"299￥",@"413￥"];
        ClothTitleArray2=@[@"古力娜扎同款露背连衣裙",@"无名喜欢 简约即是美",@"百分之一优雅黑色深V",@"优雅黑白纹蚕丝连衣裙",@"鱼尾裙摆透视蕾丝连衣裙"];
        
        ClothArray3=@[@"TX1.jpg",@"TX2.jpg",@"TX3.jpg",@"TX4.jpg",@"TX5.jpg"];
        ClothPriceArray3=@[@"55￥",@"69￥",@"49.7￥",@"69.99￥",@"59￥"];
        ClothTitleArray3=@[@"夏装新款韩国宽松短袖T恤",@"夏装新款显瘦条纹T恤",@"情侣装原宿潮情侣短袖t恤",@"爱爱丸 限量自制 小潮女",@"毛菇小象 新款修身显瘦T恤"];
    }
        else if (a==1)
    {
        ClothArray1=@[@"CS6.jpg",@"CS7.jpg",@"CS8.jpg",@"CS9.jpg",@"CS10.jpg"];
        ClothPriceArray1=@[@"65￥",@"79.9￥",@"99.33￥",@"129￥",@"62￥"];
        ClothTitleArray1=@[@"韩系甜美清新条纹衬衣",@"韩范百搭圆领露背上衣",@"气质慵懒睡衣领衬衣",@"经典气质长青款衬衫",@"圆领荷叶飞袖显瘦格子衬衫"];
        
        ClothArray2=@[@"SJMQ6.jpg",@"SJMQ7.jpg",@"SJMQ8.jpg",@"SJMQ9.jpg",@"SJMQ10.jpg"];
        ClothPriceArray2=@[@"288￥",@"348￥",@"368￥",@"468￥",@"279￥"];
        ClothTitleArray2=@[@"性感又有活力 减龄神器",@"舒适条纹腰带无袖连衣裙",@"法M女神蕾丝钩花连衣裙",@"汤米诺格纹连衣裙",@"巴黎最红潮牌牛仔控"];
        
        ClothArray3=@[@"TX6.jpg",@"TX7.jpg",@"TX8.jpg",@"TX9.jpg",@"TX10.jpg"];
        ClothPriceArray3=@[@"38.72￥",@"119￥",@"56￥",@"55￥",@"49.9￥"];
        ClothTitleArray3=@[@"自制 韩国百搭纯色短袖",@"欧货春装韩版宽松t恤",@"小镇姗姗经典百搭舒适",@"6度欧美纯色百搭",@"韩版纯色百搭潮流糖果色"];
    }

    
    [ClothTableView reloadData];
}

//标签名
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return Cloth[section];
}
//标签数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
//右边索引 字节数(如果不实现 就不显示右侧索引)
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return Cloth;
}

/*多少个cell*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //优化
    static NSString *identity=@"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    }
    if ([Cloth[indexPath.section] isEqualToString:@"衬衫"]) {
        cell.textLabel.text=ClothTitleArray1[indexPath.row];
        cell.detailTextLabel.text=ClothPriceArray1[indexPath.row];

        cell.imageView.image=[UIImage imageNamed:ClothArray1[indexPath.row]];
    }
    else if([Cloth[indexPath.section] isEqualToString:@"连衣裙"]) {
        cell.textLabel.text=ClothTitleArray2[indexPath.row];
        cell.detailTextLabel.text=ClothPriceArray2[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:ClothArray2[indexPath.row]];
    }
    else if([Cloth[indexPath.section] isEqualToString:@"T恤"]) {
        cell.textLabel.text=ClothTitleArray3[indexPath.row];
        cell.detailTextLabel.text=ClothPriceArray3[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:ClothArray3[indexPath.row]];
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:ScreenWidth/30]];       //调整字体大小
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:ScreenWidth/30]];
    cell.textLabel.numberOfLines=0;
    return cell;
}
/*每个cell的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return ScreenWidth/5.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    WebViewController *webVC=[WebViewController new];
    
    if ([Cloth[indexPath.section] isEqualToString:@"衬衫"]) {
     [webVC getWebURL:ClothArray1[indexPath.row]];
    }
    else if([Cloth[indexPath.section] isEqualToString:@"连衣裙"]) {
     [webVC getWebURL:ClothArray2[indexPath.row]];
    }
    else if([Cloth[indexPath.section] isEqualToString:@"T恤"]) {
     [webVC getWebURL:ClothArray3[indexPath.row]];
    }
    [self.navigationController pushViewController:webVC animated:YES];
}



//手动操作广告时pageview跟着翻页
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([scrollView isMemberOfClass:[UIScrollView class]]){
        int num = (int)scrollView.contentOffset.x/self.view.bounds.size.width;
        UIPageControl * pageCtr = (UIPageControl *)[self.view viewWithTag:151];
        pageCtr.currentPage = num;
    }
}
//pagecontroll翻页
- (void)fanyeAction{
    long num = AdvImgArr.count;
    static int currPageNumber = 0;
    AdvPageControl = [self.view viewWithTag:151];
    if(currPageNumber<num){
        currPageNumber ++;
        if(currPageNumber == num){
            [UIView animateWithDuration:1 animations:^{
                AdvPageControl.currentPage = 0;
                AdvScrollView.contentOffset= CGPointMake(currPageNumber*ScreenWidth, 0);
            }];
            [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(fanyeAction) userInfo:nil repeats:NO];
        }else{
            [UIView animateWithDuration:1 animations:^{
                AdvPageControl.currentPage = currPageNumber;
                AdvScrollView.contentOffset = CGPointMake(currPageNumber*ScreenWidth, 0);
            }];
            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(fanyeAction) userInfo:nil repeats:NO];
        }
    }else{
        currPageNumber = 0;
        AdvScrollView.contentOffset = CGPointMake(0, 0);
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(fanyeAction) userInfo:nil repeats:NO];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; //Scorll的小点移动
{
    AdvPageControl.currentPage= (int) scrollView.contentOffset.x/ScreenWidth;
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
