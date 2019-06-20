//
//  ViewController.m
//  MvvmRAC
//
//  Created by bigfish on 2019/6/20.
//  Copyright © 2019 zzb. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>


@interface ViewController ()

/** <#strong属性注释#> */
@property (nonatomic, strong) HomeViewModel *homeViewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [[self.homeViewModel.loadHomedataCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
//        NSLog(@" ==== x  ==== %@",x);
        [self.tableView reloadData];
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
    
    //绑定
    [self.homeViewModel bindViewModel:self.tableView];
}



#pragma mark - LazyLoad
- (HomeViewModel *)homeViewModel {
    if(_homeViewModel == nil) {
        _homeViewModel = [[HomeViewModel alloc] init];
    }
    return _homeViewModel;
}

@end
