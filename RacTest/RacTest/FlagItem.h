//
//  FlagItem.h
//  RacTest
//
//  Created by bigfish on 2019/6/18.
//  Copyright © 2019 zzb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlagItem : NSObject

/** <#strong属性注释#> */
@property (nonatomic, strong) NSString *name;
/** <#strong属性注释#> */
@property (nonatomic, strong) NSString *icon;


+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
