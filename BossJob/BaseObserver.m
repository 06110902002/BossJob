//
//  BaseObserver.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/24.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "BaseObserver.h"

@interface BaseObserver ()

@end

@implementation BaseObserver

-(instancetype) initWithSubject:(NSString*) subject{
    
    if(self == [super init]){
        
        self.subjectTag = subject;
    }
    return self;
    
}

-(void) update:(NSObject*) msg{
    
    NSLog(@"29----------我是基类观察者，儿孙们请尽情的发挥我的优势吧，老子收到的对象是---%@",msg);
}

@end
