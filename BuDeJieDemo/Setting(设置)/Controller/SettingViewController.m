//
//  SettingViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/19.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.view.backgroundColor = [UIColor redColor];
    
    //处理返回按钮样式 遵循谁的事情谁管理 所以这个要在setting控制器里设置
    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" image:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] titleColor:[UIColor blackColor] highTitleCorlor:[UIColor redColor] target:self                 action:@selector(returnClick)];
    self.navigationItem.title = @"设置";
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(jump)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
-(void)jump
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // 计算缓存数据,计算整个应用程序缓存数据 => 沙盒(Cache) => 获取cache文件夹尺寸
    // YYWebImage:帮我们做了缓存
    [YYImageCache sharedCache];
    
    cell.textLabel.text = @"清除缓存";
    
    return cell;
}



@end
