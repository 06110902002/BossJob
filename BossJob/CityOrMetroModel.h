//
//  CityOrMetroModel.h
//  BossJob
//
//  Created by liuxiaobing on 19/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 城市或者地铁线路实体
 */
@interface CityOrMetroModel : NSObject

@property(nonatomic,copy) NSString* areaOrMetroLineName;

@property(nonatomic,strong) NSArray* areasOrMetroLineArr;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;


@end
