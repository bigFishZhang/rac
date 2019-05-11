//
//  ViewController.m
//  Rac
//
//  Created by bigfish on 2019/5/11.
//  Copyright © 2019 zzb. All rights reserved.
//

#import "ViewController.h"
@import ReactiveObjC;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RACSignal *enableSignal = [[RACSignal combineLatest:@[self.userNameTextField.rac_textSignal,self.passwordTextField.rac_textSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
        return @([value[0] length] > 0 && [value[1] length] > 6);
    }];
    
    self.loginButton.rac_command = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
    
    
//    //信号量设置
//    RACSignal *viewDidAppearSiganl = [self rac_signalForSelector:@selector(viewDidAppear:)];
//
//    [viewDidAppearSiganl subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//        NSLog(@"%s",__func__);
//    }];
//
//
//    //只会执行一次 互斥 subscribeError : subscribeCompleted  =====================
//    [viewDidAppearSiganl subscribeError:^(NSError * _Nullable error) {
//        NSLog(@"%@",error);
//        NSLog(@"%s",__func__);
//    }];
//    [viewDidAppearSiganl subscribeCompleted:^{
//        NSLog(@"%s",__func__);
//    }];
//    //只会执行一次 互斥 subscribeError : subscribeCompleted  =====================
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//
//    //
//    [button setRac_command:[[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            NSLog(@"cliked %s",__func__);
//            //发送消息
//            [subscriber sendNext:[[NSDate date] description]];
//            //结束操作
//            [subscriber sendCompleted];
//
//
//            //RACDisposable回调里处理释放对象  // RACDisposable 在RACSignal释放的时候调用
//            return [RACDisposable disposableWithBlock:^{
//
//            }];
//
//        }];
//
//    }]];
//
//    //获取订阅发送的消息
//    [[[button rac_command] executionSignals] subscribeNext:^(RACSignal<id> * _Nullable x) {
//        NSLog(@"RACSignal x%@",x);
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"subscribeNext %@",x);
//        }];
//    }];
//
//    [button setTitle:@"Test" forState:UIControlStateNormal];
//    [button setBounds:CGRectMake(0, 0, 200, 200)];
//    [button setCenter:self.view.center];
//    [self.view addSubview:button];
    
}


//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSLog(@"%s",__func__);
//}

@end
