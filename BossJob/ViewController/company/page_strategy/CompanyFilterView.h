//
//  CompanyFilterView.h
//  BossJob
//
//  Created by 刘小兵 on 2017/9/1.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 公司过滤标签，采用抽象工厂模式
 */
@interface CompanyFilterView : UIView


//@property (nonatomic, strong) NSMutableArray *filterList;

/**
 实例管理类
 @param frame 当前策略的标签
 @return 本实例对象
 */
+(instancetype) getInstanceWithWithFrame:(CGRect)frame;



/**
 将当前添加到父视图中

 @param parentView 父视图
 @param tag 视图标签
 */
-(void) add2ParentView:(UIView*) parentView withTag:(NSInteger) tag;


/**
 显示过滤视图

 @param filterBtnList :过滤用的标签数组
 @param type 类型
 */
-(void) showFilterLayout:(NSArray*) filterBtnList withType:(NSInteger) type;


/**
 外部文本---构建筛选对象数组
 
 @param dataList 过滤内容
 @return 构建好的UIbutton对象列表
 */
-(NSMutableArray*) buildFilterBtn:(NSArray*) dataList;


@end
