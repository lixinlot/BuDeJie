//
//  VedioViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/5/15.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "VedioViewController.h"
#import <AVKit/AVKit.h>

@interface VedioViewController ()
{
    AVPlayerViewController      *_playerController;
    
}

@property (nonatomic,strong) AVPlayer * player;
@property (nonatomic,strong) AVPlayerItem * playerItem;

@end

@implementation VedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1、得到视频的URL
    NSURL *movieURL = [NSURL URLWithString:self.model.videouri];
    // 2、根据URL创建AVPlayerItem
    self.playerItem = [AVPlayerItem playerItemWithURL:movieURL];
    // 3、把AVPlayerItem 提供给 AVPlayer
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    // 4、AVPlayerLayer 显示视频。
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.view.bounds;
    //设置边界显示方式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:playerLayer];
    
//    _playerController = [[AVPlayerViewController alloc] init];
//    _playerController.player = _player;
//    _playerController.videoGravity = AVLayerVideoGravityResizeAspect;
//    //_playerController.allowsPictureInPicturePlayback = true;    //画中画，iPad可用
//    _playerController.showsPlaybackControls = true;
//
//    [self addChildViewController:_playerController];
//    _playerController.view.translatesAutoresizingMaskIntoConstraints = true;    //AVPlayerViewController 内部可能是用约束写的，这句可以禁用自动约束，消除报错
//    _playerController.view.frame = CGRectMake(0, 64, screenWidth, screenHeight - 64);
//    [self.view addSubview:_playerController.view];
    [self.player play];
    
}




@end
