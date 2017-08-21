//
//  BasePageSegment.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 面卡选项采用策略模式实现，本类策略基类
 不设置背景视图，因为本类已经扩展了UIView可直接将self当作背景视图
 */
@interface BasePageSegment : UIView



/**
 执行策略接口，子类需重载本接口

 @param parentView 结点视图控制器，用于将装填本对象，以及绑定按钮接口
 @param tag 当前策略和标签
 */
-(void) showLayout:(UIView*) parentView withTag:(NSInteger) tag;

@end
