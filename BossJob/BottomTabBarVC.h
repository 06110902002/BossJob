//
//  BottomTabBarVC.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/17.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JobVC;
@class CompanyVC;
@class MsgVC;
@class MineVC;

/**
 底部菜单选项导航栏
 */
@interface BottomTabBarVC : UITabBarController

@property(nonatomic,strong) JobVC* jobVC;

@property(nonatomic,strong) CompanyVC* companyVC;

@property(nonatomic,strong) MsgVC* msgVC;

@property(nonatomic,strong) MineVC* mineVC;


-(void) initMenu;


/**
 更新底部导航未读消息

 @param index 待更新的uibatitem索引
 @param count 消息数
 */
-(void) updateTips:(NSInteger) index withCount:(NSInteger) count;


@end
