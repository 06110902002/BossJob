//
//  PageSegmentMgr.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "PageSegmentMgr.h"
#import "BasePageSegment.h"

static PageSegmentMgr* strategyInstance = nil;

@interface PageSegmentMgr ()

@end

@implementation PageSegmentMgr


+(instancetype) getInstance{
    
    @synchronized (self) {
        
        if(strategyInstance == nil){
            
            strategyInstance = [[PageSegmentMgr alloc] init];
        }
    }
    return strategyInstance;
    
}

-(void) selectStrategy:(BasePageSegment*) strategy{
    
    self.strategy = strategy;
    
    //高手一般都能看出来，策略选择器中的那个基类策略引用保持者，只是为了代码的扩展性，如果没有那个引用
    //可直接执行下面的接口
    // [strategy executeStrategy ];
    
}

-(void) showLayout:(UIView*) parentView withTag:(NSInteger) tag{
    
    if(self.strategy){
        [self.strategy showLayout:parentView withTag:tag];
    }
    
}


@end
