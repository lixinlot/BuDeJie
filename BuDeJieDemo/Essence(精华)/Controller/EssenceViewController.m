//
//  EssenceViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/18.
//  Copyright © 2018年 jimmy. All rights reserved.
//

/*#pragma mark - 设置导航条
-(void) setNavgationUI
{
    //左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    //    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [leftButton setImage:[UIImage imageNamed:@"nav_item_game_iconN"] forState:UIControlStateNormal];
    //    [leftButton setImage:[UIImage imageNamed:@"nav_item_game_click_icon"] forState:UIControlStateHighlighted];
    //    [leftButton addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    //    [leftButton sizeToFit];
    //    UIView *leftView = [[UIView alloc] initWithFrame:leftButton.bounds];
    //    [leftView addSubview:leftButton];
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    //    //右边按钮
    //    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [rightButton setImage:[UIImage imageNamed:@"navigationButtonRandom"] forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"navigationButtonRandomClick"] forState:UIControlStateHighlighted];
    //    [rightButton sizeToFit];
    //    UIView *rightView = [[UIView alloc] initWithFrame:rightButton.bounds];
    //    [rightView addSubview:rightButton];
    //
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageView;
    
    //由此可见 代码也比较繁琐 而且代码重复率比较高 因此可以把他抽成一个类
    
}*/

#import "EssenceViewController.h"
#import "UIBarButtonItem+BarItem.h"
#import "AllView.h"



@interface EssenceViewController ()<UIScrollViewDelegate>

{
    BOOL _isScroll;
    NSInteger  _index;
}

@property (nonatomic, strong) HMSegmentedControl * essenceSegment;
@property (nonatomic, strong) UIScrollView * essenceScrollView;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, assign) NSInteger * previousSelectedSegmentIndex;

@property (nonatomic, strong) NSMutableArray * allViews;



@end

// UIBarButtonItem:描述按钮具体的内容
// UINavigationItem:设置导航条上内容(左边,右边,中间)
// tabBarItem: 设置tabBar上按钮内容(tabBarButton)

@implementation EssenceViewController

- (NSMutableArray *)allViews
{
    if (_allViews  == nil) {
        _allViews  = [[NSMutableArray  alloc] init];
    }
    return _allViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _index = 0;
    
    //添加导航条
    [self setNavgationUI];
    
    [self setEssenceSegmentUI];
    
    // scrollView
    [self setEssenceScrollViewUI];
    
    //添加观察者（因为是从cell上发过来的通知 需要控制器接收 来进行View之间的跳转）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentBigVC:) name:@"presentBigVCClickNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVedio:) name:@"playVedioNotification" object:nil];
    
}
#pragma mark - 实现通知方法
-(void)playVedio:(NSNotification *)notification
{
    VedioViewController *vedioVC = [[VedioViewController alloc] init];
    vedioVC.model = notification.userInfo[@"key"];
    [self.navigationController pushViewController:vedioVC animated:YES];
     
}

#pragma mark - 实现通知方法
-(void)presentBigVC:(NSNotification *)notification
{
    SeeBigPictureViewController *seeBigPictureVC = [[SeeBigPictureViewController alloc] init];
    seeBigPictureVC.model = notification.userInfo[@"key"];
    [self presentViewController:seeBigPictureVC animated:NO completion:nil];
}
#pragma mark - 移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



//-(void)segmentDidRepeatClick
//{
//    //重复点击的不是精华按钮 return (点击别的tabBarButton的时候精华会被销毁，也就是说 当前显示的window为空时 才会返回 不刷新 只有不为空的时候才刷新 )
//    if (self.view.window == nil) {
//        return;
//    }
    //重复点击的不是 AllView
//    if (self.view.scrollsToTop == NO) {
//        return;
//    }
//}
//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

#pragma mark - 设置选项栏
-(void)setEssenceSegmentUI
{
    self.titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    self.essenceSegment = [HMSegmentedControl segmentWithTitle:self.titles];
    
    [self.essenceSegment addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.essenceSegment];
    
}

#pragma mark - 设置滚动视图
-(void)setEssenceScrollViewUI
{
    self.essenceScrollView = [UIScrollView scrollViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.essenceSegment.frame), screenWidth, screenHeight) contenSize:CGSizeMake(screenWidth * 5, screenHeight - 44 - 40 - 64) tag:1000];
    //     不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.essenceScrollView.delegate = self;
    
    [self.view addSubview:self.essenceScrollView];

    [self.allViews removeAllObjects];
    for (int i = 0; i < 5; i++) {
        AllView * view = [AllView initWith:i+1 x:screenWidth*i];

//        if (i % 2 == 0) {
//            view.backgroundColor = [UIColor redColor];
//        }else{
//            view.backgroundColor = [UIColor blueColor];
//        }
        [self.essenceScrollView addSubview:view];
        [self.allViews addObject:view];
    }

    
    
}

#pragma mark - 设置导航栏
-(void) setNavgationUI
{
    //左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    
    // titleView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageView;
    
    //由此可见 代码也比较繁琐 而且代码重复率比较高 因此可以把他抽成一个类 
    
}
-(void)game
{
    
}

#pragma mark - 开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

{
    if (scrollView.tag == 1000) {
        _isScroll = true;
    }
}

#pragma mark - scrollView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 1000 && _isScroll) {
        NSInteger index = self.essenceScrollView.contentOffset.x / screenWidth + 0.5;
        if (index != _index) {
            _index = index;
            self.essenceSegment.selectedSegmentIndex = index;
             // 请求数据
            if (self.allViews.count == 5) {
                AllView * view = self.allViews[_index];
                [view getDataFormServer:NO];
            }
        }
       
    }
    //清除缓存
    TextModelList *textModelList = [[TextModelList alloc] init];
    [[YYImageCache sharedCache] removeImageForKey:textModelList.image1];
}

//滚动动画停止时执行,代码改变时出发,也就是setContentOffset改变时
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
//
//{
//    if (scrollView.tag == 1000) {
//        NSInteger index = self.essenceScrollView.contentOffset.x / screenWidth + 0.5;
//        self.essenceSegment.selectedSegmentIndex = index;
//        NSLog(@"scrollViewDidEndScrollingAnimation ----  %ld", index);
//    }
//
//}

#pragma mark - 实现segment的点击事件
-(void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{

    _isScroll = false;
     [self.essenceScrollView setContentOffset:CGPointMake(screenWidth * segmentedControl.selectedSegmentIndex, 0) animated:YES];
//    NSLog(@"segmentedControlChangedValue ----  %ld", segmentedControl.selectedSegmentIndex);
    
    // 请求数据
    AllView * view = self.allViews[segmentedControl.selectedSegmentIndex];
    [view getDataFormServer:NO];
}



@end
