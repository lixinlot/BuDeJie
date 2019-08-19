//
//  SeeBigPictureViewController.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/5/6.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "SeeBigPictureViewController.h"

@interface SeeBigPictureViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIScrollView * scrollView;

///创建当前app对应的自定义相册
-(PHAssetCollection *)setAssetCollection;

@end

@implementation SeeBigPictureViewController

//保存图片到相机胶卷 ->
//1.C语言函数（如果不要求保存到自定义相册里直接使用这个方法就好了）
//C语言函数
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
//C语言函数
//-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
//    }else{
//        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
//    }
//}

//2.ASSetsLibrary框架（老版本 问题多）

//3.Photos框架（目前使用这个 这个是最新的）

/*
    Photos框架须知：
 PHAsset:一个PHAsset对象就代表相册中一张图片或者是一个视频文件
 1>查：使用PHAsset这个类 [PHAsset fetchAsset...];
 2>增删改：使用PHAssetChangeRequest这个类
 代码必须要放到[PHPhotoLibrary sharedPhotoLibrary] performChanges:里执行
 
 PHAssetCollection:一个对象就代表一个相册
 1>查：使用PHAssetCollection这个类 [PHAssetCollection fetchAssetCollections...];
 2>增删改：使用PHAssetCollectionChangeRequest这个类
 代码必须要放到[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:里执行
 
 //异步执行
     [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
         [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
     } completionHandler:^(BOOL success, NSError * _Nullable error) {
         if (error) {
             [SVProgressHUD showErrorWithStatus:@"保存失败！"];
         }else{
             [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
         }
 
     }];
 //同步执行
     NSError *error = nil;
     [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
         [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
     } error:&error];
     if (error) {
         [SVProgressHUD showErrorWithStatus:@"保存失败！"];
     }else{
         [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
     }
 
     NSError *error = nil;
 //Photos  代码必须要放到PHPhotoLibrary里执行
     [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
         NSString *title = @"百思不得其姐";
    //获得软件名字  kCFBundleNameKey是CFStringRef类型的 所以要强转
     NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
 
         [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
     } error:&error];
     if (error) {
         [SVProgressHUD showErrorWithStatus:@"保存失败！"];
     }else{
         [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
     }
     }];
 
 
 */

#pragma mark - 创建相册
-(PHAssetCollection *)setAssetCollection
{
    NSString *title = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    //    NSLog(@"*************************************%@",title);
    //抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //查找当前app对应的自定义相册
    PHAssetCollection *creatAssetCollection = nil;
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            creatAssetCollection = collection;
            break;
        }
    }
    //如果当前相册没有被创建过
    //如果能来到这个方法 说明之前是空号的 所以就不用判断了
    if (creatAssetCollection == nil) {
        NSError *error = nil;
        __block NSString *creatAssetCollectionID = nil;
        //Photos  代码必须要放到PHPhotoLibrary里执行
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            //创建一个自定义相册
            creatAssetCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
            
        } error:&error];
    
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"创建相册失败"];
            return nil;
        }
        creatAssetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[creatAssetCollectionID] options:nil].firstObject;
        
    }
    //根据唯一标识获取刚才创建的相册
//    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[creatAssetCollectionID] options:nil].firstObject;
    return creatAssetCollection;
}

#pragma mark - 点击按钮保存图片
- (IBAction)savePictureButton:(UIButton *)sender
{
    //请求/检查用户访问权限
    //如果用户还没做出选择 会自动弹框 ，用户做出选择后才会执行block里的代码
    //如果已经做出选择 会直接执行block里的代码
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) {//用户拒绝当前应用访问相册
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    [SVProgressHUD showWithStatus:@"请在设置里允许应用访问手机相册"];
                }
            }else if (status == PHAuthorizationStatusAuthorized){//用户允许访问相册
                [self saveImage];
            }else if (status == PHAuthorizationStatusRestricted){//无法访问相册
                [SVProgressHUD showErrorWithStatus:@"系统原因，无法访问相册"];
            }
        });
    }];
    
    
}
-(void)saveImage
{
    NSError *error = nil;
    __block PHObjectPlaceholder *placeholder = nil;
    //1.保存图片到相机胶卷
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        placeholder = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset;
    } error:&error];
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        return;
    }
    
    //2.创建一个自定义相册 获取相册
    PHAssetCollection *creatCollection = self.setAssetCollection;
    if (creatCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"相册创建失败"];
        return;
    }
    
    //3.添加图片到自定义相册里
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest * request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:creatCollection];
        //        [request addAssets:@[placeholder]];这样写的话 封面不会是最新的图片
        [request insertAssets:@[placeholder] atIndexes:[NSIndexSet indexSetWithIndex:0]];//这样就会把最新保存的图片作为封页
    } error:&error];
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
//        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];//这个是设置提示框动画是菊花状的
//        [SVProgressHUD showWithStatus:@"保存成功"];//这个是用来验证的，如果要添加状态 要dissmiss 才会取消这个状态 不然会一直显示的
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}



#pragma mark - 点击按钮返回上一级
- (IBAction)backButton:(UIButton *)sender
{
    
    [self dismissViewControllerAnimated:NO completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    [self addGesture];
    
    [self.view insertSubview:self.scrollView atIndex:0];
    
    self.imageView = [[UIImageView alloc] init];    
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:self.model.image1] placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (!image) {
            return;
        }
        self.saveBtn.enabled = YES;
    }];
    
    self.imageView.lx_width = self.scrollView.lx_width;
    self.imageView.lx_height = self.imageView.lx_width * self.model.height / self.model.width;
    self.imageView.lx_x = 0;
    if (self.imageView.lx_height > self.scrollView.lx_height) {
        self.imageView.lx_y = 0;
    }else{
        self.imageView.lx_centerY = self.scrollView.lx_height * 0.5;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.imageView.lx_width, self.imageView.lx_height);
    
    [self.scrollView addSubview:self.imageView];
    
    CGFloat maxScale = self.model.height / self.scrollView.lx_height;
    
    if (maxScale > 1) {
        self.scrollView.maximumZoomScale = 2;
        self.scrollView.delegate = self;
    }
    
}
#pragma mark - 实现滚动视图的代理方法（这个是给scrollView的某个子控件添加缩放的方法）
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - 给scrollView添加手势，点击能够返回上一级
-(void)addGesture
{

    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnOriginView) ] ];
    
}

#pragma mark - 实现手势的点击方法
-(void)returnOriginView
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
