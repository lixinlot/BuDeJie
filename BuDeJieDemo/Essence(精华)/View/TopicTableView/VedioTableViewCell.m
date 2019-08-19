//
//  VedioTableViewCell.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "VedioTableViewCell.h"

@interface VedioTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vedioImageView;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic,strong) AVPlayer * player;
@property (nonatomic,strong) AVPlayerItem * playerItem;

@end

@implementation VedioTableViewCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
    
}

- (IBAction)playVedioBtn:(UIButton *)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playVedioNotification" object:nil userInfo:@{@"key":self.textModelList}];
//    //1、得到视频的URL
//    NSURL *movieURL = [NSURL URLWithString:_textModelList.videouri];
//    // 2、根据URL创建AVPlayerItem
//    self.playerItem = [AVPlayerItem playerItemWithURL:movieURL];
//    // 3、把AVPlayerItem 提供给 AVPlayer
//    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
//    // 4、AVPlayerLayer 显示视频。
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    playerLayer.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//    //设置边界显示方式
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    [self.view.layer addSublayer:playerLayer];
//    [self.player play];
    
    
}


#pragma mark- 重写Model的set方法
-(void)setTextModelList:(TextModelList *)textModelList
{
    _textModelList = textModelList;
    
    self.nameLabel.text = textModelList.name;
    self.timeLabel.text = textModelList.passtime;
    
    [self.headImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.profile_image] options:YYWebImageOptionProgressiveBlur];
    
    [self.vedioImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.cdn_img] options:YYWebImageOptionProgressiveBlur];
    
    self.contentLabel.text = textModelList.text;
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
    self.vedioImageView.userInteractionEnabled = YES;
    //给contentImageView添加手势
    [self.vedioImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seePicture)]];
    
}
-(void)seePicture
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"presentBigVCClickNotification" object:nil userInfo:@{@"key" : self.textModelList}];
//    SeeBigPictureViewController *seeBigVC = [[SeeBigPictureViewController alloc] init];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigVC animated:YES completion:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
