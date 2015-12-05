//
//  CXMovieCellViewModel.m
//  MVVMDemo
//
//  Created by qiufu on 12/5/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import "CXMovieCellViewModel.h"
#import "CXCommonUtil.h"

@implementation CXMovieCellViewModel

- (NSURL *)moviePosterURL {
    return [NSURL URLWithString:self.movie.posterImageURL];
}

- (NSString *)movieNameText {
    return self.movie.name;
}

- (NSString *)movieReleaseTimeText {
    return [[CXCommonUtil sharedDateFormatter] stringFromDate:self.movie.releaseTime];
}


@end
