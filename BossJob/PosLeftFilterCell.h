//
//  PosLeftFilterCell.h
//  BossJob
//
//  Created by liuxiaobing on 19/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewCell.h"

@class PosFilterModel;

/**
 地点左侧筛选单元格
 */
@interface PosLeftFilterCell : BaseTabViewCell

@property(nonatomic,strong) UILabel* labelAddress;

@property(nonatomic,strong) UILabel* labelSelectCount;

@property(nonatomic,strong) PosFilterModel* data;

@end
