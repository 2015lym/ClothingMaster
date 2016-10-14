//
//  WebViewController.m
//  ClothingMaster
//
//  Created by Lym on 16/4/19.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "WebViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface WebViewController ()
{
    UIWebView * webView;
}
@end

@implementation WebViewController
@synthesize WebArray,WebDataArray,WebData;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];                //title字体颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];  //返回按钮颜色
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WebData]]];
    [self.view addSubview:webView];
}

-(NSString *)getWebURL:(NSString *)WebName
{
    [self createWebData];

    for (int i=0; i<30; i++) {
        if ([WebName isEqualToString:WebArray[i]]) {
            WebData=[NSString stringWithString:WebDataArray[i]];
        }
    }
    return WebData;
}
-(void)createWebData
{
 WebArray=@[@"CS1.jpg",@"CS2.jpg",@"CS3.jpg",@"CS4.jpg",@"CS5.jpg",@"CS6.jpg",@"CS7.jpg",@"CS8.jpg",@"CS9.jpg",@"CS10.jpg",@"SJMQ1.jpg",@"SJMQ2.jpg",@"SJMQ3.jpg",@"SJMQ4.jpg",@"SJMQ5.jpg",@"SJMQ6.jpg",@"SJMQ7.jpg",@"SJMQ8.jpg",@"SJMQ9.jpg",@"SJMQ10.jpg",@"TX1.jpg",@"TX2.jpg",@"TX3.jpg",@"TX4.jpg",@"TX5.jpg",@"TX6.jpg",@"TX7.jpg",@"TX8.jpg",@"TX9.jpg",@"TX10.jpg"];
    
    
    WebDataArray=@[@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.1.o4Kv2f&scm=1007.10185.16153.100200300000000&pvid=925d7478-fed2-4e26-8819-9f5c10420a03&id=528757432130",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.3.o4Kv2f&scm=1007.10185.16153.100200300000000&pvid=925d7478-fed2-4e26-8819-9f5c10420a03&id=528755533143",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.5.o4Kv2f&scm=1007.10185.16153.100200300000000&pvid=925d7478-fed2-4e26-8819-9f5c10420a03&id=528552328718",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.8.o4Kv2f&scm=1007.10185.16153.100200300000000&pvid=925d7478-fed2-4e26-8819-9f5c10420a03&id=528477755810",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.10.o4Kv2f&scm=1007.10185.16153.100200300000000&pvid=925d7478-fed2-4e26-8819-9f5c10420a03&id=528893592143",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.12.o4Kv2f&scm=1007.10185.16153.100200300000000&pvid=925d7478-fed2-4e26-8819-9f5c10420a03&id=528805417970",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.14.o4Kv2f&scm=1007.10185.16153.100200300000000&pvid=925d7478-fed2-4e26-8819-9f5c10420a03&id=528794965488",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.22.o4Kv2f&scm=1007.10185.16153.100200300000000&pvid=925d7478-fed2-4e26-8819-9f5c10420a03&id=529355697396",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.24.o4Kv2f&scm=1007.10185.16153.100200300000000&pvid=925d7478-fed2-4e26-8819-9f5c10420a03&id=528850275395",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429081.26.o4Kv2f&scm=1007.10185.16153.100200300000000&pvid=925d7478-fed2-4e26-8819-9f5c10420a03&id=529426008879",@"https://item.taobao.com/item.htm?spm=a217f.7278617.2170366-0.1.o4Kv2f&id=530317128180&scm=13003.1.6112009.03c2c681245ca7c533eb5c99edcd9ff6",@"https://item.taobao.com/item.htm?spm=a217f.7278617.2170366-0.3.o4Kv2f&id=528987950770&scm=13003.1.6112009.03c2c681245ca7c533eb5c99edcd9ff6",@"https://item.taobao.com/item.htm?spm=a217f.7278617.2170366-0.15.jM7b8y&id=528810801167&scm=13003.1.6112009.233a705baaa8f0f89894bf6bdd78c2b4",@"https://item.taobao.com/item.htm?spm=a217f.7278617.2170366-0.7.o4Kv2f&id=527583824696&scm=13003.1.6112009.03c2c681245ca7c533eb5c99edcd9ff6",@"https://item.taobao.com/item.htm?spm=a217f.7278617.2170366-0.1.jM7b8y&id=527110127600&scm=13003.1.6112009.233a705baaa8f0f89894bf6bdd78c2b4",@"https://item.taobao.com/item.htm?spm=a217f.7278617.2170366-0.13.o4Kv2f&id=528991734548&scm=13003.1.6112009.03c2c681245ca7c533eb5c99edcd9ff6",@"https://item.taobao.com/item.htm?spm=a217f.7278617.2170366-0.15.o4Kv2f&id=530286277697&scm=13003.1.6112009.03c2c681245ca7c533eb5c99edcd9ff6",@"https://item.taobao.com/item.htm?spm=a217f.7278617.2170366-0.17.o4Kv2f&id=530330100903&scm=13003.1.6112009.03c2c681245ca7c533eb5c99edcd9ff6",@"https://item.taobao.com/item.htm?spm=a217f.7278617.2170366-0.19.o4Kv2f&id=521540098239&scm=13003.1.6112009.03c2c681245ca7c533eb5c99edcd9ff6",@"https://item.taobao.com/item.htm?spm=a217f.7278617.2170366-0.21.o4Kv2f&id=528790290450&scm=13003.1.6112009.03c2c681245ca7c533eb5c99edcd9ff6",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.1.o4Kv2f&scm=1007.10186.18862.100200300000000&pvid=6c1e3c28-2a4a-4158-af4b-fc3c0fe8922b&id=528783459033",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.3.o4Kv2f&scm=1007.10186.18862.100200300000000&pvid=6c1e3c28-2a4a-4158-af4b-fc3c0fe8922b&id=528996379406",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.5.o4Kv2f&scm=1007.10186.18862.100200300000000&pvid=6c1e3c28-2a4a-4158-af4b-fc3c0fe8922b&id=528705650451",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.8.o4Kv2f&scm=1007.10186.18862.100200300000000&pvid=6c1e3c28-2a4a-4158-af4b-fc3c0fe8922b&id=529136759524",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.10.o4Kv2f&scm=1007.10186.18862.100200300000000&pvid=6c1e3c28-2a4a-4158-af4b-fc3c0fe8922b&id=529093156938",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.12.o4Kv2f&scm=1007.10186.18862.100200300000000&pvid=6c1e3c28-2a4a-4158-af4b-fc3c0fe8922b&id=528906770098",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.14.o4Kv2f&scm=1007.10186.18862.100200300000000&pvid=6c1e3c28-2a4a-4158-af4b-fc3c0fe8922b&id=528902469710",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.16.o4Kv2f&scm=1007.10186.18862.100200300000000&pvid=6c1e3c28-2a4a-4158-af4b-fc3c0fe8922b&id=528889579896",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.18.o4Kv2f&scm=1007.10186.18862.100200300000000&pvid=6c1e3c28-2a4a-4158-af4b-fc3c0fe8922b&id=529506014283",@"https://item.taobao.com/item.htm?spm=a217f.7278617.1998429073.20.o4Kv2f&scm=1007.10186.18862.100200300000000&pvid=6c1e3c28-2a4a-4158-af4b-fc3c0fe8922b&id=528813500572"];
    NSLog(@"%ld",WebDataArray.count);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
