//
//  PageSegmentMgr.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BasePageSegment;

 /**
 策略选择器，负责选择具体的策略
 因为具体的策略，在客户端选择之前是未定的，所以需要用策略基类来保持具体的策略的引用
 */
@interface PageSegmentMgr : NSObject

@property(nonatomic,retain) BasePageSegment* strategy;



+(instancetype) getInstance;

/**
 选择策略
 
 @param strategy 具体的策略对象
 */
-(void) selectStrategy:(BasePageSegment*) strategy;



/**
 执行策略  这个方法其实可以省略，为了方便阅读，与解偶合执行的动作放在这里
 */
-(void) showLayout:(UIView*) parentView withTag:(NSInteger) tag;


@end
