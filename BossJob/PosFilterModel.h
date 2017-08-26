//
//  PosFilterModel.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/23.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"


/**
 首页地区过滤信息实体
 */
@interface PosFilterModel : BaseModel

@property(nonatomic,copy) NSString* sAddress;

@property(nonatomic,assign) BOOL select;


@property(nonatomic,assign) NSInteger selectCount; //选中的过滤条数

@end
