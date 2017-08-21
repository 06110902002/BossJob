//
//  UILabel+LabelHeightAndWidth.h
//  BossJob
//
//  Created by liuxiaobing on 19/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 本分类主要处理文本的尺寸自适应
 */
@interface UILabel (LabelHeightAndWidth)



/**
 类方法，根据宽度，计算高度

 @param width 输入宽度
 @param title 文本内容
 @param font 字体属性
 @return 计算后的高度
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;



/**
 根据文本内容计算宽度

 @param title 文本内容
 @param font 字体属性
 @return 计算后的宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;


@end
