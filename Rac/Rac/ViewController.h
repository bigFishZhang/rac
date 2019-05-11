//
//  ViewController.h
//  Rac
//
//  Created by bigfish on 2019/5/11.
//  Copyright © 2019 zzb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *RTextField;
@property (weak, nonatomic) IBOutlet UITextField *GTextField;
@property (weak, nonatomic) IBOutlet UITextField *BTextField;
@property (weak, nonatomic) IBOutlet UISlider *RSlider;
@property (weak, nonatomic) IBOutlet UISlider *GSlider;
@property (weak, nonatomic) IBOutlet UISlider *BSlider;
@property (weak, nonatomic) IBOutlet UIView *showView;

@end

