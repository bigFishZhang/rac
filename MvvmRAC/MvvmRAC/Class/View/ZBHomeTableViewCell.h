//
//  ZBHomeTableViewCell.h
//  MvvmRAC
//
//  Created by bigfish on 2019/6/20.
//  Copyright © 2019 zzb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBHomeTableViewCell : UITableViewCell
//@property (weak, nonatomic, readonly) IBOutlet UIImageView *iconView;
//@property (weak, nonatomic, readonly) IBOutlet UILabel *nameView;
//@property (weak, nonatomic, readonly) IBOutlet UIButton *numView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *numButton;

@end

NS_ASSUME_NONNULL_END
