//
//  ArtShareContentView.m
//  LWShareView
//
//  Created by LeeWong on 2018/1/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ArtShareContentView.h"
#import "ArtShareCollectionViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIColor+ArtBox.h"
#import "ArtShareButton.h"
#import <Masonry.h>

#define kMargin 10
#define kPadding 15
#define kFooterHeight 30
#define kMinimumInteritemSpacing  10


#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE6PLUS       (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0) // Both orientations


@interface ArtShareContentView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UILabel *shareTipLabel;
@end

@implementation ArtShareContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}


#pragma mark - Build UI

- (void)buildUI
{
    [self.shareTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kPadding);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareTipLabel.mas_bottom).offset(kPadding);
        make.bottom.equalTo(self.mas_bottom).offset(-kPadding);
        make.left.equalTo(self.mas_left).offset(kPadding);
        make.right.equalTo(self.mas_right).offset(-kPadding);
    }];
}

- (void)setMenus:(NSArray *)menus
{
    _menus = menus;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.menus.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.menus[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArtShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArtShareCellReuseIdentifier" forIndexPath:indexPath];
    NSArray *items = [self.menus objectAtIndex:indexPath.section];
    NSDictionary *item = items[indexPath.item];
    [cell.shareBtn setTitle:item[kShareTitle] forState:UIControlStateNormal];
    [cell.shareBtn setImage:[UIImage imageNamed:item[kShareIcon]] forState:UIControlStateNormal];
    @weakify(self)
    [[cell.shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        if (self.shareBtnClickBlock) {
            self.shareBtnClickBlock(indexPath);
        }
    }];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionFooter && indexPath.section == 0) {
        view.backgroundColor = [UIColor clearColor];
        
        UIView *sepline = [[UIView alloc] init];
        [view addSubview:sepline];
        [sepline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view);
            make.centerY.equalTo(view.mas_centerY);
            make.height.equalTo(@(1.0/[UIScreen mainScreen].scale));
        }];
        sepline.backgroundColor = [UIColor colorWithHexString:@"d9d9d9"];
        return view;
    }
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.frame.size.width, kFooterHeight);
}


#pragma mark - Lazy Load

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
        [self addSubview:_collectionView];
        [_collectionView registerClass:[ArtShareCollectionViewCell class] forCellWithReuseIdentifier:@"ArtShareCellReuseIdentifier"];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;
        CGFloat width = (SCREEN_W - kMargin * 2 - kPadding * 2-kMinimumInteritemSpacing*4) / 5.;
        _flowLayout.itemSize = CGSizeMake(width, 74);
        
    }
    return _flowLayout;
}


- (UILabel *)shareTipLabel
{
    if (_shareTipLabel == nil) {
        _shareTipLabel = [[UILabel alloc] init];
        _shareTipLabel.font = [UIFont systemFontOfSize:17];
        _shareTipLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _shareTipLabel.text = @"分享至";
        [self addSubview:_shareTipLabel];
    }
    return _shareTipLabel;
}

@end
