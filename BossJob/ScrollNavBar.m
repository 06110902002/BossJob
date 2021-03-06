//
//  ScrollNavBar.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/29.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ScrollNavBar.h"
#import "Constants.h"

@implementation ScrollNavBar

-(instancetype) initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self initAttr];
    }
    return self;
    
}

-(void) initAttr{
    
    self.nCurIndex = 0;
    self.btnList = [NSMutableArray array];
}

-(void)iniTitles:(NSMutableArray*) titles{
    
    self.titleList = titles;
    
    self.itemWidth = SCREEN_WIDTH / [self.titleList count];
    
    [self.titleList enumerateObjectsUsingBlock:^(NSString* title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(idx * self.itemWidth, 0, self.itemWidth, 40.0)];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = idx;
        [button addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [self addSubview:button];
        [self.btnList  addObject:button];
        
    }];
    
    //创建底部线条
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 40.0, SCREEN_WIDTH, 0.5f)];
    lineView.backgroundColor = [UIColor colorWithRed:232.0 / 255.0 green:232.0 / 255.0 blue:233.0 / 255.0 alpha:1.0];
    [self addSubview:lineView];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 40.0, self.itemWidth, 1.5f)];
    self.bottomLine.backgroundColor = [UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0];
    [self addSubview:self.bottomLine];
    
//    //创建中间的滑动视图
//    self.segmentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 42.5, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    self.segmentScroll.contentSize = CGSizeMake(SCREEN_WIDTH * [self.titleList count], SCREEN_HEIGHT);
//    self.segmentScroll.alwaysBounceHorizontal = YES;
//    self.segmentScroll.pagingEnabled = YES;
//    [self addSubview:self.segmentScroll];
//    
//    //使用kvo来监听uiscroll的滑动事件，代替它的协议接口
//    //添加注册实现contentOffset监听
//    [self.segmentScroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//
//    
//    //测试视图
//    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    view1.backgroundColor = [UIColor greenColor];
//    [self.segmentScroll addSubview:view1];
//    
//    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    view2.backgroundColor = [UIColor blueColor];
//    [self.segmentScroll addSubview:view2];
//    
//    UIView* view3 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    view3.backgroundColor = [UIColor greenColor];
//    [self.segmentScroll addSubview:view3];

}


//本接口主要，创建中间滚动视图
-(void)initSegmentView:(NSMutableArray*) views{

    if([views count] == 0 ) return;
    //创建中间的滑动视图
    self.segmentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 42.5, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.segmentScroll.contentSize = CGSizeMake(SCREEN_WIDTH * [self.titleList count], SCREEN_HEIGHT);
    self.segmentScroll.alwaysBounceHorizontal = YES;
    self.segmentScroll.pagingEnabled = YES;
    [self addSubview:self.segmentScroll];
    
    //使用kvo来监听uiscroll的滑动事件，代替它的协议接口
    //添加注册实现contentOffset监听
    [self.segmentScroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
    [views enumerateObjectsUsingBlock:^(UIView* layout, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(idx > [views count]) *stop = true;
        
        [self.segmentScroll addSubview:layout];
        
    }];


}

-(void)onClickListener:(UIButton*) button{
    
    if(self.delegate != nil){
        [self.delegate onChangeListener:button.tag];
    }
    
    [self.segmentScroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH * button.tag, 42.5, SCREEN_WIDTH, SCREEN_HEIGHT) animated:NO];
    
    
    NSValue* fromValue = [NSValue valueWithCGPoint:CGPointMake(self.nCurIndex * self.itemWidth + 0.5 * self.itemWidth,40.0)];
    NSValue* toValue = [NSValue valueWithCGPoint:CGPointMake(button.tag * self.itemWidth + 0.5 * self.itemWidth, 40.0)];
    [self startLineMoveAnimFromValue:fromValue toValue:toValue duration:0.3];

    self.nCurIndex = button.tag;
    
    [self updateTitleBtnStatus:button.tag];
    
    self.finalPos = CGPointMake(button.tag * self.itemWidth + 0.5 * self.itemWidth, 40.0);
}

