//
//  ScrollSegmentVC.m
//  ScrollSegmentBar
//
//  Created by 刘小兵 on 2017/9/1.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ScrollSegmentVC.h"
#import "SegmentView.h"
#import "SegmentHeadView.h"
#import "ScrollNavBar.h"
#import "ComAbstractView.h"


#import "HasCheckMeView.h"


const void *_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET = &_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET;
const void *_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWINSET = &_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWINSET;

@interface ScrollSegmentVC ()<ScrollNavBarChangeListener,UIScrollViewDelegate>

@property(nonatomic, strong)
UIView<SegmentBarHeaderProtocol> *headerView;
@property(nonatomic, strong) SegmentView *segmentView;
@property(nonatomic, strong) NSMutableArray *controllers;
@property(nonatomic, assign) CGFloat segmentTopInset;
@property(nonatomic, weak)
UIViewController<SegmentControllerDelegate> *currentDisplayController;

@property(nonatomic, strong) NSLayoutConstraint *headerHeightConstraint;

@property(nonatomic, strong) NSHashTable *hasShownControllers;

@property(nonatomic, assign) BOOL ignoreOffsetChanged;              //是否忽略offset的改变

@property(nonatomic, assign) CGFloat originalTopInset;              //中间滚动视图距离屏幕顶端的间距

//测试使用UIIVew的相关对象
@property(nonatomic,strong) ScrollNavBar* segNavBarView;

@property(nonatomic,strong) ComAbstractView* comAbstractView;
@property(nonatomic,strong) HasCheckMeView* chkMeView2;



@property(nonatomic,strong) UIScrollView* segmentScroll;
@property(nonatomic,strong) UITableView* mCurDisplayView;

@end

@implementation ScrollSegmentVC

#pragma mark - life cycle methods

- (instancetype)initWithControllers:(UIViewController<SegmentControllerDelegate> *)controller, ... {
    self = [super init];
    if (self) {
        
        NSAssert(controller != nil, @"the first controller must not be nil!");
        
        [self _setUp];
        
        UIViewController<SegmentControllerDelegate> *eachController;
        
        va_list argumentList;
        if (controller) {
            
            [self.controllers addObject:controller];
            va_start(argumentList, controller);
            
            while ((eachController = va_arg(argumentList, id))) {
                
                [self.controllers addObject:eachController];
            }
            
            va_end(argumentList);
        }
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self _setUp];
        
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _setUp];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initConstraint];
}

#pragma mark - public methods

- (void)setViewControllers:(NSArray *)viewControllers {
    
    [self.controllers removeAllObjects];
    [self.controllers addObjectsFromArray:viewControllers];
}

#pragma mark - override methods

- (UIView<SegmentBarHeaderProtocol> *)customHeaderView {
    return [[SegmentHeadView alloc] init];
}

#pragma mark - private methdos
//初始化默认值
- (void)_setUp {
    
    self.ignoreOffsetChanged = NO;
    self.headerHeight = 0;
    self.segmentHeight = 44;
    self.segmentTopInset = 0;
    self.segmentMiniTopInset = 0;
    self.controllers = [NSMutableArray array];
    self.hasShownControllers = [NSHashTable weakObjectsHashTable];
}

//private method---初始化视图对象
- (void) initView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    //添加头部
    self.headerView = [self customHeaderView];
    self.headerView.clipsToBounds = YES;
    [self.view addSubview:self.headerView];
}

