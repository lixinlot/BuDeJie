//
//  AdViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/19.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "AdViewController.h"
#import <YYWebImage/YYWebImage.h>
#import "YYWebImage.h"
/*
 1.广告业务逻辑
 2.占位视图思想:有个控件不确定尺寸,但是层次结构已经确定,就可以使用占位视图思想
 3.屏幕适配.通过屏幕高度判断
 */

@interface AdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContaintView;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (nonatomic, strong) NSMutableArray *array ;
@property (nonatomic, strong) UIImageView * adView;
//因为NSTimer是系统管理的 用完不会销毁 所以不需要强引用
@property (nonatomic, weak) NSTimer * timer;

@property (nonatomic, strong) AdItem * adItem;

@end

@implementation AdViewController

- (IBAction)clickJump:(id)sender {
    
    //跳转其他界面
    BuDeJieTabBarController *tabBarVC = [[BuDeJieTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    
    //销毁定时器
    [_timer invalidate];
    
    
}

-(UIImageView *)adView
{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.adContaintView addSubview:imageView];
        _adView = imageView;
        
        //如果想点击广告网页图片就跳转到对应的网页 就给imageView添加一个手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        
        imageView.userInteractionEnabled = YES;
        
    }
    
    return _adView;
}
//跳转到广告界面
-(void)tap
{
//    UIApplication可以打开Safari
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:Ad_url];
    if ([app canOpenURL:url]) {
        [app openURL:url options:@{} completionHandler:nil];
    }
    
}

-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [[NSMutableArray alloc] init];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置启动图片
    [self setupLaunchImage];
    
    // 加载广告数据 => 拿到活时间 => 服务器 => 查看接口文档 1.判断接口对不对 2.解析数据(w_picurl,ori_curl:跳转到广告界面,w,h) => 请求数据(AFN)
    [self loadAdData];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    
}
-(void)timeChange
{
    //倒计时
    static int i = 3;
    if (i == 0) {
        [self clickJump:nil];
    }
    i -- ;
    //设置跳转按钮文字
    [self.timeBtn setTitle:[NSString stringWithFormat:@"跳转(%d)",i] forState:UIControlStateNormal];
    
}

-(void)loadAdData
{
//    为避免循环引用 使用__weak来修饰
    __weak typeof (self)weakSelf = self;
    AFNetworkTool *mgr = [AFNetworkTool shareAFNTool];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
//    NSString * url = [NSString stringWithFormat:@"%@?code2=%@",Ad_url,code2];
    
    [mgr get:Ad_url parameters:parameters successBlock:^(NSDictionary *data) {
         [data writeToFile:@"/Users/jimmy/Desktop/JImmy/综合练习/BuDeJieDemo/ad.plist" atomically:YES];
         // 获取字典
         NSDictionary *adDict = [data[@"ad"] lastObject];
         // 字典转模型
         _adItem = [AdItem yy_modelWithDictionary:adDict];
         [weakSelf.array addObject:_adItem];
         // 创建UIImageView展示图片 =>
         CGFloat h = screenWidth / _adItem.w * _adItem.h;
         self.adView.frame = CGRectMake(0, 0, screenWidth, h);
         // 加载广告网页
//         [self.adView yy_setImageWithURL:[NSURL URLWithString:_adItem.w_picurl] options:YYWebImageOptionProgressiveBlur ｜ YYWebImageOptionSetImageWithFadeAnimation];
         // 加载网络图片
         self.adView.yy_imageURL = [NSURL URLWithString:_adItem.w_picurl];
         
    } failureBlock:^(NSError *error) {
        NSLog(@"************%@",error);
    }];
    
    
}


// 设置启动图片
- (void)setupLaunchImage
{
    // 6p:LaunchImage-800-Portrait-736h@3x.png
    // 6:LaunchImage-800-667h@2x.png
    // 5:LaunchImage-568h@2x.png
    // 4s:LaunchImage@2x.png
    if (iphone6P) { // 6p
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iphone6) { // 6
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iphone5) { // 5
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
        
    } else if (iphone4) { // 4
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    
}

@end
