//
//  ArtShareButton.m
//  demo
//
//  Created by WangYouming on 15/9/1.
//  Copyright (c) 2015年 cn.apple. All rights reserved.
//

#import "LWShareButton.h"
#import "UIColor+LW.h"

@implementation LWShareButton

- (instancetype)init
{
    if (self = [super init]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:[UIColor colorWithRGBHex:0x999999] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = (contentRect.size.width - 48) * 0.5;
    return CGRectMake(x, 57, 48, 12);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = (contentRect.size.width - 48) * 0.5;
    return CGRectMake(x, 0, 48, 48);
}

@end
