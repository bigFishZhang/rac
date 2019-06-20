//
//  HomeCellViewModel.m
//  MvvmRAC
//
//  Created by bigfish on 2019/6/20.
//  Copyright © 2019 zzb. All rights reserved.
//

#import "HomeCellViewModel.h"
#import "ZBHomeTableViewCell.h"
#import "ZBHomeDataModel.h"

#import <UIImageView+WebCache.h>

@implementation HomeCellViewModel

- (void)bindViewModel:(id)bindView {
    ZBHomeTableViewCell *cell = (ZBHomeTableViewCell *)bindView;
    
    
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:_item.courseImage]];
        cell.nameLabel.text = _item.courseImage;
        [cell.numButton setTitle:_item.studentNum forState:UIControlStateNormal];
    

}


@end
