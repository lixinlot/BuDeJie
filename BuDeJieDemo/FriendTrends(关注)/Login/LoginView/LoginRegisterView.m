//
//  LoginRegisterView.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/24.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "LoginRegisterView.h"
#import <SMS_SDK/SMSSDK.h>

@interface LoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;

@end

@implementation LoginRegisterView

+(instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
    
}

+(instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImage *image = _loginRegisterButton.currentBackgroundImage;
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    // 让按钮背景图片不要被拉伸
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
}
- (IBAction)SendMa:(UIButton *)sender
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"SendYanZhengMa" object:nil];
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
            NSLog(@"%@****",error);
        }
    }];
    
}
- (IBAction)Register:(UIButton *)sender
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"Register" object:nil];
    //提交短信验证码
    [SMSSDK commitVerificationCode:@"9170" phoneNumber:@"15658826752" zone:@"86" result:^(NSError *error) {
        
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


@end