//private method----初始化随着滑动变化的约束，
//滑动中间的滚动视图能够发生位置变化，主要也是通过更新约束实现的
- (void)initConstraint {
    
    //初始头部视图的约束
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.headerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.headerView
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:0
                                                              multiplier:1
                                                                constant:self.headerHeight];
    
    [self.headerView addConstraint:self.headerHeightConstraint];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:0]];
    
    //测试使用uiView作中间导航视图
    self.segNavBarView = [[ScrollNavBar alloc] initWithFrame:CGRectMake(0.0f, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSMutableArray* title = [NSMutableArray arrayWithObjects:@"公司概况",@"热招职位", nil];
    self.segNavBarView.delegate = self; //滑动监听事件
    [self.segNavBarView registerBrodcast];
    [self.segNavBarView iniTitles:title];
    
    
    //看过我的
    self.comAbstractView = [[ComAbstractView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.comAbstractView.separatorInset = UIEdgeInsetsMake(0,10,0,10);  //top left right down
    self.comAbstractView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];  //删除底部多余行，及分割线
    //self.chkMeView.tag = 23;
    self.segmentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 42.5, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.segmentScroll.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT);
    self.segmentScroll.alwaysBounceHorizontal = YES;
    self.segmentScroll.pagingEnabled = YES;
    self.segmentScroll.delegate = self;
    [self.segmentScroll addSubview:self.comAbstractView];
    
    
    self.chkMeView2 = [[HasCheckMeView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _originalTopInset = self.headerHeight + self.segmentHeight;
    // 针对屏幕底部存在tabBar的情况
    CGFloat bottomInset = 0;
    if (self.tabBarController.tabBar.hidden == NO) {
        bottomInset = CGRectGetHeight(self.tabBarController.tabBar.bounds);
    }
    [self.chkMeView2 setContentInset:UIEdgeInsetsMake(_originalTopInset, 0, bottomInset, 0)];  //设置可滑动的尺寸 上 左 下 右
    [self.segmentScroll addSubview:self.chkMeView2];
    
    
    [self.view insertSubview:self.segmentScroll atIndex:0];
    
    [self.view addSubview:self.segNavBarView];
    
    self.segNavBarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segNavBarView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.segNavBarView
                              attribute:NSLayoutAttributeRight
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeRight
                              multiplier:1
                              constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.segNavBarView
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.headerView
                              attribute:NSLayoutAttributeBottom
                              multiplier:1
                              constant:0]];
    
    [self.segNavBarView addConstraint:[NSLayoutConstraint
                                       constraintWithItem:self.segNavBarView
                                       attribute:NSLayoutAttributeHeight
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:nil
                                       attribute:0
                                       multiplier:1
                                       constant:self.segmentHeight]];
    
    
    self.mCurDisplayView = self.comAbstractView;
    
    [self initScrollViewConstraint:self.segmentScroll];
    [self addObserverForTableView:self.comAbstractView];
}


/**
 布局toolbar对应的UIViewController
 
 @param pageController 待布局的UIViewController
 */
//- (void)initScrollConstraint:(UIViewController<SegmentControllerDelegate> *)pageController {
//    
//    //获取pageController控件中能够滚动的视图
//    //类似的对应关系为： 如果是UItableViewControll----UItableView   UIConllectViewControler---UIconllectView
//    UIView *pageView = pageController.view;
//    if ([pageView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        pageView.preservesSuperviewLayoutMargins = YES;
//    }
//    
//    pageView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:pageView
//                              attribute:NSLayoutAttributeLeading
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeLeading
//                              multiplier:1
//                              constant:0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:pageView
//                              attribute:NSLayoutAttributeTrailing
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeTrailing
//                              multiplier:1
//                              constant:0]];
//    
//    //获取pageController控件中能够滚动的视图
//    UIScrollView *scrollView = [self scrollViewInPageController:pageController];
//    if (scrollView) {
//        
//        scrollView.alwaysBounceVertical = YES;
//        _originalTopInset = self.headerHeight + self.segmentHeight;
//        
//        // 针对屏幕底部存在tabBar的情况
//        CGFloat bottomInset = 0;
//        if (self.tabBarController.tabBar.hidden == NO) {
//            bottomInset = CGRectGetHeight(self.tabBarController.tabBar.bounds);
//        }
//        
//        [scrollView setContentInset:UIEdgeInsetsMake(_originalTopInset, 0, bottomInset, 0)];  //设置可滑动的尺寸 上 左 下 右
//        
//        //     fixed first time don't show header view
//        //        if (![self.hasShownControllers containsObject:pageController]) {
//        //            [self.hasShownControllers addObject:pageController];
//        //            [scrollView setContentOffset:CGPointMake(0, -self.headerHeight - self.segmentHeight)];
//        //        }
//        
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
//                                                              attribute:NSLayoutAttributeTop
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.view
//                                                              attribute:NSLayoutAttributeTop
//                                                             multiplier:1
//                                                               constant:0]];
//        
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
//                                                              attribute:NSLayoutAttributeBottom
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.view
//                                                              attribute:NSLayoutAttributeBottom
//                                                             multiplier:1
//                                                               constant:0]];
//    } else {    //处理控件中不存在UIScrollView的情况
//        
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
//                                                              attribute:NSLayoutAttributeTop
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.segmentView
//                                                              attribute:NSLayoutAttributeBottom
//                                                             multiplier:1
//                                                               constant:0]];
//        
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
//                                                              attribute:NSLayoutAttributeHeight
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.view
//                                                              attribute:NSLayoutAttributeHeight
//                                                             multiplier:1
//                                                               constant:-self.segmentHeight]];
//    }
//}


/**
 获取指定UIViewController 的滚动视图 UIScrollView
 
 @param controller 待获取的UIViewController
 @return UIScrollView
 */
//- (UIScrollView *)scrollViewInPageController:(UIViewController<SegmentControllerDelegate> *)controller {
//    
//    if ([controller respondsToSelector:@selector(streachScrollView)]) {
//        
//        return [controller streachScrollView];
//        
//    } else if ([controller.view isKindOfClass:[UIScrollView class]]) {
//        
//        return (UIScrollView *)controller.view;     //处理只有UIScrollViewController情况
//        
//    } else {
//        
//        return nil;
//    }
//    
//}

#pragma mark - add / remove obsever for page scrollView

/**
 添加观察滚动视图的内容偏移的变化
 
 @param controller 待观察中的UIViewController 中滚动视图
 */
//- (void)addObserverForPageController:(UIViewController<SegmentControllerDelegate> *)controller {
//    
//    UIScrollView *scrollView = [self scrollViewInPageController:controller];
//    if (scrollView != nil) {
//        [scrollView addObserver:self
//                     forKeyPath:NSStringFromSelector(@selector(contentOffset))
//                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
//                        context:&_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET];
//        
//        [scrollView addObserver:self
//                     forKeyPath:NSStringFromSelector(@selector(contentInset))
//                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
//                        context:&_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWINSET];
//    }
//}
//
//- (void)removeObseverForPageController:(UIViewController<SegmentControllerDelegate> *)controller {
//    
//    UIScrollView *scrollView = [self scrollViewInPageController:controller];
//    if (scrollView != nil) {
//        @try {
//            [scrollView removeObserver:self
//                            forKeyPath:NSStringFromSelector(@selector(contentOffset))];
//            
//            [scrollView removeObserver:self
//                            forKeyPath:NSStringFromSelector(@selector(contentInset))];
//        } @catch (NSException *exception) {
//            NSLog(@"exception is %@", exception);
//        } @finally {
//        }
//    }
//}

#pragma mark - obsever delegate methods


/**
 观察滚动视图的内容偏移的变化，内容变化时作相应的逻辑动作
 
 @param keyPath 观察的键值
 @param object 观察对象
 @param change 改变的值
 @param context 上下文
 */
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if (context == _ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET && !_ignoreOffsetChanged) {
        
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        CGFloat offsetY = offset.y;
        
        CGPoint oldOffset = [change[NSKeyValueChangeOldKey] CGPointValue];
        CGFloat oldOffsetY = oldOffset.y;
        
        CGFloat deltaOfOffsetY = offset.y - oldOffsetY;
        
        CGFloat offsetYWithSegment = offset.y + self.segmentHeight;
        
        if (deltaOfOffsetY > 0 && offsetY >= -(self.headerHeight + self.segmentHeight)) {
            // 当滑动是向上滑动时且不是回弹
            // 跟随移动的偏移量进行变化
            // NOTE:直接相减有可能constant会变成负数，进而被系统强行移除，导致header悬停的位置错乱或者crash
            if (self.headerHeightConstraint.constant - deltaOfOffsetY <= 0) {
                
                self.headerHeightConstraint.constant = self.segmentMiniTopInset;
                
            } else {
                
                self.headerHeightConstraint.constant -= deltaOfOffsetY;
            }
            // 如果到达顶部固定区域，那么不继续滑动
            if (self.headerHeightConstraint.constant <= self.segmentMiniTopInset) {
                
                self.headerHeightConstraint.constant = self.segmentMiniTopInset;
            }
            
        } else {
            // 当向下滑动时
            // 如果列表已经滚动到屏幕上方
            // 那么保持顶部栏在顶部
            
            // offsetY > 0 segment中的scrollView为向上滑动
            if (offsetY > 0) {
                
                if (self.headerHeightConstraint.constant <= self.segmentMiniTopInset) {
                    self.headerHeightConstraint.constant = self.segmentMiniTopInset;
                }
                
            } else {
                // 如果列表顶部已经进入屏幕
                // 如果顶部栏已经到达底部
                if (self.headerHeightConstraint.constant >= self.headerHeight) {
                    // 如果当前列表滚到了顶部栏的底部
                    // 那么顶部栏继续跟随变大，否这保持不变
                    if (-offsetYWithSegment > self.headerHeight && !_freezenHeaderWhenReachMaxHeaderHeight) {
                        
                        self.headerHeightConstraint.constant = -offsetYWithSegment;
                        
                    } else {
                        
                        self.headerHeightConstraint.constant = self.headerHeight;
                        
                    }
                } else {
                    // 在顶部拦未到达底部的情况下
                    // 如果列表还没滚动到顶部栏底部，那么什么都不做
                    // 如果已经到达顶部栏底部，那么顶部栏跟随滚动
                    if (self.headerHeightConstraint.constant < -offsetYWithSegment) {
                        self.headerHeightConstraint.constant -= deltaOfOffsetY;
                    }
                }
            }
        }
        
        // 更新'segmentToInset'变量，让外部的 kvo 知道顶部栏位置的变化
        self.segmentTopInset = self.headerHeightConstraint.constant;
        
    } else if (context == _ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWINSET) {
        
        UIEdgeInsets insets = [object contentInset];
        
        if (fabs(insets.top - _originalTopInset) < 2) {
            
            self.ignoreOffsetChanged = NO;
            
        } else {
            
            self.ignoreOffsetChanged = YES;
        }
    }
}

