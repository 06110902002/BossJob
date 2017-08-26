//
//  BaseModel.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/22.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "BaseModel.h"

@interface BaseModel ()

@end

@implementation BaseModel


-(instancetype) init{

    if(self = [super init]){
    
        self.delegate = self;
    }
    return self;
}

//override 协议接口
-(CellItemType) getItemType{

    return CellItemDefaultType;
}

@end
