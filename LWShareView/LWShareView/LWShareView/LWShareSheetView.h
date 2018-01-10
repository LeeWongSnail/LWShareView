//
//  ArtShareSheetView.h
//  LWShareView
//
//  Created by LeeWong on 2018/1/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWShareSheetView : UIView
@property (nonatomic, copy) void (^shareBtnClickBlock)(NSIndexPath *index);
@property (nonatomic, strong) UIButton *cancelBtn;

+ (NSInteger)sectionCount;
@end
