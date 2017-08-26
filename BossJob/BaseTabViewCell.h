//
//  BaseTabViewCell.h
//  BossJob
//
//  Created by liuxiaobing on 19/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseModel;

/**
 列表中基类单元格，所有的单元均需扩展此类
 */
@interface BaseTabViewCell : UITableViewCell


-(void) initItemView;

-(void) bindData:(BaseModel*_Nonnull) data;


/**
 此接口为回收资源接口，子类需要扩展
 */
-(void) recycRes;

@end
