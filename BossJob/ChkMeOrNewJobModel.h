//
//  ChkMeOrNewJobModel.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/30.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

/**
 看过我--新职位  信息实体对象
 */
@interface ChkMeOrNewJobModel : BaseModel


@property(nonatomic,copy) NSString* imgUrl;

@property(nonatomic,copy) NSString* sHR_JobTitle;

@property(nonatomic,copy) NSString* sJobTitle_Company;

@property(nonatomic,copy) NSString* sSalary;

@property(nonatomic,copy) NSString* sCompanyEdu;

@property(nonatomic,copy) NSString* sCompanyExp;

@property(nonatomic,copy) NSString* sTime;

@end
