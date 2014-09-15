//
//  CXDBManager.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXDBManager : NSObject

@property (nonatomic, strong, readonly) NSString* dbFilePath;

#pragma mark - Shared Instance
+(CXDBManager*) sharedInstance;

#pragma mark - CXDBManager
-(void) initDB; // When first start app.

@end
