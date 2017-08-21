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

@interface JobVC : BaseViewController<FilterChangeListener,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIButton* leftBtn;

@property(nonatomic,strong) UIButton* addBtn;

@property(nonatomic,strong) UIButton* searchBtn;

@property(nonatomic,strong) UIView* filterMaskBgView;

@property(nonatomic,strong) UITableView* jobListView;

@property (nonatomic, strong) NSMutableArray *jobDataSource;


@property(nonatomic,strong) UITableView* leftFilterListView;

@property(nonatomic,strong) UITableView* rightFilterListView;

@property (nonatomic, strong) NSMutableArray *leftDataSource;

@property (nonatomic, strong) NSMutableArray *rightDataSource;


@property (nonatomic, strong) NSString *areaName;

@property (nonatomic, strong) NSMutableArray *areaOrMetroLineArray;

//公司过滤条件标签列表融资阶段 标签列表
@property (nonatomic, strong) NSMutableArray *financingBtnList;
@property (nonatomic, strong) NSMutableArray *compSizeBtnList;


-(void) initNavBar;

-(void) initJobListView;


/**
 加载城市的商圈与地铁线路资源文件，即加载左边过滤数据
 */
-(void) loadAreaRes;


/**
 根据值获取plist中对应的数组信息

 @param keyValue  输入键值
 @return keyValue key在plist文件所对应的值
 */
-(NSMutableArray*) getDetailAreaOrMetroLineInfo:(NSString*) keyValue;


/**
 加载公司过滤条件数据，主要生成标签流
 */
-(void) loadCompanyFilterData;


/**
 工厂模式构建筛选对象数组

 @param dataList 过滤内容
 @return 构建好的UIbutton对象列表
 */
-(NSMutableArray*) buildCompanyFilterBtn:(NSArray*) dataList;



@end
