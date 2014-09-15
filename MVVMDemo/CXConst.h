//
//  CXConst.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#ifndef MVVMDemo_CXConst_h
#define MVVMDemo_CXConst_h

/* Screen Size */
#pragma mark - Screen Size
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height



/* Macro Utils */
#pragma mark - Macro Utils
#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__);
#else
#define debugLog(...)
#define debugMethod()
#endif

#define EMPTY_STRING @""

#define LSTR(key) NSLocalizedString(key, nil)

#define PATH_OF_APP_HOME NSHomeDirectory()
#define PATH_OF_TEMP NSTemporaryDirectory()
#define PATH_OF_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define RGB(A, B, C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]


#endif
