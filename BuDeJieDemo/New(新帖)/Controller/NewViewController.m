//
//  NewViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/18.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HMSegmentedControl * essenceSegment;
@property (nonatomic, strong) UIScrollView * essenceScrollView;

@property (nonatomic, strong) UITableView * allTableView;
@property (nonatomic, strong) UITableView * vedioTableView;
@property (nonatomic, strong) UITableView * soundTableView;
@property (nonatomic, strong) UITableView * pictureTableView;
@property (nonatomic, strong) UITableView * textTableView;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavgationUI];
    
    [self setEssenceSegmentUI];
    
    [self setEssenceScrollViewUI];
    
    
}

#pragma mark - 设置选项栏
-(void)setEssenceSegmentUI
{
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    self.essenceSegment = [HMSegmentedControl segmentWithTitle:titles];
    [self.essenceSegment addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.essenceSegment];
    
}

-(void)changeValue:(UISegmentedControl *)segmentControl
{
    
}

#pragma mark - 设置滚动视图
-(void)setEssenceScrollViewUI
{
    self.essenceScrollView = [UIScrollView scrollViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.essenceSegment.frame), screenWidth, screenHeight) contenSize:CGSizeMake(screenWidth * 5, screenHeight - 44 - 40 - 64) tag:1000];
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.essenceScrollView.delegate = self;
    
    [self.view addSubview:self.essenceScrollView];
    
    
    
}

#pragma mark - 设置导航栏
-(void) setNavgationUI
{
    //左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
    
    // titleView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageView;
    
    
    
}
-(void)tagClick
{
    ReconmmandViewController *recommandVC = [[ReconmmandViewController alloc] init];
    [self.navigationController pushViewController:recommandVC animated:YES];
    
}

#pragma mark -tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    return cell;
}


@end
