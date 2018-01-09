//
//  ArtShareContentView.h
//  LWShareView
//
//  Created by LeeWong on 2018/1/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kShareIcon @"kShareIcon"
#define kShareTitle @"kShareTitle"

@interface ArtShareContentView : UIView

//防止按钮的数组 
@property (nonatomic, strong) NSArray *menus;

@property (nonatomic, copy) void (^shareBtnClickBlock)(NSIndexPath *index);

@end