-(void) updateTitleBtnStatus:(NSInteger)idx{

    
    [self.btnList enumerateObjectsUsingBlock:^(UIButton* button, NSUInteger index, BOOL * _Nonnull stop) {
       
        if(idx == index){
            [button setTitleColor:[UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0] forState:UIControlStateNormal];
            
        }else{
            [button setTitleColor:[UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        }

    }];
}

//private method---线条移动启动动画
-(void) startLineMoveAnimFromValue:(id) fromValue toValue:(id) toValue  duration:(CFTimeInterval) time{
    
    self.moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    self.moveAnimation.fromValue = fromValue;
    self.moveAnimation.toValue = toValue;
    self.moveAnimation.delegate = self;
    self.moveAnimation.removedOnCompletion = NO;
    self.moveAnimation.fillMode = kCAFillModeForwards;
    self.moveAnimation.duration = time;
    
    [self.bottomLine.layer removeAllAnimations];
    [self.bottomLine.layer addAnimation:self.moveAnimation forKey:@"onStart"];
   

}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
       if([self.bottomLine.layer.animationKeys.lastObject isEqualToString:@"onStart"]){
        
           CGRect frame = self.bottomLine.frame;
           frame.origin.x = self.finalPos.x;
           self.bottomLine.frame = frame;
           
    }
}

//-------------------kvo 实现观察主题 ----------------
//对于滑动翻页使用kvo监听机制
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
    CGPoint oldOffset = [change[NSKeyValueChangeOldKey] CGPointValue];
    CGFloat oldOffsetX = oldOffset.x;
    CGFloat deltaOfOffsetX = offset.x - oldOffsetX;
    
    //下面为下划线跟随弹性  效果
//    NSValue *oldvalue = change[NSKeyValueChangeOldKey];
//    NSValue *newvalue = change[NSKeyValueChangeNewKey];
//    CGFloat oldoffset_x = oldvalue.UIOffsetValue.horizontal;
//    CGFloat newoffset_x = newvalue.UIOffsetValue.horizontal;
//    //跟随滑动
//    CGFloat contentOffsetX = newoffset_x;
//    CGFloat sWidth =  SCREEN_WIDTH;
//    CGFloat content_X = (newoffset_x / sWidth);
//    NSArray *arr = [[NSString stringWithFormat:@"%f",content_X] componentsSeparatedByString:@"."];
//    int num = [arr[0] intValue]; //找到滑动的索引
//
//    CGFloat scale = content_X - num;
//    int selectIndex = contentOffsetX / SCREEN_WIDTH;
//
//    UIButton*_btnRight;
//    UIButton*_btnLeft;
//    NSLog(@"650---------contentOffsetX:%f  oldoffsetX:%f",contentOffsetX,oldoffset_x);
//    // 拖拽
//    if (contentOffsetX <= oldoffset_x ){
//        selectIndex++;
//        if (selectIndex - 1 < 0 || selectIndex > self.btnList.count - 1) {
//            return;
//        }
//        _btnRight = [self.btnList objectAtIndex:selectIndex];
//        _btnLeft = [self.btnList objectAtIndex:selectIndex - 1];
//    } else if (contentOffsetX > oldoffset_x ){
//        if (selectIndex + 1 > self.btnList.count - 1) {
//                   return;
//               }
//        _btnRight = [self.btnList objectAtIndex:selectIndex + 1];
//        _btnLeft = [self.btnList objectAtIndex:selectIndex];
//
//    }
//    if (!_btnRight || !_btnLeft) {
//           return;
//       }
//
//    CGRect rect = self.bottomLine.frame;
//    if (scale < 0.5 ) {
//        rect.size.width = 10 + ( _btnRight.center.x-_btnLeft.center.x) * scale*2;
//        rect.origin.x = _btnLeft.center.x -10/2;
//    }else if(scale >= 0.5 ){
//        rect.size.width =  10+(_btnRight.center.x-_btnLeft.center.x) * (1-scale)*2;
//        rect.origin.x = _btnLeft.center.x +  2*(scale-0.5)*(_btnRight.center.x - _btnLeft.center.x)-10/2;
//    }
//    self.bottomLine.frame = rect;


    [self.bottomLine.layer removeAllAnimations];
    CGRect frame = self.bottomLine.frame;
    frame.origin.x = deltaOfOffsetX / SCREEN_WIDTH * self.itemWidth;
    self.bottomLine.frame = frame;
    [self.bottomLine layoutIfNeeded];
 
    self.nCurIndex = deltaOfOffsetX / SCREEN_WIDTH;
    [self updateTitleBtnStatus:self.nCurIndex];
    
}

