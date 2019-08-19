//
//  BuDeJieTabBarController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/18.
//  Copyright © 2018年 jimmy. All rights reserved.
//

/*
 问题:
 1.选中按钮的图片被渲染 -> iOS7之后默认tabBar上按钮图片都会被渲染 1.修改图片(找到图片，选中render as里的origin image。如果有很多，就先选中放图片的那一块儿然后commsnd+a,全部选中再设置就好了) 2.通过代码 √
 2.选中按钮的标题颜色:黑色 标题字体大 -> 对应子控制器的tabBarItem
   设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
 
 3.发布按钮显示不出来 分析:为什么其他图片可以显示,我的图片不能显示 => 发布按钮图片太大,导致显示不出来
 
 1.图片太大,系统帮你渲染 => 能显示 => 位置不对 => 高亮状态达不到
 
 解决:不能修改图片尺寸, 效果:让发布图片居中
 
 2.如何解决:系统的TabBar上按钮状态只有选中,没有高亮状态 => 中间发布按钮 不能用系统tabBarButton => 发布按钮 不是 tabBarController子控制器
 
 1.自定义tabBar
 
 有图片名字提示的插件  就是用imageNamed的时候我需要提示当前都有哪些图片，不需要自己手敲

 1.改插件 -> 如何去查找插件 -> 插件开发知识 -> 插件代码肯定有个地方指定安装在什么地方
 1.打开插件 2.搜索plug 3.就能找到安装路径
 
 */

/*
 因为在设置选中字体颜色为黑色而不是被渲染时，每次都要写那几个代码 而且每次都会调用,但其实只需要调用一次即可。
 所以把它抽取出来可以写在这两种方法里 +（void）load   和   -(void)initialize这个方法里需要作出判断，例如：if(self == BuDeJieTabBarController class){ }
 注意：+(void)load 只会调用一次  而+(void)initialize可能会被调用多次
 
 //获取UITabBarItem
 UITabBarItem *item = [UITabBarItem appearance];
 appearance:不是所有的类都可以调用它，需要遵守他的协议，并且实现了他的方法。但是在实际开发中一般不会用appearance，因为他会调用项目中所有的tabBarItem。
 哪些属性可以通过appearance设置？只有被UI_APPEARANCE_SELECTOR宏修饰的可以设置
 只能在控件显示之前设置，才有作用
 
 //    newVC.tabBarItem.image = [[UIImage imageNamed:@"tabBar_new_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 //这个方法可以让图片选中的时候不被渲染，但是写的时候不会有提示而且代码重复率很高 很令人烦恼，所以可以把它抽取出来 放到一个image类当中 以后就可以直接创建出一个不被渲染的类。
 
 
 //这样可以使发布按钮的图片居中，但是高亮状态扔达不到想要的效果，所以还是不行，但是要记住 有这种方法 别的地方可以使用到。
 publishVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
 */


#import "BuDeJieTabBarController.h"

@interface BuDeJieTabBarController ()

@end

@implementation BuDeJieTabBarController


#pragma mark - 设置选中字体颜色的load方法（只会被调用一次）
+(void)load
{

    //获取UITabBarItem
    NSArray *array = @[self];
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:array];

    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
//    NSMutableDictionary *arrts = [NSMutableDictionary dictionary];
//    arrts[NSForegroundColorAttributeName] = [UIColor blackColor];
//    [item setTitleTextAttributes:arrts forState:UIControlStateSelected];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];

    // 设置字体尺寸:tabBar上 只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];

}

#pragma mark - 视图已经被加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 3.自定义tabBar
    [self setTabBar];
    // 1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setTabBarChildVC];
    // 2 设置tabBar上按钮内容 -> 由对应的子控制器的tabBarItem属性
    [self setTabBarContentUI];
   
    
    
//    self.selectedIndex = 0;
}

//方便理解才加的
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//    NSLog(@"%@",self.tabBar.subviews);
//}

#pragma mark - 自定义tabBar
-(void)setTabBar
{
    BuDeJieTabBar *tabBar = [[BuDeJieTabBar alloc] init];
    //self.tabBar = tabBar;私有属性不能访问 所以要用KVC。
    [self setValue:tabBar forKey:@"tabBar"];
    
    
}

#pragma mark - 设置所有子控制器
-(void)setTabBarChildVC
{
    //精华
    EssenceViewController *essenceVC = [[EssenceViewController alloc] init];
//    [self setTabBar:essenceVC title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    CustomNavController *nav1 = [[CustomNavController alloc] initWithRootViewController:essenceVC];
    
    //新帖
    NewViewController *newVC = [[NewViewController alloc] init];
//    [self setTabBar:newVC title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    CustomNavController *nav2 = [[CustomNavController alloc] initWithRootViewController:newVC];
    
    //关注
    FriendTrendsViewController *friendVC = [[FriendTrendsViewController alloc] init];
//    [self setTabBar:friendVC title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    CustomNavController *nav3 = [[CustomNavController alloc] initWithRootViewController:friendVC];
    
    //我
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MeViewController" bundle:nil];
    
    MeViewController *meVC = [storyboard instantiateViewControllerWithIdentifier:@"MeViewController"];
//    [self setTabBar:meVC title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    CustomNavController *nav4 = [[CustomNavController alloc] initWithRootViewController:meVC];
    
    self.viewControllers = @[nav1,nav2,nav3,nav4];

    
}

//#pragma mark - 添加按钮上的内容
//- (void)setTabBar:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
//    //精华
////    EssenceViewController *essenceVC = self.childViewControllers[0];
//    vc.tabBarItem.title = title;
//    vc.tabBarItem.image = [UIImage imageNamed:image];
//    vc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:selectedImage];
//    
//    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
//    NSMutableDictionary *arrts = [NSMutableDictionary dictionary];
//    arrts[NSForegroundColorAttributeName] = [UIColor blackColor];
//    [vc.tabBarItem setTitleTextAttributes:arrts forState:UIControlStateSelected];
//    // 设置字体尺寸:tabBar上 只有设置正常状态下,才会有效果
//    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
//    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    [vc.tabBarItem setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
//    
//    
//}


-(void)setTabBarContentUI
{
    //精华
    CustomNavController *essenceVC = self.childViewControllers[0];
    essenceVC.tabBarItem.title = @"精华";
    essenceVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    essenceVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    //新帖
    CustomNavController *newVC = self.childViewControllers[1];
    newVC.tabBarItem.title = @"新贴";
    newVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    newVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    //关注
    CustomNavController *friendVC = self.childViewControllers[2];
    friendVC.tabBarItem.title = @"关注";
    friendVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    friendVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    //我
    CustomNavController *meVC = self.childViewControllers[3];
    meVC.tabBarItem.title = @"我";
    meVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    meVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
    
}

@end
