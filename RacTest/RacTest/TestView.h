//
//  TestView.h
//  RacTest
//
//  Created by bigfish on 2019/6/17.
//  Copyright © 2019 zzb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>


@interface TestView : UIView

/** <#strong属性注释#> */
@property (nonatomic, strong) RACSubject *subject;

@end


