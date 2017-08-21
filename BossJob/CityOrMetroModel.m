//
//  CityOrMetroModel.m
//  BossJob
//
//  Created by liuxiaobing on 19/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import "CityOrMetroModel.h"

@implementation CityOrMetroModel


//实现构造函数
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.areaOrMetroLineName = dict[@"name"];
        self.areasOrMetroLineArr = dict[@"areas"];
    }
    return self;
}

//实现类工厂方法
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    
    CityOrMetroModel *tmpObj = [[CityOrMetroModel alloc]initWithDict:dict];
    
    return tmpObj;
}


@end
