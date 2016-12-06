//
//  UIView+PositionAndSize.m
//  shuaidanbao
//
//  Created by sdb on 15/6/9.
//  Copyright (c) 2015年 sdb. All rights reserved.
//

#import "UIView+PositionAndSize.h"

@implementation UIView (PositionAndSize)

// 获得view在父视图坐标系中的x值
- (CGFloat) valueOfX
{
    return self.frame.origin.x;
}
// 获得view在父视图坐标系中的y值
- (CGFloat) valueOfY
{
    return self.frame.origin.y;
}
// 获得view的宽度width值
- (CGFloat) valueOfW
{
    return self.frame.size.width;
}
// 获得view的高度height值
- (CGFloat) valueOfH
{
    return self.frame.size.height;
}
// 获得view的右边距离x轴(父视图坐标系中)的值
- (CGFloat) valueOfRightMargin
{
    return self.frame.origin.x + self.frame.size.width;
}
// 获得view的低边距离y轴(父视图坐标系中)的值
- (CGFloat) valueOfBottomMargin
{
    return self.frame.origin.y + self.frame.size.height;
}
// 按照比例scale缩放number的值
+ (CGFloat) scaleValueOfNumber:(CGFloat) number scale:(CGFloat) scale
{
    scale = scale > 1.0 ? 1.0 : scale;
    return number * scale;
}

@end
