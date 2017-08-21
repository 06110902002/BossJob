//
//  RecommendStrategy.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePageSegment.h"


/**
 首页中工作选项中推荐过滤面卡，采用策略模式设计
 */
@interface RecommendStrategy : BasePageSegment



/**
 实例管理类
 @param frame 当前策略的标签
 @return 本实例对象
 */
+(instancetype) getInstanceWithWithFrame:(CGRect)frame;

/**
 执行策略接口，声明重载父类接口
 
 @param tag 当前策略的标签
 */
-(void) showLayout:(UIView*) parentView withTag:(NSInteger) tag;

@end
