//
//  ChatModel.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/31.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface ChatModel : BaseModel

@property(nonatomic,copy) NSString* imgUrl;

@property(nonatomic,copy) NSString* sHRName;

@property(nonatomic,copy) NSString* sTime;

@property(nonatomic,copy) NSString* sCompany;

@property(nonatomic,copy) NSString* sHRLevel;

@property(nonatomic,copy) NSString* sMsgStatus;

@property(nonatomic,copy) NSString* sMsg;



@end
