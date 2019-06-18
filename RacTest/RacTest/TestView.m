//
//  TestView.m
//  RacTest
//
//  Created by bigfish on 2019/6/17.
//  Copyright © 2019 zzb. All rights reserved.
//

#import "TestView.h"

@implementation TestView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_subject sendNext:@3333];
}





@end
