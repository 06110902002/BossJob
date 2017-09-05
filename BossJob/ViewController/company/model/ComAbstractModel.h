//
//  ComAbstractModel.h
//  BossJob
//
//  Created by 刘小兵 on 2017/9/4.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ScrollNavBar.h"
#import "BaseModel.h"


/**
 公司概况--信息实体
 */
@interface ComAbstractModel : BaseModel

@property(nonatomic,assign) BOOL expaned;

@property(nonatomic,assign) CGFloat cellHeight;

@end
