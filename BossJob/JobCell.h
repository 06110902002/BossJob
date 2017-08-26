//
//  JobCell.h
//  BossJob
//
//  Created by liuxiaobing on 20/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewCell.h"

@class JobItemModel;

@interface JobCell : BaseTabViewCell

@property(nonatomic,strong) UILabel* labelJobTitle;

@property(nonatomic,strong) UILabel* labelSalary;

@property(nonatomic,strong) UILabel* labelCompanyName;

@property(nonatomic,strong) UILabel* labelConllectMoneyStep;

@property(nonatomic,strong) UILabel* labelCompanyAddress;

@property(nonatomic,strong) UILabel* labelCompanyEdu;

@property(nonatomic,strong) UILabel* labelCompanyExp;

@property(nonatomic,strong) UIImageView* imgUrl;

@property(nonatomic,strong) UILabel* labelContactName;

@property(nonatomic,strong) UILabel* labelContactLevel;

@property(nonatomic,strong) JobItemModel* data;

@end
