//
//  CXPerson.m
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import "CXPerson.h"

@implementation CXPerson

#pragma mark - Init
-(instancetype) init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(instancetype) initWithName:(NSString*)name gender:(Gender)gender groupId:(int32_t)groupId {
    self = [super init];
    if (self) {
        self.personName = name;
        self.gender = gender;
        self.groupId = groupId;
    }
    
    return self;
}




@end
