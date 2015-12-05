//
//  CXMovieTableViewCell.m
//  MVVMDemo
//
//  Created by qiufu on 12/4/15.
//  Copyright © 2015 CX. All rights reserved.
//

#import "CXMovieTableViewCell.h"
#import <Masonry/Masonry.h>
#import "CXCommonUtil.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CXMovieTableViewCell ()
@property (nonatomic, strong) UIImageView *posterImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *releaseTimeLabel;
@end


@implementation CXMovieTableViewCell

#pragma mark - Property
- (UIImageView *)posterImageView {
    if (!_posterImageView) {
        _posterImageView = [[UIImageView alloc] initWithImage:[CXCommonUtil imageWithColor:[UIColor whiteColor]] highlightedImage:[CXCommonUtil imageWithColor:[UIColor grayColor]]];
        
    }
    
    return _posterImageView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel  = [[UILabel alloc] init];
        [_nameLabel setTextAlignment:NSTextAlignmentLeft];
        [_nameLabel setTextColor:[UIColor blackColor]];
        [_nameLabel setFont:[UIFont systemFontOfSize:20]];
        
        _nameLabel.text = @"The Shawshank Redemption";

    }
    
    return _nameLabel;
}

- (UILabel *)releaseTimeLabel {
    if (!_releaseTimeLabel) {
        _releaseTimeLabel  = [[UILabel alloc] init];
        [_releaseTimeLabel setTextAlignment:NSTextAlignmentLeft];
        [_releaseTimeLabel setTextColor:[UIColor brownColor]];
        [_releaseTimeLabel setFont:[UIFont systemFontOfSize:14]];
        
        _releaseTimeLabel.text = @"1994-09-23";
    }
    
    return _releaseTimeLabel;
}




#pragma mark - Lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        // Poster image view.
        [self addSubview:self.posterImageView];
        [self.posterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        // Name label.
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(10);
            make.centerX.equalTo(self);
        }];
        
        // Release time label.
        [self addSubview:self.releaseTimeLabel];
        [self.releaseTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(10);
            make.centerX.equalTo(self);
        }];
        
        // Shadow line.
        UIView *shadowView = [[UIView alloc] init];
        [shadowView setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        [self addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@5);
            make.width.equalTo(self);
        }];
        
        
        // Data binding.
        typeof(self) __weak weakSelf = self;
        [RACObserve(weakSelf, viewModel) subscribeNext:^(id x) {
            [weakSelf.posterImageView setImage:[CXCommonUtil imageWithColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]]];
            weakSelf.nameLabel.text = [weakSelf.viewModel movieNameText];
            weakSelf.releaseTimeLabel.text = [weakSelf.viewModel movieReleaseTimeText];
        }];

        
    }
 
    return self;
}


#pragma mark - Utility
+ (CGFloat)heightForModel:(id)model atIndexPath:(NSIndexPath *)indexPath {
    return 80;
}



@end
