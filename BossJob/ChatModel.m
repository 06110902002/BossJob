//
//  ChatModel.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/31.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel


-(instancetype)init{
    
    if(self = [super init]){
        
    }
    return self;
}

//override 协议接口
-(CellItemType) getItemType{
    
    return ChatType;
}

@end
