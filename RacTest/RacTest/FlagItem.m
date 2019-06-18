//
//  FlagItem.m
//  RacTest
//
//  Created by bigfish on 2019/6/18.
//  Copyright © 2019 zzb. All rights reserved.
//

#import "FlagItem.h"

@implementation FlagItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    FlagItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
@end
