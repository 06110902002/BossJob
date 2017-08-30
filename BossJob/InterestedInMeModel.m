//
//  InterestedInMeModel.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/30.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "InterestedInMeModel.h"

@implementation InterestedInMeModel

-(instancetype)init{
    
    if(self = [super init]){
        
    }
    return self;
}

//override 协议接口
-(CellItemType) getItemType{
    
    return InterestedInMe;
}

@end
