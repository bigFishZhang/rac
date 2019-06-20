//
//  ZBHttpManager.m
//  MvvmRAC
//
//  Created by bigfish on 2019/6/20.
//  Copyright © 2019 zzb. All rights reserved.
//

#import "ZBHttpManager.h"
#import <AFNetworking/AFNetworking.h>
@implementation ZBHttpManager

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    progress:(void (^)(NSProgress * progress))uploadProgress
     success:(void (^)(NSURLSessionDataTask *task , id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task , NSError * error))failure {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 自定义请求，为JSON格式
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 自定义响应
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    mgr.responseSerializer = responseSerializer;
    
    
      [mgr POST:URLString parameters:parameters progress:nil success:success failure:failure];
}


@end
