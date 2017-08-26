//
//  BaseObserver.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/24.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 观察者模式中基类观察者
 */
@interface BaseObserver : NSObject



/**
 主题标签
 */
@property(nonatomic,strong) NSString* subjectTag;


/**
 构造器
 
 @param subject 订阅主题
 @return 实例对象
 */
-(instancetype) initWithSubject:(NSString*) subject;



/**
 收到消息主要做更新操作，NOTE:子类需要重载此接口

 @param msg 收到的信息实体
 */
-(void) update:(NSObject*) msg;


@end