-(void)dealloc{
    [self.segmentScroll removeObserver:self forKeyPath:@"contentOffset" context:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateLabelStatus" object:nil];

}
//-------------------kvo 实现观察主题 end----------------


//处理在其他页面不方便更新指示线与标签的状态
-(void)registerBrodcast{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabelStatus:) name:@"updateLabelStatus" object:nil];
}

-(void) updateLabelStatus:(NSNotification *)msg{
    
    
    NSDictionary* tmpInfo = [msg object];
    UIScrollView* scroll = (UIScrollView*)[tmpInfo objectForKey:@"scroll"];
    
    
    [self.bottomLine.layer removeAllAnimations];
    CGRect frame = self.bottomLine.frame;
    frame.origin.x = scroll.contentOffset.x / SCREEN_WIDTH * self.itemWidth;
    self.bottomLine.frame = frame;
    [self.bottomLine layoutIfNeeded];
    
    self.nCurIndex = scroll.contentOffset.x / SCREEN_WIDTH;
    [self updateTitleBtnStatus:self.nCurIndex];
}

@end
    
    
    
    
    
    
//底部索引线毛毛虫效果使用下部文件
    
   ////
////  ScrollNavBar.m
////  BossJob
////
////  Created by 刘小兵 on 2017/8/29.
////  Copyright © 2017年 刘小兵. All rights reserved.
////
//
//#import "ScrollNavBar.h"
//#import "Constants.h"
//
//#define   PageVCWidth   [UIScreen mainScreen].bounds.size.width
//
//@implementation ScrollNavBar
//
//-(instancetype) initWithFrame:(CGRect)frame{
//
//    if(self = [super initWithFrame:frame]){
//
//        [self initAttr];
//    }
//    return self;
//
//}
//
//-(void) initAttr{
//
//    self.nCurIndex = 0;
//    self.btnList = [NSMutableArray array];
//}
//
//-(void)iniTitles:(NSMutableArray*) titles{
//
//    self.titleList = titles;
//
//    self.itemWidth = SCREEN_WIDTH / [self.titleList count];
//
//    [self.titleList enumerateObjectsUsingBlock:^(NSString* title, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(idx * self.itemWidth, 0, self.itemWidth, 40.0)];
//        button.backgroundColor = [UIColor whiteColor];
//        button.tag = idx;
//        [button addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
//        [button setTitle:title forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:12];
//        [button setTitleColor:[UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
//        [self addSubview:button];
//        [self.btnList  addObject:button];
//
//    }];
//
//    //创建底部线条
//    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 40.0, SCREEN_WIDTH, 0.5f)];
//    lineView.backgroundColor = [UIColor colorWithRed:232.0 / 255.0 green:232.0 / 255.0 blue:233.0 / 255.0 alpha:1.0];
//    [self addSubview:lineView];
//
//    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH / 3 - 10) / 2, 40.0, 10, 1.5f)];
//    self.bottomLine.backgroundColor = [UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0];
//    [self addSubview:self.bottomLine];
//
////    //创建中间的滑动视图
////    self.segmentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 42.5, SCREEN_WIDTH, SCREEN_HEIGHT)];
////    self.segmentScroll.contentSize = CGSizeMake(SCREEN_WIDTH * [self.titleList count], SCREEN_HEIGHT);
////    self.segmentScroll.alwaysBounceHorizontal = YES;
////    self.segmentScroll.pagingEnabled = YES;
////    [self addSubview:self.segmentScroll];
////
////    //使用kvo来监听uiscroll的滑动事件，代替它的协议接口
////    //添加注册实现contentOffset监听
////    [self.segmentScroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
////
////
////    //测试视图
////    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
////    view1.backgroundColor = [UIColor greenColor];
////    [self.segmentScroll addSubview:view1];
////
////    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
////    view2.backgroundColor = [UIColor blueColor];
////    [self.segmentScroll addSubview:view2];
////
////    UIView* view3 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
////    view3.backgroundColor = [UIColor greenColor];
////    [self.segmentScroll addSubview:view3];
//
//}
//
//
////本接口主要，创建中间滚动视图
//-(void)initSegmentView:(NSMutableArray*) views{
//
//    if([views count] == 0 ) return;
//    //创建中间的滑动视图
//    self.segmentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 42.5, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    self.segmentScroll.contentSize = CGSizeMake(SCREEN_WIDTH * [self.titleList count], SCREEN_HEIGHT);
//    self.segmentScroll.alwaysBounceHorizontal = YES;
//    self.segmentScroll.pagingEnabled = YES;
//    [self addSubview:self.segmentScroll];
//
//    //使用kvo来监听uiscroll的滑动事件，代替它的协议接口
//    //添加注册实现contentOffset监听
//    [self.segmentScroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//
//    [views enumerateObjectsUsingBlock:^(UIView* layout, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        if(idx > [views count]) *stop = true;
//
//        [self.segmentScroll addSubview:layout];
//
//    }];
//
//
//}
//
//-(void)onClickListener:(UIButton*) button{
//
//    if(self.delegate != nil){
//        [self.delegate onChangeListener:button.tag];
//    }
//
//    [self.segmentScroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH * button.tag, 42.5, SCREEN_WIDTH, SCREEN_HEIGHT) animated:NO];
//
//
//    NSValue* fromValue = [NSValue valueWithCGPoint:CGPointMake(self.nCurIndex * self.itemWidth + 0.5 * self.itemWidth,40.0)];
//    NSValue* toValue = [NSValue valueWithCGPoint:CGPointMake(button.tag * self.itemWidth + 0.5 * self.itemWidth, 40.0)];
//    [self startLineMoveAnimFromValue:fromValue toValue:toValue duration:0.3];
//
//    self.nCurIndex = button.tag;
//
//    [self updateTitleBtnStatus:button.tag];
//
//    self.finalPos = CGPointMake(button.tag * self.itemWidth + 0.5 * self.itemWidth, 40.0);
//}
//
//-(void) updateTitleBtnStatus:(NSInteger)idx{
//
//
//    [self.btnList enumerateObjectsUsingBlock:^(UIButton* button, NSUInteger index, BOOL * _Nonnull stop) {
//
//        if(idx == index){
//            [button setTitleColor:[UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0] forState:UIControlStateNormal];
//
//        }else{
//            [button setTitleColor:[UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
//        }
//
//    }];
//}
//
//-(void) updateBottomLine:(CGFloat) scale{
//
//}
//
////private method---线条移动启动动画
//-(void) startLineMoveAnimFromValue:(id) fromValue toValue:(id) toValue  duration:(CFTimeInterval) time{
//
//    self.moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//    self.moveAnimation.fromValue = fromValue;
//    self.moveAnimation.toValue = toValue;
//    self.moveAnimation.delegate = self;
//    self.moveAnimation.removedOnCompletion = NO;
//    self.moveAnimation.fillMode = kCAFillModeForwards;
//    self.moveAnimation.duration = time;
//
//    [self.bottomLine.layer removeAllAnimations];
//    [self.bottomLine.layer addAnimation:self.moveAnimation forKey:@"onStart"];
//
//
//}
//
//-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//
//       if([self.bottomLine.layer.animationKeys.lastObject isEqualToString:@"onStart"]){
//
////           CGRect frame = self.bottomLine.frame;
////           frame.origin.x = self.finalPos.x;
////           self.bottomLine.frame = frame;
//
//    }
//}
//
//
//
//
////-------------------kvo 实现观察主题 ----------------
////对于滑动翻页使用kvo监听机制
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//
//    CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
//    CGPoint oldOffset = [change[NSKeyValueChangeOldKey] CGPointValue];
//    CGFloat oldOffsetX = oldOffset.x;
//    CGFloat deltaOfOffsetX = offset.x - oldOffsetX;
//
//
//    self.nCurIndex = deltaOfOffsetX / SCREEN_WIDTH;
//    [self updateTitleBtnStatus:self.nCurIndex];
//
//    //下面为下划线跟随弹性  效果
//    CGFloat contentOffsetX = offset.x;
//    CGFloat sWidth =  SCREEN_WIDTH;
//    CGFloat content_X = (offset.x / sWidth);
//    NSArray *arr = [[NSString stringWithFormat:@"%f",content_X] componentsSeparatedByString:@"."];
//    int num = [arr[0] intValue]; //找到滑动的索引
//
//    CGFloat scale = content_X - num;
//    int selectIndex = deltaOfOffsetX / SCREEN_WIDTH;
//    UIButton*_btnRight;
//    UIButton*_btnLeft;
//    // 拖拽
//    if (contentOffsetX <= oldOffsetX ){
//        selectIndex++;
//        if (selectIndex - 1 < 0 || selectIndex > self.btnList.count - 1) {
//            return;
//        }
//        _btnRight = [self.btnList objectAtIndex:selectIndex];
//        _btnLeft = [self.btnList objectAtIndex:selectIndex - 1];
//    } else if (contentOffsetX > oldOffsetX ){
//        if (selectIndex + 1 > self.btnList.count - 1) {
//                   return;
//               }
//        _btnRight = [self.btnList objectAtIndex:selectIndex + 1];
//        _btnLeft = [self.btnList objectAtIndex:selectIndex];
//
//    }
//    if (!_btnRight || !_btnLeft) {
//           return;
//       }
//
//    CGRect rect = self.bottomLine.frame;
//    if (scale < 0.5 ) {
//        rect.size.width = 10 + ( _btnRight.center.x-_btnLeft.center.x) * scale*2;
//        rect.origin.x = _btnLeft.center.x -10/2;
//    }else if(scale >= 0.5 ){
//        rect.size.width =  10+(_btnRight.center.x-_btnLeft.center.x) * (1-scale)*2;
//        rect.origin.x = _btnLeft.center.x +  2*(scale-0.5)*(_btnRight.center.x - _btnLeft.center.x)-10/2;
//    }
//    [self.bottomLine.layer removeAllAnimations];
//    self.bottomLine.frame = rect;
//
//
//
////    [self.bottomLine.layer removeAllAnimations];
////    CGRect frame = self.bottomLine.frame;
////    frame.origin.x = deltaOfOffsetX / SCREEN_WIDTH * self.itemWidth;
////    self.bottomLine.frame = frame;
////    [self.bottomLine layoutIfNeeded];
////
////    self.nCurIndex = deltaOfOffsetX / SCREEN_WIDTH;
////    [self updateTitleBtnStatus:self.nCurIndex];
//
//}
//
//-(void)dealloc{
//    [self.segmentScroll removeObserver:self forKeyPath:@"contentOffset" context:nil];
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateLabelStatus" object:nil];
//
//}
////-------------------kvo 实现观察主题 end----------------
//
//
////处理在其他页面不方便更新指示线与标签的状态
//-(void)registerBrodcast{
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabelStatus:) name:@"updateLabelStatus" object:nil];
//}
//
//-(void) updateLabelStatus:(NSNotification *)msg{
//
//
//    NSDictionary* tmpInfo = [msg object];
//    UIScrollView* scroll = (UIScrollView*)[tmpInfo objectForKey:@"scroll"];
//
//
////    [self.bottomLine.layer removeAllAnimations];
////    CGRect frame = self.bottomLine.frame;
////    frame.origin.x = scroll.contentOffset.x / SCREEN_WIDTH * self.itemWidth;
////    self.bottomLine.frame = frame;
////    [self.bottomLine layoutIfNeeded];
//
//    self.nCurIndex = scroll.contentOffset.x / SCREEN_WIDTH;
//    [self updateTitleBtnStatus:self.nCurIndex];
//}
//
//@end

    
