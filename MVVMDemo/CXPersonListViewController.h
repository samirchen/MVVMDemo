//
//  PersonListViewController.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXPersonListViewModel.h"

@interface CXPersonListViewController : UIViewController
@property (nonatomic, strong) CXPersonListViewModel* model;
@end
