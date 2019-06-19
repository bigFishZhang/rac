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
#import "FlagItem.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *TestButton;

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
    
//    _TestButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//
//        NSLog(@"  initWithSignalBlock 点击按钮 %@",input);
//
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [subscriber sendNext:@"xxxx"];
//            [subscriber sendCompleted];
//            return  nil;
//        }];
//    }];
//
//    [_TestButton.rac_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"点击了按钮。。。 %@",x);
//    }];
    RACSubject *enableSignal = [RACSubject subject];
    
    _TestButton.rac_command =  [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                NSLog(@"  initWithSignalBlock 点击按钮 %@",input);
        
                return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                    [subscriber sendNext:@"xxxx"];
                    [subscriber sendCompleted];
                    return  nil;
                }];
    }];
    
//    [enableSignal sendNext:@NO];
    
    
    
//    NSLog(@"1 RACSignal *signal");
//    // 创建 RACDynamicSignal
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//        NSLog(@"3 createSignal");
//
//        [subscriber sendNext:@2];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            //订阅者销毁的时候执行
//            //订阅者发送完成或者error 也会执行block
//            //清空数据
//            NSLog(@"5 disposableWithBlock");
//
//        }];
//    }];
//
    
    
//    NSLog(@"2 signal subscribeNext");
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"4 subscribeNext");
//        NSLog(@"subscribeNext thread %@",[NSThread currentThread]);
//    }];
//
//    [signal subscribeError:^(NSError * _Nullable error) {
//        NSLog(@"subscribeError");
//    }];
//    [signal subscribeCompleted:^{
//        NSLog(@"subscribeCompleted");
//    }];
//
//    [signal subscribeNext:^(id  _Nullable x) {
//
//    } error:^(NSError * _Nullable error) {
//
//    } completed:^{
//
//    }];
    
    //racsignal 转
//    RACMulticastConnection *connection = [signal publish];
//
//    [connection.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"connection.signal subscribeNext 1 %@ ",x);
//    }];
//
//    [connection.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"connection.signal subscribeNext 2 %@ ",x);
//    }];
//
    // 进行连接
    //racsubjec 订阅signal
//    [connection connect];
    
    
//    [self test];
//    [self test2];
//    [self test3];
//    [self test4];
    [self test5];
    // Do any additional setup after loading the view.
}


- (void)test {
    
    // 先订阅 再发送信号
    
    NSLog(@"RACSubject 1");
    
    RACSubject *subject = [RACSubject subject];
    
    //生成多个RACSubscriber监听者 放到一个数组中 存储对应的block
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者 %@",x);
        NSLog(@"subscribeNext thread %@",[NSThread currentThread]);
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
        NSLog(@"subscribeNext thread %@",[NSThread currentThread]);
    } error:^(NSError * _Nullable error) {
        NSLog(@"第二个订阅者 %@",error);
         [replaySubject sendCompleted];
    } completed:^{
        NSLog(@"第三订阅者");
    }];
}


- (void)test3 {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *datas = [NSArray arrayWithContentsOfFile:filePath];
    
    
    //遍历数组的时候 block 里面是子线程
    NSMutableArray * items = [[NSMutableArray alloc] init];
    
    [datas.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"datas %@",x);
        NSLog(@"rac_sequence.signal  thread %@",[NSThread currentThread]);
        FlagItem *item = [FlagItem itemWithDict:x];
        [items addObject:item];
    } completed:^{
        NSLog(@"rac_sequence.signal completed thread %@",[NSThread currentThread]);
        //NSLog(@"items %@",items);
    }];
    
   items = [[datas.rac_sequence map:^id _Nullable(id  _Nullable value) {
         NSLog(@"rac_sequence.signal completed thread %@",[NSThread currentThread]);
        return [FlagItem itemWithDict:value];
       
    }] array];
    
     NSLog(@"datas rac_sequence map %@",items);

}

- (void)test4 {
    NSDictionary *dict = @{
                           @"name":@"zzb",
                           @"age" :@18
                           };
    // RACTuple 元祖
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *  _Nullable x) {
        NSLog(@"test4 rac_sequence.signal thread %@",[NSThread currentThread]);
        NSLog(@"items %@",x);
        RACTupleUnpack(NSString *key,id value) = x;
        NSLog(@"key %@",key);
        NSLog(@"value %@",value);
    }];
}




/**
 test raccommand
 */
- (void)test5 {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"initWithSignalBlock %@ ",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            
            
            
            //发送信号给订阅者 =》 RACReplaySubject
            [subscriber sendNext:@"subscriber sendNext"];
            
            [subscriber sendCompleted];
            
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
    NSLog(@"RACCommand execute");
    // 信号中的信号 switchToLatest获取最近发送的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals.switchToLatest x %@",x);
    }];
    
    //执行有没有完成的
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        BOOL isExecuting = [x boolValue];
        if (isExecuting) {
            NSLog(@"正在执行。。。");
        }else{
            NSLog(@"执行完成。。。");
        }
    }];//忽略第一次
   
    
    
    //创建了RACReplaySubject 订阅 initWithSignalBlock 里面返回的信号
    [command execute:@1]; //返回 RACReplaySubject
    
  
    
}
@end
