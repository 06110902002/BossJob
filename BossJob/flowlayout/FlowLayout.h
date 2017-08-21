//
//  ViewController.m
//  FlowLabelLayout
//
//  Created by liuxiaobing on 20/08/2017.
//  Copyright © 2017 liuxiaobingliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@interface FlowLayout : UIView

@property(nonatomic,assign) CGFloat rowMargin;
@property(nonatomic,assign) CGFloat colMargin;



/**
 *  存放需要显示的button
 */
@property (nonatomic, strong) NSMutableArray *buttonList;

/**
 *  通过传入一组按钮初始化CFFlowButtonView,上接口对外开放
 *
 *  @param buttonList 按钮数组
 *
 *  @return CFFlowButtonView对象
 */
- (instancetype)initWithButtonList:(NSMutableArray *)buttonList;


/**
 按钮点击回调
 */
@property (nonatomic, copy) void (^onClickBlock)(UIButton* button,NSInteger idx);

@end
