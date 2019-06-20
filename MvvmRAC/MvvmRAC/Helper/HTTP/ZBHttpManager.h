//
//  ZBHttpManager.h
//  MvvmRAC
//
//  Created by bigfish on 2019/6/20.
//  Copyright © 2019 zzb. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZBHttpManager : NSObject
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    progress:(void (^)(NSProgress * progress))uploadProgress
     success:(void (^)(NSURLSessionDataTask *task , id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task , NSError * error))failure;

@end