#pragma mark - event methods
//
//- (void)segmentControlDidChangedValue:(UISegmentedControl *)sender {
//    
//    // remove obsever
//    [self removeObseverForPageController:self.currentDisplayController];
//    
//    // add new controller
//    NSUInteger index = [sender selectedSegmentIndex];
//    UIViewController<SegmentControllerDelegate> *controller = self.controllers[index];
//    
//    //先移除旧的UIViewControll
//    [self.currentDisplayController willMoveToParentViewController:nil];
//    [self.currentDisplayController.view removeFromSuperview];
//    [self.currentDisplayController removeFromParentViewController];
//    [self.currentDisplayController didMoveToParentViewController:nil];
//    
//    //再将选中的UIViewControll 添加进来
//    [controller willMoveToParentViewController:self];
//    [self.view insertSubview:controller.view atIndex:0];
//    [self addChildViewController:controller];
//    [controller didMoveToParentViewController:self];
//    
//    // reset current controller
//    self.currentDisplayController = controller;
//    // layout new controller
//    [self initScrollConstraint:controller];
//    
//    [self.view setNeedsLayout];
//    [self.view layoutIfNeeded];
//    
//    // trigger to fixed header constraint
//    UIScrollView *scrollView = [self scrollViewInPageController:controller];
//    if (self.headerHeightConstraint.constant != self.headerHeight) {
//        if (scrollView.contentOffset.y >= -(self.segmentHeight + self.headerHeight) && scrollView.contentOffset.y <= -self.segmentHeight) {
//            [scrollView setContentOffset:CGPointMake(0, -self.segmentHeight - self.headerHeightConstraint.constant)];
//        }
//    }
//    // add obsever
//    [self addObserverForPageController:self.currentDisplayController];
//    [scrollView setContentOffset:scrollView.contentOffset];
//}

