//
//  ViewController.h
//  MVVMDemo
//
//  Created by qiufu on 12/4/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXMainViewModel.h"

@interface CXMainViewController : UIViewController

@property (nonatomic, strong) CXMainViewModel *viewModel;

@end

