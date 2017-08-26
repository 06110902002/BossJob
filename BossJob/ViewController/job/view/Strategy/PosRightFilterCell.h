//
//  PosRightFilterCell.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/23.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewCell.h"


@class PosFilterModel;
@class SubjectMgr;
@class BaseObserver;

@interface PosRightFilterCell : BaseTabViewCell


@property(nonatomic,strong) UILabel* labelAddress;

@property(nonatomic,strong) UIImageView* imgSelect;

@property(nonatomic,strong) PosFilterModel* data;


//重载父类接口
-(void) recycRes;

@end
