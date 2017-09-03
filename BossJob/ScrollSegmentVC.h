//
//  ScrollSegmentVC.h
//  ScrollSegmentBar
//
//  Created by 刘小兵 on 2017/9/1.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SegmentControllerDelegate.h"
#import "SegmentBarHeaderProtocol.h"



/**
 滚动视图中嵌套一个导航栏，向上滑动时，如果这个导航未到达顶部位置，则继续向上滑
 如果已经互过顶部，那么中间可以滚动的视图向上滑
 */
@class SegmentView;

@interface ScrollSegmentVC : BaseViewController

@property(nonatomic, assign) CGFloat segmentHeight;         // 中间标题栏的高度
@property(nonatomic, assign) CGFloat headerHeight;          // 头部高度
@property(nonatomic, assign) CGFloat segmentMiniTopInset;   // 中间标题栏最小高度


@property(nonatomic, assign, readonly) CGFloat segmentTopInset;
@property(nonatomic, assign) BOOL freezenHeaderWhenReachMaxHeaderHeight;


//readonly properties
@property(nonatomic, weak, readonly) UIViewController<SegmentControllerDelegate> *currentDisplayController;

@property(nonatomic, strong, readonly) SegmentView *segmentView;
@property(nonatomic, strong, readonly) UIView<SegmentBarHeaderProtocol> *headerView;



/**
 初始化中间导航栏对应的视图

 @param controller 视图集合。这里采用不定参数
 @return 当前实例对象
 */
- (instancetype)initWithControllers:(UIViewController<SegmentControllerDelegate> *)controller,... NS_REQUIRES_NIL_TERMINATION;


/**
 绑定视图控件器

 @param viewControllers 视图容器
 */
- (void)setViewControllers:(NSArray *)viewControllers;



/**
 获取自定义头部视图

 @return 自定义头部视图
 */
- (UIView<SegmentBarHeaderProtocol>*)customHeaderView;

@end
