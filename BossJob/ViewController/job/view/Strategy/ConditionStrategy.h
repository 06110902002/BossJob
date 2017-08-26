//
//  ConditionStrategy.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/22.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePageSegment.h"

@interface ConditionStrategy : BasePageSegment


@property (nonatomic, strong) NSMutableArray *eduBtnList;
@property (nonatomic, strong) NSMutableArray *expBtnList;
@property (nonatomic, strong) NSMutableArray *salaryBtnList;


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




/**
 工厂模式构建筛选对象数组
 
 @param dataList 过滤内容
 @return 构建好的UIbutton对象列表
 */
-(NSMutableArray*) buildCompanyFilterBtn:(NSArray*) dataList;

@end
