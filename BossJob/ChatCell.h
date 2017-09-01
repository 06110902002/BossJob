//
//  ChatCell.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/31.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewCell.h"

@interface ChatCell : BaseTabViewCell

@property(nonatomic,strong) UIImageView* imgUrl;

@property(nonatomic,strong) UILabel* labelName;

@property(nonatomic,strong) UILabel* labelTime;

@property(nonatomic,strong) UILabel* labelCompany;

@property(nonatomic,strong) UILabel* labelHRLevel;

@property(nonatomic,strong) UILabel* labelMsgStatus;

@property(nonatomic,strong) UILabel* labelMsg;




@end
