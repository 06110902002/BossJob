//
//  ChatCell.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/31.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ChatCell.h"
#import "Masonry.h"

@implementation ChatCell



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
    
    self.imgUrl = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_3.png"]];
    self.imgUrl.contentMode = UIViewContentModeScaleAspectFit;
    self.imgUrl.layer.masksToBounds = YES;
    self.imgUrl.layer.cornerRadius = 25.0;
    [self addSubview:self.imgUrl];
    [self.imgUrl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50.0, 50.0));
        
    }];
    
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    self.labelName.textColor = [UIColor blackColor];
    self.labelName.text = @"韦小宝";
    self.labelName.font = [UIFont systemFontOfSize:14];
    [self addSubview: self.labelName];
    [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgUrl).offset(60.0);
        make.top.equalTo(self).offset(10);
    }];
    
    self.labelTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    self.labelTime.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelTime.text = @"2天前";
    self.labelTime.font = [UIFont systemFontOfSize:12];
    [self addSubview: self.labelTime];
    [self.labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
    }];
    
    self.labelCompany = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    self.labelCompany.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelCompany.text = @"天上人间娱乐有限公司";
    self.labelCompany.font = [UIFont systemFontOfSize:12];
    [self addSubview: self.labelCompany];
    [self.labelCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelName);
        make.top.equalTo(self.labelName).offset(20);
    }];
    

    UIImageView* lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labelCompany.mas_trailing).offset(5);
        make.top.equalTo(self.labelCompany);
        make.size.mas_equalTo(CGSizeMake(1.0, 15.0));
    }];
    
    self.labelHRLevel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    self.labelHRLevel.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelHRLevel.text = @"大内总管";
    self.labelHRLevel.font = [UIFont systemFontOfSize:12];
    [self addSubview: self.labelHRLevel];
    [self.labelHRLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(lineView.mas_trailing).offset(5);
        make.top.equalTo(self.labelCompany);
        
    }];
 
    //消息状态
    self.labelMsgStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    self.labelMsgStatus.textColor = [UIColor whiteColor];
    self.labelMsgStatus.backgroundColor = [UIColor greenColor];
    self.labelMsgStatus.text = @"已读";
    self.labelMsgStatus.layer.cornerRadius = 2;
    self.labelMsgStatus.layer.masksToBounds = true;
    self.labelMsgStatus.font = [UIFont systemFontOfSize:10];
    self.labelMsgStatus.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.labelMsgStatus];
    [self.labelMsgStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelCompany);
        make.top.equalTo(self.labelCompany).offset(20);
        make.size.mas_equalTo(CGSizeMake(25.0, 15.0));
    }];
    
    self.labelMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    self.labelMsg.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelMsg.text = @"少林寺于8月中秋举行武林大会";
    self.labelMsg.font = [UIFont systemFontOfSize:10];
    [self addSubview: self.labelMsg];
    [self.labelMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labelMsgStatus.mas_trailing).offset(5);
        make.top.equalTo(self.labelMsgStatus);
        make.size.mas_equalTo(CGSizeMake(200.0, 15.0));
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
