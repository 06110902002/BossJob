//
//  BaseTableView.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/29.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTabViewCell;


/**
 消息页面，列表基类
 */
@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView* mTableView;

@property(nonatomic,strong)NSMutableArray *dataList;



/**
 初始化接口，子类重载时，可初始化自身的特有的对象
 */
-(void) initAttr;

/**
 构建单元格，子类需要重载此方法，方能达到效果

 @return UITableViewCell
 */
-(BaseTabViewCell*) buildTableViewCell;


/**
 获取单元格高度，子类需要重载

 @return 单元格高度
 */
-(CGFloat) getCellHeight;

@end
