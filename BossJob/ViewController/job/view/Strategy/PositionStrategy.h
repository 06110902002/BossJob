//
//  PositionStrategy.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePageSegment.h"
#import "IBaseObserver.h"

@class PosRightFilterCell;
@class PosLeftFilterCell;
@class PosFilterModel;

@interface PositionStrategy : BasePageSegment<UITableViewDataSource,UITableViewDelegate,IBaseObserver>



@property(nonatomic,strong) UITableView* leftFilterListView;

@property(nonatomic,strong) UITableView* rightFilterListView;

@property (nonatomic, strong) NSMutableArray *leftDataSource;

@property (nonatomic, strong) NSMutableArray *rightDataSource;

@property (nonatomic, strong) NSMutableArray *areaOrMetroLineArray;


@property(nonatomic,strong) PosRightFilterCell* rightCell;

@property(nonatomic,strong) PosLeftFilterCell* leftCell;

@property(nonatomic,strong) NSMutableDictionary* area_detailDict;   //地区/地铁  -- 详细信息字典
@property(nonatomic,strong) PosFilterModel* selectModel;            //选中的过滤item


/**
 消息接收代理
 */
@property(nonatomic,weak) id<IBaseObserver> singalDelegate;


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
 回收资源
 */
-(void) recycRes;


@end
