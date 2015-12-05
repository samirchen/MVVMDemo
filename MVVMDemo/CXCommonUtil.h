//
//  CXCommonUtil.h
//  MVVMDemo
//
//  Created by qiufu on 12/4/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CXCommonUtil : NSObject

#pragma mark - UIImage Util
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark - Date Util
+ (NSDateFormatter *)sharedDateFormatter;

#pragma mark - String Util
+ (NSString *)randomStringWithLength:(int32_t)length;


    
@end
