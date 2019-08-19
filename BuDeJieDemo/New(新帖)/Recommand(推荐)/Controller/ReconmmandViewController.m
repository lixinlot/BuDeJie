//
//  ReconmmandViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/23.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "ReconmmandViewController.h"

@interface ReconmmandViewController ()

@property (nonatomic, strong) NSMutableArray *subTags;

@property (nonatomic, weak) AFHTTPSessionManager * manager;

@end

@implementation ReconmmandViewController

// 接口文档: 请求url(基本url+请求参数) 请求方式
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 展示标签数据 -> 请求数据(接口文档) -> 解析数据(写成Plist)(image_list,sub_number,theme_name) -> 设计模型 -> 字典转模型 -> 展示数据
    [self loadData];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ReconmmandTableViewCell" bundle:nil] forCellReuseIdentifier:@"RecCell"];
    
    self.title = @"推荐标签";
    
    // 处理cell分割线 1.自定义分割线 2.系统属性(iOS8才支持) 3.万能方式(重写cell的setFrame) 了解tableView底层实现（先调用heightForRow后cellForRow） 1.取消系统自带分割线 2.把tableView背景色设置为分割线的背景色 3.重写setFrame(在自定义cell里写)
    //清空tableView分割线内边距 还要清空cell的约束边缘（layoutMargins）
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = LXColor(220, 220, 221);
    
    [SVProgressHUD showWithStatus:@"正在加载中..."];
}

//当网络一直加载不出来时退出其他界面 也会显示指示器 所以要在视图将要消失的时候取消掉
-(void)viewWillDisappear:(BOOL)animated
{
    //取消指示器
    [SVProgressHUD dismiss];
    //跳转下个界面时取消当前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}

#pragma mark - 请求数据
- (void)loadData
{
    // 3.发送请求
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    //});//模拟网速不好，延迟加载两秒。目的是查看网络不好的情况下tableView的效果，结果发现屏幕什么也没有 很容易造成觉得这个页面没东西的感觉，因此可以加个提示器，导入第三方SVProgressHUD
    __weak typeof(self) weakSelf = self;
    [[AFNetworkTool shareAFNTool] get:Command_url parameters:nil successBlock:^(NSDictionary *data) {
        [SVProgressHUD dismiss];
        
        // 字典数组转换模型数组
        _subTags = [ReconmmandItem mj_objectArrayWithKeyValuesArray:data];
        
//        ReconmmandItem *recItem = [ReconmmandItem yy_modelWithDictionary:data];
//        weakSelf.subTags = recItem.sub_number;
//        [weakSelf.subTags addObject:recItem];
        // 刷新表格
        [weakSelf.tableView reloadData];
        
    
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReconmmandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecCell" forIndexPath:indexPath];
    // 获取模型
    ReconmmandItem *item = self.subTags[indexPath.row];
    
    cell.recItem = item;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}



@end
