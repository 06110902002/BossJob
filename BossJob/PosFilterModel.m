//
//  PosFilterModel.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/23.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "PosFilterModel.h"

@interface PosFilterModel ()

@end

@implementation PosFilterModel


-(instancetype) init{
    
    if(self = [super init]){
    
        self.select = false;
    }

    return self;

}

//override 协议接口
-(CellItemType) getItemType{
    
    return CellItemSelect;
}

@end
