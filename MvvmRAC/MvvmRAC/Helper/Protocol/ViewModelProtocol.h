//
//  ViewModelProtocol.h
//  MvvmRAC
//
//  Created by bigfish on 2019/6/20.
//  Copyright © 2019 zzb. All rights reserved.
//

#ifndef ViewModelProtocol_h
#define ViewModelProtocol_h

@protocol ViewModelProtocol <NSObject>

@optional

- (void)bindViewModel:(id)bindView;

@end

#endif /* ViewModelProtocol_h */
