//
//  CXConfig.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXConfig.h"

@implementation CXConfig

#pragma mark - Init
-(instancetype) init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(instancetype) initWithConfigKey:(NSString*)key value:(NSString*)value {
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
    }
    
    return self;
}


@end
