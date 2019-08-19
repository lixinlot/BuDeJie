//
//  AFNetworkTool.m
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/22.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import "AFNetworkTool.h"

@interface AFNetworkTool ()

@property (nonatomic, strong) AFHTTPSessionManager * manager;

@end

@implementation AFNetworkTool

+(AFNetworkTool *)shareAFNTool
{
    static AFNetworkTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        tool = [[AFNetworkTool alloc] init];
    });
    return tool;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initManager];
    }
    return self;
}

-(void)initManager
{
    self.manager = [AFHTTPSessionManager manager];
    //可以接受的类型
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求队列的并发数（知道有就行了 这个可以不处理）
    self.manager.operationQueue.maxConcurrentOperationCount = 5;
    //请求超时的时间(200毫秒)
    self.manager.requestSerializer.timeoutInterval = 200;
    //设置格式
    [self.manager.requestSerializer setValue:@"application/j son" forHTTPHeaderField:@"Content-Type"];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    //允许http数据连接，默认是不允许的默认的是https
    [self.manager.securityPolicy setAllowInvalidCertificates:YES];
    
}

-(void)get:(NSString *)urlString parameters:(NSDictionary *)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    [self.manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"*********************%@",error);
        }
    }];
    
    
    
}

-(void)post:(NSString *)urlString params:(NSDictionary *)params successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    [self.manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"******************%@",error);
        }
    }];
    
    
}


@end