#pragma mark - manage memory methods
//移除当前的滚动视图的滑动事件监听器
- (void)dealloc {
    
    //[self removeObseverForPageController:self.currentDisplayController];
    
    [self removeObseverForTableView:self.mCurDisplayView];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}






//测试不使用UIViewController
- (void)initScrollViewConstraint:(UIScrollView *)tableView {
    
    //获取pageController控件中能够滚动的视图
    //类似的对应关系为： 如果是UItableViewControll----UItableView   UIConllectViewControler---UIconllectView
    UIView *pageView = tableView;   //note 1
    if ([pageView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        pageView.preservesSuperviewLayoutMargins = YES;
    }
    
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:pageView
                              attribute:NSLayoutAttributeLeading
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeLeading
                              multiplier:1
                              constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:pageView
                              attribute:NSLayoutAttributeTrailing
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeTrailing
                              multiplier:1
                              constant:0]];
    
    //获取pageController控件中能够滚动的视图
    UIScrollView *scrollView = self.mCurDisplayView; //处理滚动列表中UIscrollView 注意与 note1的区别
    if (scrollView) {
        
        scrollView.alwaysBounceVertical = YES;
        _originalTopInset = self.headerHeight + self.segmentHeight;
        
        // 针对屏幕底部存在tabBar的情况
        CGFloat bottomInset = 0;
        if (self.tabBarController.tabBar.hidden == NO) {
            bottomInset = CGRectGetHeight(self.tabBarController.tabBar.bounds);
        }
        
        [scrollView setContentInset:UIEdgeInsetsMake(_originalTopInset, 0, bottomInset, 0)];  //设置可滑动的尺寸 上 左 下 右
        
        //     fixed first time don't show header view
        //        if (![self.hasShownControllers containsObject:pageController]) {
        //            [self.hasShownControllers addObject:pageController];
        //            [scrollView setContentOffset:CGPointMake(0, -self.headerHeight - self.segmentHeight)];
        //        }
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1
                                                               constant:0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1
                                                               constant:0]];
    }
}


