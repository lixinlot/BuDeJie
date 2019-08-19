//
//  SoundTableViewCell.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "SoundTableViewCell.h"

@interface SoundTableViewCell();
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *soundTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic,strong) AVPlayer * player;


@end


@implementation SoundTableViewCell

#pragma mark - 点击播放音乐
- (IBAction)playOrPauseButton:(id)sender
{
    if ([self.playButton isSelected]) {
        [_player play];
    }else{
        [_player pause];
    }
    
    
    
}

#pragma mark - 给每行cell添加间隔
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
    
    
    
}
#pragma mark- 重写Model的set方法
-(void)setTextModelList:(TextModelList *)textModelList
{
    _textModelList = textModelList;
    
    self.nameLabel.text = textModelList.name;
    self.timeLabel.text = textModelList.passtime;
    self.playCountLabel.text = [NSString stringWithFormat:@"%ld次播放",textModelList.playfcount];
    self.soundTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",textModelList.voicetime / 60 ,textModelList.voicetime % 60];
    
    
    [self.headImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.profile_image] options:YYWebImageOptionProgressiveBlur];
    
    self.contentLabel.text = textModelList.text;
    
//    [self.voiceImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.image0] options:YYWebImageOptionProgressiveBlur];
    //由于提供了原图 略缩图。。所以要根据网络状态进行加载图片，可以直接用AFNetworking 但是必须要先开启网络监控 但是如果直接写在这里调用的太频繁因此写到了APPDelegate的完成加载里
    //先判断内存里有没有缓存 有的话直接取出来 没有的话再根据网络情况下载
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    UIImage *originImage = [[YYImageCache sharedCache] getImageForKey:textModelList.image1];//缓存的图片是用URL作为key
    
    if (originImage) {
        self.voiceImageView.image = originImage;
    }else{
        if (manager.isReachableViaWiFi) {//使用的是WiFi
//            [self.voiceImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.image1] options:YYWebImageOptionProgressiveBlur];
            self.voiceImageView.yy_imageURL = [NSURL URLWithString:textModelList.image1];
        }else if(manager.isReachableViaWWAN){//使用的是手机网络
//            [self.voiceImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.image0] options:YYWebImageOptionProgressiveBlur];
             self.voiceImageView.yy_imageURL = [NSURL URLWithString:textModelList.image0];
        }else{//没有可用网络
            UIImage *thumbnailImage = [[YYImageCache sharedCache] getImageForKey:textModelList.image0];
            if (thumbnailImage) {//如果有缓存的小图,就把缓存过的小图给视图
                self.voiceImageView.image = thumbnailImage;
            }else{//如果没有缓存的图片 就显示占位图 没有占位图就清空
                //self.voiceImageView.image = 占位图 ;
                self.voiceImageView.image = nil;
            }
        }
    }
    
    
    
    
    //创建音乐播放器
//    NSURL * url = [NSURL URLWithString:self.textModelList.voiceuri];
//    AVPlayerItem * playerItem = [[AVPlayerItem alloc] initWithURL:url];
//    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];

//    self.player = [[AVPlayer alloc] initWithURL:url];
//    AVPlayerItem * playerItem = self.player.currentItem;
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.love] forState:UIControlStateNormal];
    [self.hateButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.hate] forState:UIControlStateNormal];
    [self.shareButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.repost] forState:UIControlStateNormal];
    [self.messageButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.comment] forState:UIControlStateNormal];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.cornerRadius = 45 / 2;
    
    self.autoresizingMask = UIViewAutoresizingNone;
    self.voiceImageView.userInteractionEnabled = YES;
    //给contentImageView添加手势
    [self.voiceImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seePicture)]];

}
-(void)seePicture
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"presentBigVCClickNotification" object:nil userInfo:@{@"key" : self.textModelList}];
////    SeeBigPictureViewController *seeBigVC = [[SeeBigPictureViewController alloc] init];
////    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigVC animated:YES completion:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
