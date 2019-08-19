//
//  CustomNavController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/18.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "CustomNavController.h"

@interface CustomNavController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomNavController

+(void)load
{
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navigationBar setTitleTextAttributes:attrs];
    
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(252/255.0) green:(200/255.0) blue:(200/255.0) alpha:1.0]];
//
//    [[UINavigationBar appearance] setShadowImage:nil];
    
    //只有非根控制器才需要触发滑动返回手势
//    self.interactivePopGestureRecognizer.delegate = self;
    //
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];//handleNavigationTransition
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    //只有非根控制器才需要触发滑动返回手势
    //自己已经定义了一个手势 所以要禁止之前的手势作用
    self.interactivePopGestureRecognizer.enabled = NO;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    //设置返回按钮 只有非根控制器才需要返回按钮
    //恢复手势滑动功能->分析：重写了他的方法 所以把按钮覆盖掉了就不能滑动了 ->查看文档发现有手势 不能滑动是因为手势失效了（猜想原因：1.可能是手势被清空了：经过打印验证后这个猜想是错的，打印出来了手势 2.可能是代理手势做了一些事情导致手势失效：经过验证就是有代理然后给手势代理为nil就能恢复手势滑动了。）但是这样一来就会使根控制器也会有这个功能 造成假死状态：（程序还在运行 但是界面不能动了）所以需要手动管理。所以要把代理赋值给self 不能赋为nil
    if (self.childViewControllers.count > 0) {//大于0说明是子控制器  (等于0的时候vc还没有子控制器 )
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" image:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] titleColor:[UIColor blackColor] highTitleCorlor:[UIColor redColor] target:self action:@selector(returnClick)];
    }
    
    //真正实现跳转的就是这句话 所以必须要先写上
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 实现UIGestureRecognizerDelegate
//决定是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

-(void)returnClick
{
    [self popViewControllerAnimated:YES];
}


@end
