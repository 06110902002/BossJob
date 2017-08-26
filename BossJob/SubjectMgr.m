//
//  SubjectMgr.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/24.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "SubjectMgr.h"
#import "BaseObserver.h"
#import "IBaseObserver.h"

static SubjectMgr* subjectInsatnce = nil;

@interface SubjectMgr ()

@end

@implementation SubjectMgr

+(instancetype) getInstance{
    
    @synchronized (self) {
        
        if(subjectInsatnce == nil){
            
            subjectInsatnce = [[SubjectMgr alloc] init];
        }
    }
    return subjectInsatnce;
    
    
}

-(instancetype)init{
    
    if(self == [super init]){
        
        self.observersList = [[NSMutableArray alloc] init];
        self.subjectRegister = @"";
        
        self.oberInterfaceList = [[NSMutableArray alloc] init];

        
    }
    
    return self;
}


-(void) registerObserver:(BaseObserver*) observer forSubject:(NSString*) subject{
    
    [self.observersList addObject:observer];
    
    self.subjectRegister = subject;
    
}

-(void) removeObserver:(BaseObserver*) observer{
    
    if([self.observersList containsObject:observer]){
        
        [self.observersList removeObject:observer];
    }
    
}

-(void) postSingal:(NSObject*) msg{
    
    for(id obj in self.observersList){
        
        if([self.subjectRegister isEqualToString:[obj subjectTag]]){
            
            [obj update:msg];
        }
        
    }
    
}


-(void) bindObserver:(id<IBaseObserver>) observer forSubject:(NSString*) subject{
    
    
    if([self.oberInterfaceList containsObject:observer]) return; //防止重复绑定观察者主题
    
    [self.oberInterfaceList addObject:observer];
    self.subjectRegister = [observer registerSubject:subject];
    
}


-(void) brodcastSingal:(NSObject*) msg{
    
    for(id obj in self.oberInterfaceList){
        
        if([self.subjectRegister isEqualToString:[obj registerSubject:self.subjectRegister]]){
           [obj update:msg];
        }
        
    }
}

-(void) deleteObserver:(id<IBaseObserver>)observer{

    if([self.oberInterfaceList containsObject:observer]){
        [self.oberInterfaceList removeObject:observer];
    }
}




@end
