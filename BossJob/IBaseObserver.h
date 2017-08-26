//
//  IBaseObserver.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/24.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IBaseObserver <NSObject>


@optional
/**
 绑定主题构造器,丢给子类实现
 
 @param subject 订阅主题
 */
-(NSString*) bindSubject:(id<IBaseObserver>) observer forSubject:(NSString*) subject;


/**
 注册消息订阅主题
 
 @param subject 订阅的主题标志
 @return 返回当前注册的主题标志
 */
-(NSString*) registerSubject:(NSString*) subject;

/**
 收到消息主要做更新操作，NOTE:子类需要重载此接口
 
 @param msg 收到的信息实体
 */
-(void) update:(NSObject*) msg;




@end
