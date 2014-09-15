//
//  CXPerson.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-14.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int32_t, Gender) {
    GenderMale = 0,
    GenderFemale
};

@interface CXPerson : NSObject

// Property
@property (nonatomic) int32_t rowid;
@property (nonatomic, strong) NSString* personName;
@property (nonatomic) enum Gender gender;
@property (nonatomic) int32_t groupId;

// Method
-(instancetype) initWithName:(NSString*)name gender:(Gender)gender groupId:(int32_t)groupId;

@end


