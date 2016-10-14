//
//  DesignViewController.m
//  ClothingMaster
//
//  Created by Lym on 16/4/6.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "DesignViewController.h"
#import "DesignInfoVC.h"
#import "SegmentView.h"
#import "Masonry.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface DesignViewController ()<UITableViewDelegate,UITableViewDataSource,SegmentViewDelegate>
{
    NSArray *cellArray;
    UITableView *DesignTableView;
    SegmentView *ControlView;
}
@end

@implementation DesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    NSArray *array=@[@"身材搭配",@"四季搭配",@"搭配常识"];
    
    ControlView = [[SegmentView alloc] init];
    ControlView.frame = CGRectMake(0, 0, ScreenWidth, 40);
    ControlView.titles = array;
    ControlView.showBottomView = YES;
    ControlView.isSameTextWidth = NO;
    ControlView.selectedIndex = 3 < array.count ? 3 : 0;  /**< 注意前后的数值要相同*/
    ControlView.selectedTitleColor = [UIColor colorWithRed:20/255.0 green:200/255.0 blue:240/255.0 alpha:1];
    ControlView.normalTitleColor = [UIColor orangeColor];
    ControlView.bottomLineHeight = 2;
    ControlView.delegate = self;
    ControlView.moveViewColor = [UIColor colorWithRed:20/255.0 green:200/255.0 blue:240/255.0 alpha:1];
    ControlView.bottomViewColor = [UIColor orangeColor];
    ControlView.fontSize = [UIFont systemFontOfSize:ScreenWidth/25];
    [self.view addSubview:ControlView];
    
    cellArray=@[@"X型体型人",@"V型体型人",@"A型体型人",@"H型体型人",@"体型太肥胖人",@"体型太瘦高人",@"体型太矮的人",@"体型太大人",@"胸部过小",@"胸部过大",@"水桶腰",@"肩膀宽厚"];
    DesignTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 41,ScreenWidth , ScreenHeight-156)];
    DesignTableView.backgroundColor=[UIColor whiteColor];
    DesignTableView.delegate=self;
    DesignTableView.dataSource=self;
    [self.view addSubview:DesignTableView];
    
}
- (void)segmentView:(SegmentView *)segmentView DidClickedSegmentButton:(UIButton *)segmentButton{
    
    
    if ([segmentButton.titleLabel.text isEqualToString:@"身材搭配"] ) {
        cellArray=@[@"X型体型人",@"V型体型人",@"A型体型人",@"H型体型人",@"体型太肥胖人",@"体型太瘦高人",@"体型太矮的人",@"体型太大人",@"胸部过小",@"胸部过大",@"水桶腰",@"肩膀宽厚"];
        DesignTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 41,ScreenWidth , ScreenHeight-156)];
        DesignTableView.backgroundColor=[UIColor whiteColor];
        DesignTableView.delegate=self;
        DesignTableView.dataSource=self;
        [self.view addSubview:DesignTableView];
    }
    
     else  if ([segmentButton.titleLabel.text isEqualToString:@"四季搭配"] ) {
         cellArray=@[@"红色系统",@"黄色系统",@"绿色系统",@"花色系统",@"白色系统",@"黑色系统",@"混搭风格"];
         DesignTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 41,ScreenWidth , ScreenHeight-156)];
         DesignTableView.backgroundColor=[UIColor grayColor];
         DesignTableView.delegate=self;
         DesignTableView.dataSource=self;
         [self.view addSubview:DesignTableView];
       }
    
     else  if ([segmentButton.titleLabel.text isEqualToString:@"搭配常识"] ) {
         cellArray=@[@"裤子太长太短",@"皮鞋配白袜子",@"混合图案",@"领带太长太短",@"裤腰太高太低",@"皮带与皮鞋"];
         DesignTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 41,ScreenWidth , ScreenHeight-156)];
         DesignTableView.backgroundColor=[UIColor whiteColor];
         DesignTableView.delegate=self;
         DesignTableView.dataSource=self;
         [self.view addSubview:DesignTableView];
     }
}

/*
 **
 多少个cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return cellArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //优化
    static NSString *identity=@"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    }
    cell.textLabel.text=cellArray[indexPath.row];
    cell.textLabel.font= [UIFont fontWithName: @"Size" size:ScreenWidth/20];
    return cell;
}
/*
 **
 每个cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 100.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    DesignInfoVC *x=[DesignInfoVC new];
    [x setInfo:cellArray[indexPath.row]];
    [self.navigationController pushViewController:x animated:YES];
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
