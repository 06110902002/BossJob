//
//  ScrollNavBar.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/29.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 滑动导航栏点击时切换页面监听协议接口
 */
@protocol ScrollNavBarChangeListener <NSObject>

@optional
-(void) onChangeListener:(NSInteger) index;

@end

/**
 滑动的导航条
 */
@interface ScrollNavBar : UIView<CAAnimationDelegate>

// 滑动导航栏点击时切换页面监听事件
@property(nonatomic,weak) id<ScrollNavBarChangeListener> delegate;


@property(nonatomic,strong) UIView* bottomLine;

@property(nonatomic,strong) NSMutableArray* titleList;
@property(nonatomic,strong) NSMutableArray* btnList;

@property(nonatomic,assign) double itemWidth;

@property(nonatomic,strong) CABasicAnimation *moveAnimation;

@property(nonatomic,assign) NSInteger nCurIndex;

@property(nonatomic,assign) NSInteger nSegmentCurIndex;

@property(nonatomic,strong) UIScrollView* segmentScroll;




/**
 初始化标题
 
 @param titles 标题列表
 */
-(void)iniTitles:(NSMutableArray*) titles;

/**
 添加中间滚动视图到列表中，这个视图的个数应该与标题一一对应，超过的部分直接忽略

 @param views 中间视图容器
 */
-(void)initSegmentView:(NSMutableArray*) views;


/**
 更新标题栏状态
 
 @param idx 更新的索引
 */
-(void)updateTitleBtnStatus:(NSInteger) idx;

@end
