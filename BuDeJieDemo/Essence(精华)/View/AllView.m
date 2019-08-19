//
//  AllView.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/26.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "AllView.h"
#import "TextModel.h"


@interface AllView()<UITableViewDataSource,UITableViewDelegate>

{
    CGFloat         _tableViewH;
    HomeTableView   _type;
}

@property (nonatomic, strong) UITableView * tableView;
//@property (nonatomic, assign) HomeTableView  type;

@property (nonatomic, strong) TextModel * textModel;

@property (nonatomic, strong) NSMutableArray * textMArray;

@property (nonatomic, strong) NSMutableDictionary * cellHeightDict;



@end



@implementation AllView

- (NSMutableDictionary *)cellHeightDict
{
    if (_cellHeightDict  == nil) {
        _cellHeightDict  = [[NSMutableDictionary  alloc] init];
    }
    return _cellHeightDict;
}

- (NSMutableArray *)textMArray
{
    if (_textMArray  == nil) {
        _textMArray  = [[NSMutableArray  alloc] init];
    }
    return _textMArray;
}

+ (AllView *)initWith:(HomeTableView)type x:(int)x
{
    AllView * view = [[AllView alloc] initWithFrame:CGRectMake(x, 0, screenWidth, screenHeight - 44 - 40 - 64) type:type];
    
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame type:(HomeTableView)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _tableViewH = frame.size.height;
        
        [self setTableViewUI];
        [self setRefreshTableView];
        [self initData];
    }
   
    return self;
}
-(void)setTableViewUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, _tableViewH)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LXColor(220, 220, 221);
    [self addSubview:self.tableView];
   
    
}

-(void)initData
{
    [self registerCell];
    
    //先让他加载第一个数据 后面的数据滚动的时候 在请求 就是用到了在拿 不用就不拿
    if (_type == HomeTableView_AllView) {
        [self getDataFormServer:NO];
    }
    
}
#pragma mark - 刷新数据
- (void)setRefreshTableView
{
    /** 为了避免 block 的循环引用导致内存泄漏  要使用__weakSelf 来代替self */
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFormServer:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getDataFormServer:YES];
    }];
}

