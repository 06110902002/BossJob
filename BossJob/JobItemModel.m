//
//  JobItemModel.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/22.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "JobItemModel.h"

@interface JobItemModel ()

@end

@implementation JobItemModel


-(instancetype)init{

    if(self = [super init]){
    
    }
    return self;
}

//override 协议接口
-(CellItemType) getItemType{

    return CellItemJobListType;
}

@end
