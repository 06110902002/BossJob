//
//  ChatHeadModel.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/31.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"


/**
 聊天页面，聊天信息页面，头部说明实体对象
 */
@interface ChatHeadModel : BaseModel

@property(nonatomic,copy) NSString* sContactName;

@property(nonatomic,copy) NSString* sNewChatCount;

@end
