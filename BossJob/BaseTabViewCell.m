//
//  BaseTabViewCell.m
//  BossJob
//
//  Created by liuxiaobing on 19/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import "BaseTabViewCell.h"
#import "BaseModel.h"

@implementation BaseTabViewCell


//留给子类类扩展
-(void) initItemView{

}

//留给子类类扩展
-(void) bindData:(BaseModel*_Nonnull) data{
    
}

//回收资源接口
-(void) recycRes{

    NSLog(@"看到此日志信息，说明你已经考滤的很全面了，不过还需要加油^_^");
}

@end
