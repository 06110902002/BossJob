//
//  FilterNavBar.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/18.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FilterChangeListener <NSObject>

@optional
-(void) onChange:(NSInteger) index;

@end

/**
 筛选导航栏
 */
@interface FilterNavBar : UIView


@property(nonatomic,strong) NSMutableArray* titleList;

//筛选点击事件监听器
@property(nonatomic,weak) id<FilterChangeListener> delegate;



/**
 初始化标题

 @param titles 标题列表
 */
-(void)iniTitles:(NSMutableArray*) titles;


/**
 更新标题栏状态

 @param idx 更新的索引
 */
-(void)updateTitleBtnStatus:(NSInteger) idx;


@end
