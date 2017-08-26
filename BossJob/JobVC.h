//
//  JobVC.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/17.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FilterNavBar.h"

@class CityOrMetroModel;


/**
 构建公司筛选条件的枚举

 - ConllectMoney: 融资阶段
 - CompSize: 企业规模
 - Industries: 行业
 */
typedef NS_ENUM(NSInteger, FilterType) {
    ConllectMoney = 0,
    CompSize,
    Industries,
    
};

@interface JobVC : BaseViewController<FilterChangeListener,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,CAAnimationDelegate>

@property(nonatomic,strong) UIButton* leftBtn;

@property(nonatomic,strong) UIButton* addBtn;

@property(nonatomic,strong) UIButton* searchBtn;

@property(nonatomic,strong) UIView* filterMaskBgView;

@property(nonatomic,strong) UITableView* jobListView;

@property (nonatomic, strong) NSMutableArray *jobDataSource;

@property (nonatomic, strong) NSString *areaName;

@property(nonatomic,assign) NSInteger nCurPageIndex;        //记录当前过滤页卡，方便蒙版点击移除操作

@property(nonatomic,strong) CABasicAnimation *closeAnim;




-(void) initNavBar;

-(void) initJobListView;





@end
