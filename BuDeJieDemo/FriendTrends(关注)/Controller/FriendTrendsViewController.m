//
//  FriendTrendsViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/18.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "FriendTrendsViewController.h"

@interface FriendTrendsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;

@end

@implementation FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self setNavgationUI];
    
    
    
    
}
- (IBAction)LoginBtn:(UIButton *)sender {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
    
}

#pragma mark - 设置导航栏
-(void) setNavgationUI
{
    //左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:nil action:nil];
    
    // title
    
    self.navigationItem.title = @"我的关注";
}

@end
