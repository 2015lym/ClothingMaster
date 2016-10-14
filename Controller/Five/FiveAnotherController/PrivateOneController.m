//
//  PrivateOneController.m
//  ClothingMaster
//
//  Created by Lym on 16/4/12.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "PrivateOneController.h"
#import "CoreDataBase+Query.h"
#import "Like.h"
#import "MJRefresh.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface PrivateOneController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *cellName;
    NSMutableArray *cellArray;
    UITableView *ILike;
    CoreDataBase *cdb;
}
@end

@implementation PrivateOneController
static const CGFloat RefreshTime = 1.0;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
     [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];  //返回按钮颜色
    self.title=@"收藏";
    
    ILike=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight)];
    ILike.backgroundColor=[UIColor whiteColor];
    ILike.delegate=self;
    ILike.dataSource=self;
    [self.view addSubview:ILike];
    
    cdb= [CoreDataBase shardCoreDataBase];
    cellArray=[cdb queryEntityName:@"Like" Where:nil];
    
    [self refreshScreen];
}
-(void)refreshScreen{
//    ILike.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//   
//    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    ILike.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [ILike.mj_header beginRefreshing];
}
-(void)loadNewData
{
    cdb= [CoreDataBase shardCoreDataBase];
    cellArray=[cdb queryEntityName:@"Like" Where:nil];

    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(RefreshTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新表格
        [ILike reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [ILike.mj_header endRefreshing];
    });
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
    Like *likecell=cellArray[indexPath.row];
    cell.textLabel.text=likecell.name;
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

/*
 **
 对应的cell是否可以被编辑
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
/*
 **
 删除某个cell
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteData:indexPath];
        [cellArray removeObjectAtIndex:indexPath.row];
        [ILike deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
-(void)deleteData:(NSIndexPath *)indexPath
{
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Like" inManagedObjectContext:cdb.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError * requestError = nil;
    NSArray * persons = [cdb.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if ([persons count] > 0) {
        
        // 删除数据
        [cdb.managedObjectContext deleteObject:cellArray[indexPath.row]];
        if ([cellArray[indexPath.row] isDeleted]) {
            NSLog(@"删除成功");
            NSError * savingError = nil;
            
            if ([cdb.managedObjectContext save:&savingError]) {
                NSLog(@"储存成功");
                
            }else {
                NSLog(@"储存失败 error = %@", savingError);
            }
        }else {
            
            NSLog(@"删除失败");
        }
    }else {
        NSLog(@"没有找到实体");
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
