//
//  CXGroup.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXGroup : NSObject

// Property
@property (nonatomic) int32_t rowid;
@property (nonatomic, strong) NSString* groupName;
@property (nonatomic, strong) NSString* groupDescription;


// Method
-(instancetype) initWithName:(NSString*)name description:(NSString*)description;

@end
