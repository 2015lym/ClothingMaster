//
//  PrivateViewController.m
//  ClothingMaster
//
//  Created by Lym on 16/4/6.
//  Copyright © 2016年 Lym. All rights reserved.
//

#import "PrivateViewController.h"
#import "Masonry.h"
#import "FiveTableViewCell.h"
#import "MyToolsCell.h"
#import "PrivateOneController.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define CHANGE self.view.frame.size.width/375

@interface PrivateViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UITableView * table;
@property (nonatomic,strong) UIButton * imgBtn;
@property (nonatomic,strong) UIView * headerImgView;
@property (nonatomic,assign) BOOL isChangeImg;
@property (nonatomic,strong) NSString * imgStr;
@property (nonatomic,strong) UICollectionView * coll;
@property (nonatomic,strong) NSMutableArray * imgArr;
@property (nonatomic,strong) UIAlertController *CleanData;
@end

@implementation PrivateViewController
- (void)loadData{
    //image
    self.imgArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 1; i<17; i++) {
        [self.imgArr addObject:[NSString stringWithFormat:@"Head%d",i]];
    }
    //
    NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    self.imgStr = [userDef objectForKey:@"imageName"];
    if (!self.imgStr) {
        [userDef setObject:@"icon_userAvatar_default" forKey:@"imageName"];
        self.imgStr = @"5";
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
    //    _isChangeImg = NO;
    self.headerImgView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    /*   ---整个视图的TableView---   */
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.table.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-20*CHANGE);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenHeight+30*CHANGE));
    }];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.showsHorizontalScrollIndicator = NO;
    self.table.showsVerticalScrollIndicator = NO;
    self.table.rowHeight = 50*CHANGE;
    self.table.sectionHeaderHeight = 9*CHANGE;
    self.table.sectionFooterHeight = 1*CHANGE;
    
    
    /*   ---头像框背景View---   */
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 240*CHANGE)];
    self.table.tableHeaderView = headView;
    UIImageView * headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 240*CHANGE)];
    headerImgView.image = [UIImage imageNamed:@"ImgBG"];
    headerImgView.layer.borderWidth = 3;
    headerImgView.layer.borderColor = [UIColor cyanColor].CGColor;
    [headView addSubview:headerImgView];
    
    
    /*   ---头像框的尺寸和位置---   */
    self.imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [headView addSubview:self.imgBtn];
    [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100*CHANGE);
        make.left.equalTo(headView).offset(ScreenWidth/2-40*CHANGE);
        make.size.mas_equalTo(CGSizeMake(80*CHANGE, 80*CHANGE));
    }];
    self.imgBtn.backgroundColor = [UIColor yellowColor];
    [self.imgBtn addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
    self.imgBtn.layer.cornerRadius = 40*CHANGE;
    self.imgBtn.layer.masksToBounds = YES;
    self.imgBtn.layer.borderWidth = 3;
    self.imgBtn.layer.borderColor = [UIColor cyanColor].CGColor;
    [self.imgBtn setImage:[UIImage imageNamed:self.imgStr] forState:UIControlStateNormal];
    
    
    
    
    /*   ---头像后背景区域---   */
    self.isChangeImg = NO;
    self.headerImgView = [[UIView alloc]init];
    [self.view addSubview:self.headerImgView];
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-20);
        make.left.equalTo(self.view).offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenHeight));
    }];
    self.headerImgView.hidden = YES;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
    /*   ---选择头像区域内，方形头像的大小---   */
    layout.itemSize = CGSizeMake((ScreenWidth-100*CHANGE-50*CHANGE)/4, (ScreenWidth-100*CHANGE-50*CHANGE)/4);
    /*   ---选择头像区域内，间隔大小，分别上左下右---   */
    layout.sectionInset = UIEdgeInsetsMake(10*CHANGE, 10*CHANGE, 10*CHANGE, 10*CHANGE);
    
    self.coll = [[UICollectionView alloc]initWithFrame:CGRectMake(50, 220, ScreenWidth-100*CHANGE, ScreenWidth-100*CHANGE) collectionViewLayout:layout];
    self.coll.backgroundColor = [UIColor colorWithRed:20/255.0 green:200/255.0 blue:240/255.0 alpha:0.3];
    [self.coll registerClass:[MyToolsCell class] forCellWithReuseIdentifier:@"cell"];
    [self.headerImgView addSubview:self.coll];
    self.coll.dataSource = self;
    self.coll.delegate = self;
    self.coll.hidden = YES;
    
    
    /*   ---初始化清理缓存成功的对话框---   */
    self.CleanData=[UIAlertController alertControllerWithTitle:@"缓存清理完成" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *CleanFinish=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [self.CleanData addAction:CleanFinish];
    
}

- (void)changeImage{
    if (!_isChangeImg) {
        self.headerImgView.hidden = NO;
        self.coll.hidden = NO;
        self.headerImgView.alpha = 0;
        self.coll.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            self.headerImgView.alpha = 1;
            self.coll.alpha = 1;
        }];
        _isChangeImg = YES;
    }else if (_isChangeImg){
        [UIView animateWithDuration:1 animations:^{
            self.headerImgView.alpha = 0;
        } completion:^(BOOL finished) {
            
            self.headerImgView.hidden = YES;
        }];
        _isChangeImg = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.headerImgView) {
        if (_isChangeImg){
            [UIView animateWithDuration:0.1 animations:^{
                self.headerImgView.alpha = 0;
            } completion:^(BOOL finished) {
                
                self.headerImgView.hidden = YES;
            }];
            _isChangeImg = NO;
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isChangeImg){
        [UIView animateWithDuration:1 animations:^{
            self.headerImgView.alpha = 0;
        } completion:^(BOOL finished) {
            
            self.headerImgView.hidden = YES;
        }];
        _isChangeImg = NO;
    }
    
    [self.imgBtn setImage:[UIImage imageNamed:self.imgArr[indexPath.row]] forState:UIControlStateNormal];
    
    NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    
    [userDef setObject:self.imgArr[indexPath.row] forKey:@"imageName"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * indentififer = @"cell";
    MyToolsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentififer forIndexPath:indexPath];
    cell.imgBtn.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.imgBtn.layer.borderWidth = 2;
    cell.imgBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        PrivateOneController * sq = [[PrivateOneController alloc]init];
        [self.navigationController pushViewController:sq animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self presentViewController:self.CleanData animated:YES completion:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //告知视图，有多少个section需要加载到table里
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {  //每组各多少个Cell
        case 0:return 2;
        case 1:return 3;
        case 2:return 1;
            //        case 3:return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * indentifier = @"a";
    FiveTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        
        cell = [[FiveTableViewCell alloc] initWithMyOfReuseIdentifier:indentifier andSection:indexPath.section];
    }
    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.text = @"detail";
    //去掉分割线
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section != 3) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    }
    //去掉点上去的阴影
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (int i = 0; i<3; i++) {
        int row = 0;
        switch (i) {     //每组各多少个Cell，和上面的对应
            case 0:{row = 1;self.table.sectionHeaderHeight=0;}break;
            case 1:row = 2;break;
            case 2:row = 0;break;
                //            case 3:row = 0;break;
            default:
                break;
        }
        //给每个Cell都设置上白色背景
        if (indexPath.section == i && indexPath.row == row) {
            cell.imgViewBored.backgroundColor = [UIColor whiteColor];
        }
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"我的收藏";
        cell.imageView.image=[UIImage imageNamed:@"6"];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"清理缓存";
        cell.imageView.image=[UIImage imageNamed:@"7"];
    }
    return cell;
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
