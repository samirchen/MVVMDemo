//
//  CXGroup.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXGroup.h"

@implementation CXGroup

#pragma mark - Init
-(instancetype) init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(instancetype) initWithName:(NSString*)name description:(NSString*)description {
    self = [super init];
    if (self) {
        self.groupName = name;
        self.groupDescription = description;
    }
    
    return self;
}





@end
