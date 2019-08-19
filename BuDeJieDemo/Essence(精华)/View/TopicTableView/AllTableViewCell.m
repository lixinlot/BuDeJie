//
//  AllTableViewCell.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "AllTableViewCell.h"

@interface AllTableViewCell()

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *moreButton;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *likeButton;
@property (nonatomic,strong) UIButton *lastButton;
@property (nonatomic,strong) UIButton *shareButton;
@property (nonatomic,strong) UIButton *messageButton;
@property (nonatomic,strong) UIImageView *voiceImageView;
@property (nonatomic,strong) UIButton *playButton;
@property (nonatomic,strong) UILabel *playCountLabel;
@property (nonatomic,strong) UILabel *soundTimeLabel;
@property (nonatomic,strong) UIImageView *contentImageView;

@end

@implementation AllTableViewCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
    
}

#pragma mark- 重写Model的set方法
-(void)setTextModelList:(TextModelList *)textModelList
{
    _textModelList = textModelList;
    
    _textModelList = textModelList;
    
    self.nameLabel.text = textModelList.name;
    self.timeLabel.text = textModelList.passtime;
    
    [self.headImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.profile_image] options:YYWebImageOptionProgressiveBlur];
    
    [self.voiceImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.image0] options:YYWebImageOptionProgressiveBlur];
    
    [self.contentImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.cdn_img] options:YYWebImageOptionProgressiveBlur];
    
    self.contentLabel.text = textModelList.text;
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.love] forState:UIControlStateNormal];
    [self.lastButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.hate] forState:UIControlStateNormal];
    [self.shareButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.repost] forState:UIControlStateNormal];
    [self.messageButton setTitle:[NSString stringWithFormat:@"%ld",textModelList.comment] forState:UIControlStateNormal];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.headImageView.layer.cornerRadius = 45 / 2;
    
    
    
    
    
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//-(void)tabBarButtonDidRepeatClick
//{
//    //重复点击的不是精华按钮 return (点击别的tabBarButton的时候精华会被销毁，也就是说 当前显示的window为空时 才会返回 不刷新 只有不为空的时候才刷新 )
//    if (self.window == nil) {
//        return;
//    }
//    
//    //重复点击的不是 AllView
////    if (self.scrollsToTop == NO) {
////        return;
////    }
//    LXLog(@"%@----刷新的数据",self.class);
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
