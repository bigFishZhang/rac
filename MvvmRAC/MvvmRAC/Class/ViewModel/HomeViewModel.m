//
//  HomeViewModel.m
//  MvvmRAC
//
//  Created by bigfish on 2019/6/20.
//  Copyright © 2019 zzb. All rights reserved.
//

#import "HomeViewModel.h"
#import "ZBHttpManager.h"
#import "ZBHomeDataModel.h"
#import "ZBHomeTableViewCell.h"
#import "HomeCellViewModel.h"
#import "MD5.h"

#import <MJExtension/MJExtension.h>
static NSString * const ID = @"home";
static NSString * const salt = @"gn1002015";

/*** MD5 ***/

#define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */
#define CC_MD5_BLOCK_BYTES      64          /* block size in bytes */
#define CC_MD5_BLOCK_LONG       (CC_MD5_BLOCK_BYTES / sizeof(CC_LONG))



@interface HomeViewModel ()<UITableViewDelegate,UITableViewDataSource>

/** <#strong属性注释#> */
@property (nonatomic, strong) NSArray *cellViewArray;

@end

@implementation HomeViewModel

- (RACCommand *)loadHomedataCommand {
    @weakify(self);
    if (_loadHomedataCommand == nil) {
        _loadHomedataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               
                NSString *url = @"https://www.yunke.com/interface/main/home";
                NSDictionary *param = [self paramWithHome];
                [ZBHttpManager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                    @strongify(self);
                    NSDictionary *result = responseObject[@"result"];
                    
                    NSDictionary *recommendsDict = result[@"recommends"];
                    NSArray *recommends;
                    // 字段转模型
                    recommends = [ZBHomeDataModel mj_objectArrayWithKeyValuesArray:recommendsDict[@"courses"]];
                    
                    NSLog(@" ==== x  ==== %@",recommends);
                    
                    self.cellViewArray = [[recommends.rac_sequence map:^id _Nullable(id  _Nullable value) {
                        
                        HomeCellViewModel *cellViewModel = [[HomeCellViewModel alloc] init];
                        cellViewModel.item = value;
                        return cellViewModel;
                        
                    }] array];
                    
                    [subscriber sendNext:recommends];
                    [subscriber sendCompleted];
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                
                return nil;
            }];
        }];
        
    }
    return _loadHomedataCommand;

}


#pragma mark - tabelview





- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ZBHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    HomeCellViewModel *cellViewModel = self.cellViewArray[indexPath.row];
    [cellViewModel bindViewModel:cell];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellViewArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - 绑定视图模型
- (void)bindViewModel:(id)bindView {
    UITableView *tableView = (UITableView *)bindView;
    [tableView registerNib:[UINib nibWithNibName:@"ZBHomeTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
    tableView.delegate = self;
    tableView.dataSource = self;
}


- (NSDictionary *)paramWithHome
{
    NSDictionary * params = @{@"city":@"中国",
                              @"cityId":@0,
                              //                              @"condition":userDict[@"condition"],
                              @"condition":@"35,33,32,35,34",
                              //                              @"teacherSeach":userDict[@"teacherSeach"],
                              @"teacherSeach":@"1000,1000,1000"
                              };
    NSString *version = [self Version];
    
    //   获取当前的时间
    int liTime = [self getDateByInt];
    NSString *keymd5 = [self md5ForParamas:params time:liTime];
    NSDictionary *myparamses =@{
                                @"u":@"i",
                                @"v":version,
                                @"time":@(liTime),
                                @"params":params,
                                @"key":keymd5
                                //                                @"dinfo":[self getDinfo]
                                };
    //    NSLog(@"%@",myparamses);
    
    return myparamses;
}

// Version
- (NSString *)Version {
    
    NSString *string = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:string];
    NSString *version = [dic objectForKey:@"CFBundleVersion"];
    return version;
    
}

// 参数md5 key值
- (NSString *)md5ForParamas:(NSDictionary *)paramas time:(int) aiTime
{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramas options:NSJSONReadingAllowFragments error:nil];
    // NSJSONReadingAllowFragments : 使用这个
    // NSJSONWritingPrettyPrinted 会有\n，不需要
    NSString *jsonParserString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSString *myString = [NSString stringWithFormat:@"%@%d%@",jsonParserString,aiTime, salt];
    
    NSString *keyMD5 = [MD5 MD5ForLower32Bate:myString];
    NSString *keymd5 =  [MD5 MD5ForLower32Bate:keyMD5];
    
    
    return keymd5;
}



// 获取当前时间
- (int)getDateByInt
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormat dateFromString:[dateFormat stringFromDate:[NSDate date]]];
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    int liDate = (int) dateInterval;
    return liDate;
}

@end
