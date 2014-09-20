//
//  PersonListViewModel.h
//  MVVMDemo
//
//  Created by XuanChen on 14-9-15.
//  Copyright (c) 2014年 cx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CXGroup;
@class CXPerson;

@interface CXPersonListViewModel : NSObject

@property (nonatomic, strong) CXGroup* group;
@property (nonatomic, readonly) NSArray* persons;
@property (nonatomic) NSInteger numberOfPersons;


-(instancetype) initWithGroup:(CXGroup*)g;

-(CXPerson*) personAtIndex:(NSInteger)index;
-(NSString*) titleForPersonAtIndex:(NSInteger)index;
-(NSString*) subtitleForPersonAtIndex:(NSInteger)index;



@end
