//
//  JobItemModel.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/22.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"


/**
 首页工作列表数据模型
 */
@interface JobItemModel : BaseModel

@property(nonatomic,copy) NSString* sJobTitle;

@property(nonatomic,copy) NSString* sSalary;

@property(nonatomic,copy) NSString* sCompanyName;

@property(nonatomic,copy) NSString* sConllectMoneyStep;

@property(nonatomic,copy) NSString* sCompanyAddress;

@property(nonatomic,copy) NSString* sCompanyEdu;

@property(nonatomic,copy) NSString* sCompanyExp;

@property(nonatomic,copy) NSString* sHeadUrl;

@property(nonatomic,copy) NSString* sContactName;

@property(nonatomic,copy) NSString* sContactLevel;

//注意基类需要实现的类型接口

@end
