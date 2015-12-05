//
//  CXMainViewModel.h
//  MVVMDemo
//
//  Created by qiufu on 12/5/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CXMovie.h"
#import "CXMovieCellViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CXMainViewModel : NSObject


@property (nonatomic, strong) RACSignal *dataUpdatedSignal;
@property (nonatomic, strong) RACSignal *errorSignal;

- (NSString *)navigationTitleText;
- (NSInteger)movieCellCount;
- (CXMovieCellViewModel *)movieCellViewModelAtIndexPath:(NSIndexPath *)indexPath;


- (void)refreshViewDataWithParameters:(id)parameters;

@end
