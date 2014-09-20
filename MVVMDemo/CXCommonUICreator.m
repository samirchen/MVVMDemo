//
//  CXCommonUICreator.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-20.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXCommonUICreator.h"

@implementation CXCommonUICreator

#pragma mark - Utility
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - UIButton Creator
+(UIButton*) buttonWithFrame:(CGRect)frame bgColor:(UIColor*)bgColor bgTouchColor:(UIColor*)bgTouchColor bgDisableColor:(UIColor*)bgDisableColor title:(NSString*)title titleColor:(UIColor*)titleColor titleTouchColor:(UIColor*)titleTouchColor target:(id)target andAction:(SEL)action {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setFrame:frame];
    [btn setBackgroundImage:[CXCommonUICreator imageWithColor:bgColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[CXCommonUICreator imageWithColor:bgTouchColor] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[CXCommonUICreator imageWithColor:bgDisableColor] forState:UIControlStateDisabled];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleTouchColor forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:4.];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
    
}

#pragma mark - UITextField Creator
+(UITextField*) textFieldWithRoundedRectBorderWithFrame:(CGRect)frame placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType returnKeyType:(UIReturnKeyType)returnKeyType {
    UITextField* txf = [[UITextField alloc] initWithFrame:frame];
    [txf setBorderStyle:UITextBorderStyleRoundedRect];
    [txf setPlaceholder:placeholder];
    [txf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [txf setKeyboardType:keyboardType];
    [txf setReturnKeyType:returnKeyType];
    [txf setEnablesReturnKeyAutomatically:YES];
    
    return txf;
}


@end
