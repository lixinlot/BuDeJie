//
//  TextTableViewCell.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

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
    
    [self.headImageView yy_setImageWithURL:[NSURL URLWithString:textModelList.profile_image] options:YYWebImageOptionProgressiveBlur];
    
    self.contentLabel.text = textModelList.text;
    
    [self resolveNum:textModelList];
}
-(void)resolveNum:(TextModelList *)modelList
{
//    // 判断下有没有>10000
    NSString *numLove = [IntValueChange intValueChanged:modelList.love];
    NSString *numHate = [IntValueChange intValueChanged:modelList.hate];
    NSString *numRepost = [IntValueChange intValueChanged:modelList.repost];
    NSString *numComment = [IntValueChange intValueChanged:modelList.comment];

    [_likeButton setTitle:numLove forState:UIControlStateNormal];
    [_lastButton setTitle:numHate forState:UIControlStateNormal];
    [_shareButton setTitle:numRepost forState:UIControlStateNormal];
    [_messageButton setTitle:numComment forState:UIControlStateNormal];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headImageView.layer.cornerRadius = 45 / 2;
//    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    [self.contentLabel sizeToFit];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
