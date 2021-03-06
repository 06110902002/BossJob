//
//  CompanyStrategy.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePageSegment.h"

@interface CompanyStrategy : BasePageSegment


@property (nonatomic, strong) NSMutableArray *financingBtnList;
@property (nonatomic, strong) NSMutableArray *compSizeBtnList;
@property (nonatomic, strong) NSMutableArray *industryBtnList;


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
