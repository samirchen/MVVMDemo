//
//  CXConfig.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXConfig : NSObject

// Property
@property (nonatomic) int32_t rowid;
@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) NSString* value;


// Method
-(instancetype) initWithConfigKey:(NSString*)key value:(NSString*)value;

@end
