//
//  CXGroupEditViewController.h
//  MVVMDemo
//
//  Created by SamirChen on 9/19/14.
//  Copyright (c) 2014 cx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXGroupEditViewModel;

@interface CXGroupEditViewController : UIViewController
@property (nonatomic, strong) CXGroupEditViewModel* model;
@end
