//
//  AdvTestVC.m
//  ClothingMaster
//
//  Created by Lym on 16/4/14.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "AdvTestVC.h"
#import "Masonry.h"
#import "TestInfoVC.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface AdvTestVC ()<UITableViewDelegate,UITableViewDataSource>
{
   NSArray *TestArray;
   UITableView *TestTableView;
    
   NSArray *PickerArray1;
   NSArray *PickerArray2;
    
    UIView *TallView;
    
    UIButton *Tall;
}
@end

@implementation AdvTestVC

NSString *TitleName;

extern void getData(NSString* name)
{
    TitleName=name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     self.title=TitleName;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];                //title字体颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];  //返回按钮颜色

    
    /*   根据选择跳转到不同测试   */
    if ([TitleName isEqualToString:@"体型推荐"]) {
        [self creatBodyTest];
    }
    else if ([TitleName isEqualToString:@"场合推荐"])  {
        [self createOccasionTest];
    }
    else if ([TitleName isEqualToString:@"情节推荐"])  {
        [self createActionTest];
    }
    else if ([TitleName isEqualToString:@"性格推荐"])  {
        [self createPersonalityTest];
    }

}
-(void)creatBodyTest
{
    PickerArray1=[[NSArray alloc]initWithObjects:@"150",@"155",@"160",@"165",@"170",@"175",@"180",nil];
    PickerArray2=[[NSArray alloc]initWithObjects:@"80",@"90",@"100",@"110",@"120",@"130",@"140",@"150",@"160",nil];
    
    UIButton *TallBtn=[[UIButton alloc]initWithFrame:CGRectMake(90, 100, ScreenWidth/5, ScreenWidth/12)];
    TallBtn.tag=1;
    [TallBtn setTitle:@"身高" forState:UIControlStateNormal];
    TallBtn.backgroundColor=[UIColor cyanColor];
    [TallBtn.layer setCornerRadius:12.0]; //边框变圆滑
    [TallBtn addTarget:self action:@selector(buttonChoose:)forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:TallBtn];
    
    UIButton *WeightBtn=[[UIButton alloc]initWithFrame:CGRectMake(250, 100, ScreenWidth/5, ScreenWidth/12)];
    WeightBtn.tag=2;
    [WeightBtn setTitle:@"体重" forState:UIControlStateNormal];
    WeightBtn.backgroundColor=[UIColor cyanColor];
    [WeightBtn.layer setCornerRadius:12.0]; //边框变圆滑
    [WeightBtn addTarget:self action:@selector(buttonChoose:)forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:WeightBtn];
}
-(void)createOccasionTest
{
    TestTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight)];
    TestTableView.backgroundColor=[UIColor whiteColor];
    TestTableView.delegate=self;
    TestTableView.dataSource=self;
    [self.view addSubview:TestTableView];
        TestArray=@[@"庄严场合",@"相亲场合",@"晚宴场合"];
}

-(void)createActionTest
{
    TestTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight)];
    TestTableView.backgroundColor=[UIColor whiteColor];
    TestTableView.delegate=self;
    TestTableView.dataSource=self;
    [self.view addSubview:TestTableView];
        TestArray=@[@"旅游",@"约会",@"运动",@"上学"];
}

-(void)createPersonalityTest
{
    TestTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight-100)];
    TestTableView.backgroundColor=[UIColor whiteColor];
    TestTableView.delegate=self;
    TestTableView.dataSource=self;
    [self.view addSubview:TestTableView];
        TestArray=@[@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座"];
}


-(void)buttonChoose:(id)Btn
{
    UIButton *ButtonControl=Btn;
    switch (ButtonControl.tag) {
        case 1:
        {
            NSString *TallData;
            TallView=[[UIView alloc]initWithFrame:CGRectMake(90, 100, ScreenWidth/5, ScreenHeight)];
            TallView.backgroundColor=[UIColor clearColor];
            [self.view addSubview:TallView];
            for (int i=0; i<7; i++) {
                Tall=[[UIButton alloc]initWithFrame:CGRectMake(0, ScreenWidth/12+i*ScreenWidth/12,ScreenWidth/5, ScreenWidth/12)];
                TallData=[NSString stringWithString:PickerArray1[i]];
                [Tall setTitle:TallData forState:UIControlStateNormal];
                Tall.backgroundColor=[UIColor cyanColor];
                [Tall.layer setCornerRadius:12.0]; //边框变圆滑
                [TallView addSubview:Tall];
            }
            break;
        }
        case 2:
        {
            NSLog(@"aa");
            TallView.hidden=YES;
            Tall.hidden=YES;
            break;
        }
        default:
            break;
    }
}




/*
 **
 多少个cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return TestArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //优化
    static NSString *identity=@"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    }
    cell.textLabel.text=TestArray[indexPath.row];
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
    TestInfoVC *x=[TestInfoVC new];
    [x setInfo:TestArray[indexPath.row]];
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
