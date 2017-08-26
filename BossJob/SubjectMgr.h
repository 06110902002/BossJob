//
//  SubjectMgr.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/24.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBaseObserver.h"

@class BaseObserver;


/**
 观察者模式：
 　抽象主题(Subject)角色：抽象主题角色把所有对观察者对象的引用保存在一个聚集（比如ArrayList对象）里，每个主题都可以有任何数量的观察者。抽象主题提供一个接口，可以增加和删除观察者对象，抽象主题角色又叫做抽象被观察者(Observable)角色。
 
 　　　　具体主题(ConcreteSubject)角色：将有关状态存入具体观察者对象；在具体主题的内部状态改变时，给所有登记过的观察者发出通知。具体主题角色又叫做具体被观察者(Concrete Observable)角色。
 
 　　　　抽象观察者(Observer)角色：为所有的具体观察者定义一个接口，在得到主题的通知时更新自己，这个接口叫做更新接口。
 
 　　　具体观察者(ConcreteObserver)角色：存储与主题的状态自恰的状态。具体观察者角色实现抽象观察者角色所要求的更新接口，以便使本身的状态与主题的状态 像协调。如果需要，具体观察者角色可以保持一个指向具体主题对象的引用。
 
 本类为抽象的主题 类，主要用于多态机制
 */

@interface SubjectMgr : NSObject


/**
 具体的观察者引用列表
 */
@property(strong,nonatomic) NSMutableArray* observersList;


/**
 主题订阅器
 */
@property(strong,nonatomic) NSString* subjectRegister;


+(instancetype) getInstance;

/**
 添加观察者
 
 @param observer 观察者对象
 @param subject 观察者观察的主题，用于区分订阅不同的主题
 */
-(void) registerObserver:(BaseObserver*) observer forSubject:(NSString*) subject;


/**
 移除观察对象

 @param observer 待移除的观察者对象
 */
-(void) removeObserver:(BaseObserver*) observer;

/**
 发送信号

 @param msg 发送的消息实体
 */
-(void) postSingal:(NSObject*) msg;





/**
 具体的观察者引用列表，如果具体的观察者扩展的是接口类，请走下面逻辑
 */
@property(strong,nonatomic) NSMutableArray* oberInterfaceList;

/**
 添加观察者对象到 观察者引用列表中

 @param observer 观察者对象
 @param subject 观察者订阅的主题主题
 */
-(void) bindObserver:(id<IBaseObserver>) observer forSubject:(NSString*) subject;


/**
 从观察者引用列表中，删除观察者

 @param observer 待删除的观察者对象
 */
-(void) deleteObserver:(id<IBaseObserver>) observer;


/**
 广播通知信号

 @param msg 发送的广播内容
 */
-(void) brodcastSingal:(NSObject*) msg;



@end
