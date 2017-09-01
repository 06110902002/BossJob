//
//  ChatHeadCell.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/31.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ChatHeadCell.h"
#import "Masonry.h"

@implementation ChatHeadCell


//ovride
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self initItemView];
    }
    return self;
}

//ovride super class method for initView
-(void) initItemView{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone; //取消点击时背景色
    
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0, 2.0f, self.frame.size.height - 10)];
    lineView.backgroundColor = [UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0];
    [self addSubview:lineView];
    
    self.labelContactName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, self.frame.size.height)];
    self.labelContactName.text = @"联系人";
    self.labelContactName.font = [UIFont systemFontOfSize:14];
    //self.labelContactName.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.labelContactName];
    [self.labelContactName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30.0);
        make.centerY.equalTo(self);
    }];
    
    self.labelNewChat = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    self.labelNewChat.textColor = [UIColor whiteColor];
    self.labelNewChat.backgroundColor = [UIColor grayColor];
    self.labelNewChat.text = @"查看新开聊(0)";
    self.labelNewChat.font = [UIFont systemFontOfSize:12];
    self.labelNewChat.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.labelNewChat];
    [self.labelNewChat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(90);
    }];
    
}


//ovride super class method
-(void) bindData:(BaseModel*_Nonnull) data{
    
    
    
    
}

//此接口用来移除观察者
-(void) recycRes{
    
    [super recycRes];
    
    
}




@end
