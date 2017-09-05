//
//  ComIntroductCell.h
//  BossJob
//
//  Created by 刘小兵 on 2017/9/4.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ScrollNavBar.h"
#import "BaseTabViewCell.h"


@class ComAbstractModel;
/**
 公司概况中，公司介绍cell
 */
@interface ComIntroductCell : BaseTabViewCell

@property(nonatomic,strong) UILabel* labelTitle;

@property(nonatomic,strong) UILabel* labelCompanyInfo;

@property(nonatomic,strong) UIView* bgView;

@property(nonatomic,strong) UIImageView* imgExpandIcon;
@property(nonatomic,strong) UIButton* expandBtn;

@property (nonatomic, assign) BOOL expend;

@property(nonatomic,assign) BOOL bHasUpdateFrame;

@property(nonatomic,strong) ComAbstractModel* data;



@end
