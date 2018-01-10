//
//  ArtShareService.m
//  LWShareView
//
//  Created by LeeWong on 2018/1/10.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ArtShareService.h"
#import "ArtShareSheetView.h"
#import <Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>



@interface ArtShareService ()
@property (nonatomic, strong) ArtShareSheetView *sheetView;
@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation ArtShareService
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static ArtShareService* service;
    dispatch_once(&onceToken, ^{
        service = [[ArtShareService alloc] init];
    });
    return service;
}

- (void)showInViewController:(UIViewController *)viewController
{
    [self showShareSheetView:viewController];
}

- (void)showShareSheetView:(UIViewController *)viewController
{
    if (self.isShowing) {return;}
    self.isShowing = YES;
    UIWindow *keyWindow = viewController.view.window;
    NSLog(@"%@",NSStringFromCGRect(keyWindow.frame));
    
    // 添加maskView
    UIView *maskView = [[UIView alloc] init];
    [keyWindow addSubview:maskView];
    self.maskView = maskView;
    maskView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow);
    }];
    
    [maskView layoutIfNeeded];
    NSLog(@"%@",NSStringFromCGRect(maskView.frame));
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSheetView)];
    [maskView addGestureRecognizer:tap];
    
    ArtShareSheetView *shareSheetView = [[ArtShareSheetView alloc] init];
    [viewController.view.window addSubview:shareSheetView];
    self.sheetView = shareSheetView;
    self.sheetView.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width-20, 314);
    CGRect frame = self.sheetView.frame;
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGFloat y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.sheetView.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
    
    self.sheetView.shareBtnClickBlock = ^(NSIndexPath *index) {
        NSLog(@"%@",index);
    };
    @weakify(self)
    [[self.sheetView.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self hideSheetView];
    }];
}

- (void)hideSheetView
{
    CGRect frame = self.sheetView.frame;
    [UIView animateWithDuration:0.61 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGFloat y = [UIScreen mainScreen].bounds.size.height ;
        self.sheetView.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        [self.sheetView removeFromSuperview];
        self.sheetView = nil;
        self.isShowing = NO;
        [self.maskView removeFromSuperview];
    }];
}


#pragma mark - Lazy Load

- (ArtShareSheetView *)sheetView
{
    if (_sheetView == nil) {
        _sheetView = [[ArtShareSheetView alloc] init];
        
    }
    return _sheetView;
}
@end
