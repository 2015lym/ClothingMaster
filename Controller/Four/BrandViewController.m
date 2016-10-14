//
//  BrandViewController.m
//  ClothingMaster
//
//  Created by Lym on 16/4/6.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "BrandViewController.h"
#import "Masonry.h"
#import "LGCategoryView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface BrandViewController ()<LGCategoryViewDelegate>
{
    LGCategoryView *Leftcategory;
}
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *categoryTitles;
@property (nonatomic, strong) LGCategoryView *category;
@end
#define KCollectionCellHeight 39
static NSString *const cellIdentifier = @"cells";

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    /*   左上角按钮   */
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Control"] style:UIBarButtonItemStyleDone target:self action:@selector(addCategroyView)];
    self.navigationItem.leftBarButtonItem.tag=1;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    


}


#pragma mark 纵向分类显示
- (void)addCategroyView
{
    
    if(self.navigationItem.leftBarButtonItem.tag==1)
    {
        NSLog(@"aa");
    Leftcategory = [[LGCategoryView alloc] initWithFrame:CGRectMake(0, 0, 90, ScreenHeight-120)];
    
    Leftcategory.titles = @[@"HSTYLE", @"GUCCI", @"洛诗琳", @"妙玉裳", @"鲁遇", @"VEROMODA", @"INMAN",@"七格格", @"COCOBELLA", @"MOOERKERR", @"La Chapelle", @"Louis Vuitton", @"Christian Dior", @"Burberry"];
    [self.view addSubview:Leftcategory];
    Leftcategory.delegate = self;
    self.categoryTitles = Leftcategory.titles;
    self.category = Leftcategory;
        self.navigationItem.leftBarButtonItem.tag=2;
    }
    else if(self.navigationItem.leftBarButtonItem.tag==2)
    {
        Leftcategory.hidden=YES;
        self.navigationItem.leftBarButtonItem.tag=1;
    }
}


-(void)LGCategoryView:(LGCategoryView *)categoryView didSelectedItem:(int)index
{
    UIWebView * view = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-120)];
    switch (index) {
        case 0:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.handu.com"]]];
            [self.view addSubview:view];
            break;
        }
        case 1:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.gucci.com/cn/home?utm_source=baidu_cn&utm_medium=brandzone&utm_campaign=cn_Safilo-Damascato-Sunglasses_2016-Apr-11&utm_content=title-officialwebsite"]]];
            [self.view addSubview:view];
            break;
        }
        case 2:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://temai.jinyinhudong.com/817719264/"]]];
            [self.view addSubview:view];
            break;
        }
        case 3:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yufox.net/cfad/2073951573.html"]]];
            [self.view addSubview:view];
            break;
        }
        case 4:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lady.ef43.com.cn/zhuanti/11763/"]]];
            [self.view addSubview:view];
            break;
        }
        case 5:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.veromoda.com.cn"]]];
            [self.view addSubview:view];
            break;
        }
        case 6:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.inman.com.cn"]]];
            [self.view addSubview:view];
            break;
        }
        case 7:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mall.jd.com/index-56054.html"]]];
            [self.view addSubview:view];
            break;
        }
        case 8:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mall.jd.com/index-42330.html"]]];
            [self.view addSubview:view];
            break;
        }
        case 9:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s.etao.com/cp/bW9vZXJrZXJyzeLM1w.html?tbpm=20160418"]]];
            [self.view addSubview:view];
            break;
        }
        case 10:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.lachapelle.cn"]]];
            [self.view addSubview:view];
            break;
        }
        case 11:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.louisvuitton.cn/zhs-cn/homepage?campaign=sem_BaiduBrandzone_H1"]]];
            [self.view addSubview:view];
            break;
        }
        case 12:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.dior.cn/home/zh_cn"]]];
            [self.view addSubview:view];
            break;
        }
        case 13:
        {
            Leftcategory.hidden=YES;
            self.navigationItem.leftBarButtonItem.tag=1;
            [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://cn.burberry.com/?utm_source=baidu&utm_medium=cpc&utm_campaign=CN%7CSC%7CBrand%7CPremiun%7CExact&utm_term=burberry&gclid=CPnGheallswCFcGUvAodm5gBow&gclsrc=ds"]]];
            [self.view addSubview:view];
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
