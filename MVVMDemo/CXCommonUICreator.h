//
//  CXCommonUICreator.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-20.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CXCommonUICreator : NSObject

#pragma mark - UIButton Creator
+(UIButton*) buttonWithFrame:(CGRect)frame bgColor:(UIColor*)bgColor bgTouchColor:(UIColor*)bgTouchColor bgDisableColor:(UIColor*)bgDisableColor title:(NSString*)title titleColor:(UIColor*)titleColor titleTouchColor:(UIColor*)titleTouchColor target:(id)target andAction:(SEL)action;

#pragma mark - UITextField Creator
+(UITextField*) textFieldWithRoundedRectBorderWithFrame:(CGRect)frame placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType;
@end
