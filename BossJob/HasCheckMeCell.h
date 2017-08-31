//
//  HasCheckMeCell.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/30.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewCell.h"

@class ChkMeOrNewJobModel;

@interface HasCheckMeCell : BaseTabViewCell


@property(nonatomic,strong) UIImageView* imgUrl;

@property(nonatomic,strong) UILabel* label_HR_JobTitle;

@property(nonatomic,strong) UILabel* label_JobTitle_Company;

@property(nonatomic,strong) UILabel* labelSalary;

@property(nonatomic,strong) UILabel* labelCompanyEdu;

@property(nonatomic,strong) UILabel* labelCompanyExp;

@property(nonatomic,strong) UILabel* labelTime;

@property(nonatomic,strong) ChkMeOrNewJobModel* data;



@end
