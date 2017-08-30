//
//  InterestedInMeModel.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/30.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"


/**
 对我感兴趣实体对象
 */
@interface InterestedInMeModel : BaseModel

@property(nonatomic,copy) NSString* imgPath;        //这个路径为本地路径，或者是url地址

@property(nonatomic,copy) NSString* tips;


@end
