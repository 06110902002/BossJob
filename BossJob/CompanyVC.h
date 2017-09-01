//
//  CompanyVC.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/17.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CompanyVC : BaseViewController<CAAnimationDelegate>


@property(nonatomic,strong) UIButton* searchBtn;

@property(nonatomic,strong) UIView* filterMaskBgView;

@property(nonatomic,strong) UITableView* companyListView;

@property (nonatomic, strong) NSMutableArray *companyDataList;


@property(nonatomic,assign) NSInteger nCurPageIndex;        //记录当前过滤页卡，方便蒙版点击移除操作

@property(nonatomic,strong) CABasicAnimation *closeAnim;




-(void) initNavBar;

-(void) initCompanyListView;


/**
 获取过滤数组

 @param type 过滤类型
 @return 返回过滤数组
 */
-(NSArray*) getFilterDataList:(NSInteger) type;

@end
