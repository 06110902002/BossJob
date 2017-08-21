//
//  ViewController.m
//  FlowLabelLayout
//
//  Created by liuxiaobing on 20/08/2017.
//  Copyright © 2017 liuxiaobingliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


//下面这两个方法主要针对 uilabel与uibutton的尺寸自适应

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
