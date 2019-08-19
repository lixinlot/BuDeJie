//
//  AFNetworkTool.h
//  BuDeJieDemo
//
//  Created by jimmy on 2018/4/22.
//  Copyright © 2018年 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义block
typedef void (^SuccessBlock)(id responseObject);
typedef void (^FailureBlock)(NSError *error);

@interface AFNetworkTool : NSObject

+(AFNetworkTool *)shareAFNTool;

//获取数据常用的两种方法get post(这里写的是带参数的)
-(void)get:(NSString *)urlString parameters:(NSDictionary *)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

-(void)post:(NSString *)urlString params:(NSDictionary *)params successBlock:(SuccessBlock )successBlock failureBlock:(FailureBlock )failureBlock;

@end
