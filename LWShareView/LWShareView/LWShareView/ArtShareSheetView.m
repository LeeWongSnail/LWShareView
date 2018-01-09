//
//  ArtShareSheetView.m
//  LWShareView
//
//  Created by LeeWong on 2018/1/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ArtShareSheetView.h"
#import "UIColor+ArtBox.h"
#import <Masonry.h>

@interface ArtShareSheetView ()
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *shareTipLabel;
@end

@implementation ArtShareSheetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self buildUI];
    }
    return self;
}


- (void)buildUI
{
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.height.equalTo(@50);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.cancelBtn.mas_top).offset(-10);
    }];
    
    [self.shareTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
}

#pragma mark - Lazy Load

- (UILabel *)shareTipLabel
{
    if (_shareTipLabel == nil) {
        _shareTipLabel = [[UILabel alloc] init];
        _shareTipLabel.font = [UIFont systemFontOfSize:17];
        _shareTipLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _shareTipLabel.text = @"分享至";
        [self.contentView addSubview:_shareTipLabel];
    }
    return _shareTipLabel;
}

- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
        _contentView.layer.cornerRadius = 12;
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _cancelBtn.layer.cornerRadius = 12;
        _cancelBtn.layer.masksToBounds = YES;
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

@end
