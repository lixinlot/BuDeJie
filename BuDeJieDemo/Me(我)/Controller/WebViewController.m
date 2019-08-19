//
//  WebViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/25.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIView *contenView;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (strong, nonatomic)  WKWebView *webView;

@end

@implementation WebViewController
- (IBAction)goBack:(id)sender {
    
    [self.webView goBack];
    
}
- (IBAction)goForward:(id)sender {
    
    [self.webView goForward];
    
}
- (IBAction)refresh:(id)sender {
    
    [self.webView reload];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加webView
    self.webView = [[WKWebView alloc] init];
    [self.contenView addSubview:self.webView];
    
    //展示网页
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
    
    //使用KVO监听属性变化 由于一开始不能让前进和后退 所以要监听他们的变化 只有当他们发生变化的时候才可以点击 在xib里设置enable不选中
    /*
     Observer:观察者
     KeyPath:观察webView哪个属性
     options:NSKeyValueObservingOptionNew:观察新值改变
     
     KVO注意点.一定要记得移除
     */
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    // 进度条
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark - 只要观察到对象属性发生了变化 就会调用这个方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    self.back.enabled = self.webView.canGoBack;
    self.forward.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    self.progress.progress = self.webView.estimatedProgress;
    self.progress.hidden = self.webView.estimatedProgress >= 1;
    
}

#pragma mark - 移除KVO
-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - 生命周期方法
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = self.contenView.bounds;
    
}





@end
