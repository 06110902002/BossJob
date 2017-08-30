//
//  InterestedInMeCell.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/30.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewCell.h"

@class InterestedInMeModel;


/**
 对我感兴趣单元格
 */
@interface InterestedInMeCell : BaseTabViewCell

@property(nonatomic,strong) UIImageView* imgEmpty;

@property(nonatomic,strong) UILabel* labelEmpty;

@property(nonatomic,strong) UIButton* btnEmpty;

@property(nonatomic,strong) InterestedInMeModel* data;

@end
