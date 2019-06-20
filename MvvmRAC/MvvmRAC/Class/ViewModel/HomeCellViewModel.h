//
//  HomeCellViewModel.h
//  MvvmRAC
//
//  Created by bigfish on 2019/6/20.
//  Copyright © 2019 zzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@class ZBHomeDataModel;
@interface HomeCellViewModel : NSObject<ViewModelProtocol>


/** <#strong属性注释#> */
@property (nonatomic, strong) ZBHomeDataModel *item;

@end

NS_ASSUME_NONNULL_END
