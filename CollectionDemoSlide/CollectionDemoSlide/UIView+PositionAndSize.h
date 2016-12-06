//
//  UIView+PositionAndSize.h
//  shuaidanbao
//
//  Created by sdb on 15/6/9.
//  Copyright (c) 2015年 sdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PositionAndSize)

// 获得view在父视图坐标系中的x值
- (CGFloat) valueOfX;
// 获得view在父视图坐标系中的y值
- (CGFloat) valueOfY;
// 获得view的宽度width值
- (CGFloat) valueOfW;
// 获得view的高度height值
- (CGFloat) valueOfH;
// 获得view的右边距离x轴(父视图坐标系中)的值
- (CGFloat) valueOfRightMargin;
// 获得view的低边距离y轴(父视图坐标系中)的值
- (CGFloat) valueOfBottomMargin;
// 按照比例scale缩放number的值
+ (CGFloat) scaleValueOfNumber:(CGFloat) number scale:(CGFloat) scale;

@end
