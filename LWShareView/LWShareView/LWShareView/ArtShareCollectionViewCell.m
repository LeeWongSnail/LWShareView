//
//  ArtShareCollectionViewCell.m
//  DesignBox
//
//  Created by WangYouming on 15/8/31.
//  Copyright (c) 2015年 GK. All rights reserved.
//

#import "ArtShareCollectionViewCell.h"
#import "ArtShareButton.h"
#import <Masonry.h>
@implementation ArtShareCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (ArtShareButton *)shareBtn
{
    if (_shareBtn == nil) {
        ArtShareButton *shareBtn = [[ArtShareButton alloc] init];
        shareBtn.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:shareBtn];
        _shareBtn = shareBtn;
    }
    return _shareBtn;
}

@end
