//
//  CXMovieTableViewCell.h
//  MVVMDemo
//
//  Created by qiufu on 12/4/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXMovieCellViewModel.h"

@interface CXMovieTableViewCell : UITableViewCell

/**
 *  Cell view model.
 */
@property (nonatomic, strong) CXMovieCellViewModel *viewModel;

/**
 *  Calculate cell height with specified view model and index path. Cache cell height is recommended.
 *
 *  @param model     Cell view model.
 *  @param indexPath Cell index path.
 *
 *  @return Cell height.
 */
+ (CGFloat)heightForModel:(CXMovieCellViewModel *)model atIndexPath:(NSIndexPath *)indexPath;

@end
