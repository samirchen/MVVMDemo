//
//  ViewController.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXGroupListViewModel.h"

@interface CXGroupListViewController : UIViewController
@property (nonatomic, strong) CXGroupListViewModel* model;

@end