#pragma mark - 获取数据
-(void)getDataWithUrl:(NSString *)url
{
//    [SVProgressHUD showWithStatus:@"正在加载中....."];
    __weak typeof(self) weakSelf = self;
    
    [[AFNetworkTool shareAFNTool] get:url parameters:nil successBlock:^(id dict) {
        
        [SVProgressHUD dismissWithDelay:0.1];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        TextModel * model = [TextModel yy_modelWithDictionary:dict];

        weakSelf.textModel = model;

        weakSelf.textMArray = model.list;
        
        [weakSelf.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        
        [weakSelf.tableView.mj_footer endRefreshing];

    }];
    
}
-(void)getMoreDataWithUrl:(NSString *)url
{
    __weak typeof(self) weakSelf = self;
    
    [[AFNetworkTool shareAFNTool] get:url parameters:nil successBlock:^(id dict) {
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
        TextModel * model = [TextModel yy_modelWithDictionary:dict];
        
        weakSelf.textModel = model;
        
       [weakSelf.textMArray addObjectsFromArray:model.list];
        
        [weakSelf.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        
       [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
    
}



- (void)getDataFormServer:(BOOL)isMore
{

    if (_type == HomeTableView_AllView) {
        if (!isMore) {
            [self getDataWithUrl:Essence_refreshUrl([NSString stringWithFormat:@"1"])];
        }else{
            [self getMoreDataWithUrl:Essence_moreUrl(self.textModel.info.maxtime)];
        }
    }else if (_type == HomeTableView_VedioView){
        if (!isMore) {
            [self getDataWithUrl:Essence_refreshUrl([NSString stringWithFormat:@"41"])];
        }else{
            [self getMoreDataWithUrl:Essence_moreUrl(self.textModel.info.maxtime)];
        }
    }else if (_type == HomeTableView_PictureView) {
        if (!isMore) {
            [self getDataWithUrl:Essence_refreshUrl([NSString stringWithFormat:@"10"])];
        }else{
            [self getMoreDataWithUrl:Essence_moreUrl(self.textModel.info.maxtime)];
        }
    }else if (_type == HomeTableView_SoundView) {
        if (!isMore) {
            [self getDataWithUrl:Essence_refreshUrl([NSString stringWithFormat:@"31"])];
        }else{
            [self getMoreDataWithUrl:Essence_moreUrl(self.textModel.info.maxtime)];
        }
    }else{
        if (!isMore) {
            [self getDataWithUrl:Essence_refreshUrl([NSString stringWithFormat:@"29"])];
        }else{
            [self getMoreDataWithUrl:Essence_moreUrl(self.textModel.info.maxtime)];
        }
        
    }
}


//-(void)- (:(BOOL)isMore
//{
//    if (isMore) {
//        [self getDataWithUrl:Essence_refreshUrl];
//    }else{
//        [self getMoreDataWithUrl:Essence_moreUrl(self.textModel.info.maxtime)];
//    }
//}


-(void)registerCell
{
    if (_type == HomeTableView_AllView){
        // 注册视频的 cell
        [self.tableView registerNib:[UINib nibWithNibName:@"VedioTableViewCell" bundle:nil] forCellReuseIdentifier:@"VedioCell"];
        // 注册图片的 cell
        [self.tableView registerNib:[UINib nibWithNibName:@"PictureTableViewCell" bundle:nil] forCellReuseIdentifier:@"PictureCell"];
        // 注册声音的 cell
        [self.tableView registerNib:[UINib nibWithNibName:@"SoundTableViewCell" bundle:nil] forCellReuseIdentifier:@"SoundCell"];
        // 注册段子的 cell
        [self.tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextCell"];
        
    }else if (_type == HomeTableView_VedioView) {
        // 注册视频的 cell
        [self.tableView registerNib:[UINib nibWithNibName:@"VedioTableViewCell" bundle:nil] forCellReuseIdentifier:@"VedioCell"];
        
    }else if (_type == HomeTableView_PictureView) {
        // 注册图片的 cell
        [self.tableView registerNib:[UINib nibWithNibName:@"PictureTableViewCell" bundle:nil] forCellReuseIdentifier:@"PictureCell"];
        
    }else if (_type == HomeTableView_SoundView) {
        // 注册声音的 cell
        [self.tableView registerNib:[UINib nibWithNibName:@"SoundTableViewCell" bundle:nil] forCellReuseIdentifier:@"SoundCell"];
        
    }else{
        // 注册段子的 cell
        [self.tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextCell"];
        
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.textMArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextModelList *model = self.textMArray[indexPath.row];

    CGSize size = [model.text boundingRectWithSize:CGSizeMake(screenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        //高度
        if (_type == HomeTableView_AllView) {
            if (model.type == 41) {
                return model.height / 2 + size.height + 150;

            }else if(model.type == 10){
                if (model.height >= screenHeight) {
                    return size.height + 300;
//                    NSLog(@"%lf",size.height + 300);

                }else{
                    return model.height + size.height + 150;
//                    NSLog(@"%lf",size.height);

                }
            }else if (model.type == 31){
                return model.height / 2 + size.height + 150;
            }else{
                return size.height + 150;
            }
        }else if(_type == HomeTableView_VedioView){
            return model.height / 2 + size.height + 150;
        }else if(_type == HomeTableView_SoundView){
            return model.height / 2 + size.height + 150;
        }else if(_type == HomeTableView_PictureView){
            if (model.height >= screenHeight) {
                model.is_longImage = YES;
                return size.height + 300;
            }else{
                return model.height + size.height + 150;
            }
        }else{
            return size.height + 150;
        }
        //存储高度
//        self.cellHeightDict[key] = @(cellHeight);
    
//        NSLog(@"%zd %lf",indexPath.row, size.height);
//    }
//    return cellHeight;

//    [self addSeeMoreButton];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VedioTableViewCell *vedioCell = [tableView dequeueReusableCellWithIdentifier:@"VedioCell"];
    PictureTableViewCell *pictureCell = [tableView dequeueReusableCellWithIdentifier:@"PictureCell"];
    SoundTableViewCell *soundCell = [tableView dequeueReusableCellWithIdentifier:@"SoundCell"];
    TextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
    
    
    //先根据type 来判断返回的cell
    if (_type == HomeTableView_AllView) {
        //根据Model 的type 来判断
        TextModelList *model = self.textMArray[indexPath.row];
        if (model.type == 10) {
            pictureCell.textModelList = self.textMArray[indexPath.row];
            return pictureCell;
        }else if (model.type == 41){
            vedioCell.textModelList = self.textMArray[indexPath.row];
            return vedioCell;
        }else if (model.type == 31){
            soundCell.textModelList = self.textMArray[indexPath.row];
            return soundCell;
        }else {//if(model.type == 29)
            textCell.textModelList = self.textMArray[indexPath.row];
            return textCell;
        }
    }else if (_type == HomeTableView_VedioView) {
        vedioCell.textModelList = self.textMArray[indexPath.row];
        return vedioCell;
    }else if(_type == HomeTableView_PictureView){
        pictureCell.textModelList = self.textMArray[indexPath.row];
        return pictureCell;
    }else if(_type == HomeTableView_SoundView){
        soundCell.textModelList = self.textMArray[indexPath.row];
        return soundCell;
    }else {
        textCell.textModelList = self.textMArray[indexPath.row];
        return textCell;
    }
    
}
- (void)addSeeMoreButton
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"点击查看全文"];
    YYLabel *label = [YYLabel new];
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
    hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) {
        
        [label sizeToFit];
    };
    [text yy_setColor:[UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000] range:[text.string rangeOfString:@"more"]];
    [text yy_setTextHighlight:hi range:[text.string rangeOfString:@"more"]];
    text.yy_font = label.font;
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter  attachmentSize:seeMore.frame.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentCenter];
    
    label.truncationToken = truncationToken;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