- (void)addObserverForTableView:(UITableView*)tableView {
    
    UIScrollView *scrollView = tableView;
    if (scrollView != nil) {
        [scrollView addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(contentOffset))
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                        context:&_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET];
        
        [scrollView addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(contentInset))
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                        context:&_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWINSET];
    }
}


- (void)removeObseverForTableView:(UITableView *)tableView {
    
    UIScrollView *scrollView = tableView;
    if (scrollView != nil) {
        @try {
            [scrollView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
            
            [scrollView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentInset))];
        } @catch (NSException *exception) {
            NSLog(@"exception is %@", exception);
        } @finally {
        }
    }
}

//中间滑动segment导航栏滑动监听事件
-(void) onChangeListener:(NSInteger) index{
    
    [self.segmentScroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH * index, self.segmentScroll.frame.origin.y,
                                                       self.segmentScroll.frame.size.width, self.segmentScroll.frame.size.height) animated:NO];
    
    [self updateCurScrollViewConstraint:index];
    
}

//UIScrollView滑动监听事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSDictionary* scroll = [NSDictionary dictionaryWithObject:scrollView forKey:@"scroll"];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"updateLabelStatus" object:scroll userInfo:nil]];
    
    [self updateCurScrollViewConstraint:scrollView.contentOffset.x / SCREEN_WIDTH];
}

//private method ---更新当前展示页面的约束
-(void) updateCurScrollViewConstraint:(NSInteger) index{
    
    [self removeObseverForTableView:self.mCurDisplayView];
    
    self.mCurDisplayView = index == 0 ? self.comAbstractView : self.chkMeView2;
    
    
    self.mCurDisplayView.alwaysBounceVertical = YES;
    _originalTopInset = self.headerHeight + self.segmentHeight;
    
    // 针对屏幕底部存在tabBar的情况
    CGFloat bottomInset = 0;
    if (self.tabBarController.tabBar.hidden == NO) {
        bottomInset = CGRectGetHeight(self.tabBarController.tabBar.bounds);
    }
    
    [self.mCurDisplayView setContentInset:UIEdgeInsetsMake(_originalTopInset, 0, bottomInset, 0)];  //设置可滑动的尺寸 上 左 下 右
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    UIScrollView *scrollView = self.mCurDisplayView;
    if (self.headerHeightConstraint.constant != self.headerHeight) {
        if (scrollView.contentOffset.y >= -(self.segmentHeight + self.headerHeight) && scrollView.contentOffset.y <= -self.segmentHeight) {
            [scrollView setContentOffset:CGPointMake(0, -self.segmentHeight - self.headerHeightConstraint.constant)];
        }
    }
    
    [self addObserverForTableView:self.mCurDisplayView];
    //[scrollView setContentOffset:CGPointZero];
    
}


@end
