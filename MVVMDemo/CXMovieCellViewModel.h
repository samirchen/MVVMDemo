//
//  CXMovieCellViewModel.h
//  MVVMDemo
//
//  Created by qiufu on 12/5/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CXMovie.h"
@interface CXMovieCellViewModel : NSObject

@property (nonatomic, strong) CXMovie *movie;

// 直接对接 View(ViewController) 层的展示需求。
- (NSURL *)moviePosterURL;
- (NSString *)movieNameText;
- (NSString *)movieReleaseTimeText;

@end
