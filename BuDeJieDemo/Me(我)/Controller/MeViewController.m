//
//  MeViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/18.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "MeViewController.h"

static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define   itemWH  (screenWidth - (cols - 1) * margin) / cols

@interface MeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, strong) UICollectionView * collectionView;

@end
/*
 搭建基本结构 -> 设置底部条 -> 设置顶部条 -> 设置顶部条标题字体 -> 处理导航控制器业务逻辑(跳转)
 */
@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgationUI];
    
    [self setFooterView];
    // 展示方块内容 -> 请求数据(查看接口文档)
    [self loadData];
    
    /*
     跳转细节:
     1.collectionView高度重新计算=>  collectionView高度需要根据内容去计算 => 有数据了 需要在计算下高度
     2.collectionView不需要滚动
     */
    // 处理cell间距,默认tableView分组样式,有额外头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);//cell是从35开始的，想让他间距只有10 所以要向上诺25，因此为-25
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LoginViewController *loginVc = [[LoginViewController alloc] init];
            [self presentViewController:loginVc animated:YES completion:nil];
        }
    }

}

// 打印cell y值 发现cell是从35开始的
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//    NSLog(@"%@",NSStringFromCGRect(cell.frame));
//
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//
//    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));发现与他没关系
//}

#pragma mark - 请求数据
-(void)loadData
{
    __weak typeof (self)weakSelf = self;
    //创建会话请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //拼接请求链接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    //发送请求
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/jimmy/Desktop/JImmy/综合练习/BuDeJieDemo/square.plist" atomically:YES];
        NSArray *array = responseObject[@"square_list"];
        
//         NSLog(@"*******%@",responseObject);
        // 字典数组转换成模型数组
        _squareItems = [SquareItem mj_objectArrayWithKeyValuesArray:array];

        // 处理数据
        [self resloveData];
        
        // 设置collectionView 计算collectionView高度 = rows * itemWH
        // Rows = (count - 1) / cols + 1  3 cols 4
        NSInteger count = self.squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        // 设置collectioView高度
        self.collectionView.lx_height = rows * itemWH + 10;
        
        // 设置tableView滚动范围:自己计算
        self.tableView.tableFooterView = self.collectionView;
        
        // 刷新表格
        [weakSelf.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"*******%@",error);
    }];
    
}
#pragma mark - resloveData
-(void)resloveData
{
    //因为如果不够一行的话 剩下的空余部分看起来不太好看 所以要补救
    //每一行缺多少个可以这样计算cols - ( count / cols )
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % cols ;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i ++) {
            SquareItem *item = [[SquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
}

#pragma mark - 设置tableView底部视图
-(void)setFooterView
{
    /*
     1.初始化要设置流水布局
     2.cell必须要注册
     3.cell必须自定义
     */
    // 创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置cell尺寸
    
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    self.collectionView.backgroundColor = self.tableView.backgroundColor;
    
    self.tableView.tableFooterView = self.collectionView;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"SquareCell" bundle:nil] forCellWithReuseIdentifier:@"SquareCell"];
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转界面 push 展示网页
    /*
     1.Safari openURL :自带很多功能(进度条,刷新,前进,倒退等等功能),必须要跳出当前应用
     2.UIWebView (没有功能) ,在当前应用打开网页,并且有safari,自己实现,UIWebView不能实现进度条
     3.SFSafariViewController:专门用来展示网页 需求:即想要在当前应用展示网页,又想要safari功能 iOS9才能使用
     3.1 导入#import <SafariServices/SafariServices.h>
     
     4.WKWebView:iOS8 (UIWebView升级版本,添加功能 1.监听进度 2.缓存)
     4.1 导入#import <WebKit/WebKit.h>
     
     */
    // 创建网页控制器 要想将数据展示出来 就需要模型对应 但是有的不需要打开一个网页 所以要判断

    SquareItem *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) {
        return;
    }
    
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.url = [NSURL URLWithString:item.url];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SquareCell" forIndexPath:indexPath];
    cell.item = self.squareItems[indexPath.row];
    
    return cell;
}

#pragma mark - 设置导航栏
-(void) setNavgationUI
{
    //右边按钮
    //夜间模式
    //按钮的选中状态需要手动改变，所以要写方法并且带参数
    UIBarButtonItem *mood = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    //设置界面
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingClick:)];
    
    self.navigationItem.rightBarButtonItems = @[setting,mood];
    
    // title
    self.navigationItem.title = @"我的";
    
}
#pragma mark - 实现夜间按钮的点击事件
-(void)night:(UIButton *)button
{
    button.selected = !button.selected;
//    [button setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateSelected];
    
}
#pragma mark - 实现设置按钮的点击事件
-(void)settingClick:(UIButton *)button
{
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    //隐藏底部条,方法使用条件：必须放在跳转前使用
    settingVC. hidesBottomBarWhenPushed = YES;
    //处理返回按钮样式 遵循谁的事情谁管理 所以这个要在setting控制器里设置

    [self.navigationController pushViewController:settingVC animated:YES];
//    [self presentViewController:settingVC animated:YES completion:nil];
    
}

#pragma mark - Table view data source



@end
