//
//  HomeViewModel.h
//  MvvmRAC
//
//  Created by bigfish on 2019/6/20.
//  Copyright © 2019 zzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject<ViewModelProtocol>
{
    RACCommand *_loadHomedataCommand;
}

/** <#strong属性注释#> */
@property (nonatomic, strong,readonly) RACCommand *loadHomedataCommand;

@end

NS_ASSUME_NONNULL_END
