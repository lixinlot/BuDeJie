//
//  LoginViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/24.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "LoginViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *middle;
@property (weak, nonatomic) IBOutlet UIView *bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;

@end

@implementation LoginViewController

// 1.划分结构(顶部 中间 底部) // 2.一个结构一个结构
// 越复杂的界面 越要封装(复用)

/*
 屏幕适配:
 1.一个view从xib加载,需不需在重新固定尺寸 一定要在重新设置一下
 
 2.在viewDidLoad设置控件frame好不好,开发中一般在viewDidLayoutSubviews布局子控件
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    //创建登录view
    LoginRegisterView *loginView = [LoginRegisterView loginView];
    // 添加到中间的view
    [self.middle addSubview:loginView];
    //添加注册界面
    LoginRegisterView *registerView = [LoginRegisterView registerView];
    // 添加到中间的view
    [self.middle addSubview:registerView];
    
    //添加快速注册界面
    FastLoginView *fastLoginView = [FastLoginView fastLoginView];
    // 添加到最下方的view
    [self.bottom addSubview:fastLoginView];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMa) name:@"SenYanZhengMa" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registe) name:@"Register" object:nil];
                                    
}
-(void)sendMa
{
    //请求短信验证码 不带自定义模版
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"15658826752" zone:@"86"  result:^(NSError *error) {
        
        if (!error)
        {
            // 请求成功
            NSLog(@"请求成功");
        }
        else
        {
            // error
            NSLog(@"*****%@****",error);
        }
    }];
    
    
    
    
}
-(void)registe
{
    //提交短信验证码
    [SMSSDK commitVerificationCode:@"1234" phoneNumber:@"15658826752" zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            // 验证成功
            NSLog(@"验证成功");
        }
        else
        {
            // error
            NSLog(@"*****%@****",error);
        }
    }];
}
//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}



// 点击关闭
- (IBAction)closeBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
// 点击注册
- (IBAction)registerBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    // 平移中间view
    _leftCons.constant = _leftCons.constant == 0 ? -self.middle.lx_width * 0.5 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

// viewDidLayoutSubviews:才会根据布局调整控件的尺寸
-(void)viewDidLayoutSubviews
{
    // 一定要调用super
    [super viewDidLayoutSubviews];
    
    // 设置登录view
    LoginRegisterView *loginView = self.middle.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middle.lx_width * 0.5, self.middle.lx_height);
    // 设置注册view
    LoginRegisterView *registerView = self.middle.subviews[1];
    registerView.frame = CGRectMake(self.middle.lx_width * 0.5, 0, self.middle.lx_width * 0.5, self.middle.lx_height);
    // 设置快速登录
    FastLoginView *fastLoginView = self.bottom.subviews.firstObject;
    fastLoginView.frame = self.bottom.bounds;
}



@end
