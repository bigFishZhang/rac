//
//  ViewController.m
//  RacTest
//
//  Created by bigfish on 2019/6/14.
//  Copyright © 2019 zzb. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface ViewController ()

@end

@implementation ViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestView *testView = [[TestView alloc] init];
    testView.backgroundColor = [UIColor redColor];
    testView.frame = CGRectMake(10, 10, 200, 200);
    [self.view addSubview:testView];
    RACSubject *subject = [RACSubject subject] ;
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribeNext %@",x);
    }];
    testView.subject = subject;
    
    
    
    
    
    
    
    
    
    
    NSLog(@"1 RACSignal *signal");
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"3 createSignal");
        
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            //订阅者销毁的时候执行
            //订阅者发送完成或者error 也会执行block
            //清空数据
            NSLog(@"5 disposableWithBlock");
        }];
    }];
    
    
    
    NSLog(@"2 signal subscribeNext");
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"4 subscribeNext");
    }];
    
    [signal subscribeError:^(NSError * _Nullable error) {
        NSLog(@"subscribeError");
    }];
    [signal subscribeCompleted:^{
        NSLog(@"subscribeCompleted");
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    } completed:^{
        
    }];
    
    
    [self test];
    
    // Do any additional setup after loading the view.
}


- (void)test {
    
    // 先订阅 再发送信号
    
    NSLog(@"RACSubject 1");
    
    RACSubject *subject = [RACSubject subject];
    
    //生成多个RACSubscriber监听者 放到一个数组中 存储对应的block
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者 %@",x);
        [subject sendCompleted];
    } error:^(NSError * _Nullable error) {
        NSLog(@"第二个订阅者 %@",error);
    } completed:^{
        NSLog(@"第三订阅者");
    }];
    //遍历数组发送消息
    [subject sendNext:@2];
    NSLog(@"RACSubject 2");
}

- (void)test2 {
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    
    // 先保存 再执行nextblock
    [replaySubject sendNext:@"hello 123"];
    NSError *err ;
    
    [replaySubject sendError:err];
    
    
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者 %@",x);
       
    } error:^(NSError * _Nullable error) {
        NSLog(@"第二个订阅者 %@",error);
         [replaySubject sendCompleted];
    } completed:^{
        NSLog(@"第三订阅者");
    }];
}


@end
