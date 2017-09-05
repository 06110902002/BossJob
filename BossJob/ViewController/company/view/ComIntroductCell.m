//
//  ComIntroductCell.m
//  BossJob
//
//  Created by 刘小兵 on 2017/9/4.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ComIntroductCell.h"
#import "Masonry.h"
#import "Constants.h"
#import "UIView+Extension.h"
#import "ComAbstractModel.h"

@implementation ComIntroductCell

//ovride
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self initItemView];
    }
    return self;
}

//ovride super class method for initView
-(void) initItemView{
    
    self.bHasUpdateFrame = false;
    self.backgroundColor = [UIColor clearColor];
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    
    
    
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.font = [UIFont systemFontOfSize:12];
    self.labelTitle.text = @"「九队真经」";
    [self addSubview:self.labelTitle];
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.leading.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(80.0f, 40.0f));
    }];
    
    self.labelCompanyInfo = [[UILabel alloc] init];
    self.labelCompanyInfo.font = [UIFont systemFontOfSize:10];
    self.labelCompanyInfo.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelCompanyInfo.text = @"「天之道，损有馀而补不足，是故虚胜实，不足胜有馀。其意博，其理奥，其趣深。天地之像分，阴阳之侯烈，变化之由表，死生之兆章。」「弱之胜强，柔之胜刚，天下莫不知，莫能行」「天下之至柔，驰骋天下之至坚」「五指发劲，无坚不破，摧敌首脑，如穿腐土」「人徒知枯坐息思为进德之功，殊不知上达之士，圆通定慧，体用双修，即静而动，虽撄而宁。」「天之道，损有馀而补不足，是故虚胜实，不足胜有馀。其意博，其理奥，其趣深。天地之像分，阴阳之侯烈，变化之由表，死生之兆章。」「弱之胜强，柔之胜刚，天下莫不知，莫能行」「天下之至柔，驰骋天下之至坚」「五指发劲，无坚不破，摧敌首脑，如穿腐土」「人徒知枯坐息思为进德之功，殊不知上达之士，圆通定慧，体用双修，即静而动，虽撄而宁。」「天之道，损有馀而补不足，是故虚胜实，不足胜有馀。其意博，其理奥，其趣深。天地之像分，阴阳之侯烈，变化之由表，死生之兆章。」「弱之胜强，柔之胜刚，天下莫不知，莫能行」「天下之至柔，驰骋天下之至坚」「五指发劲，无坚不破，摧敌首脑，如穿腐土」「人徒知枯坐息思为进德之功，殊不知上达之士，圆通定慧，体用双修，即静而动，虽撄而宁。」，其趣深。天地之像分，阴阳之侯烈，变化之由表，死生之兆章。」「弱之胜强，柔之胜刚，天下莫不知，莫能行」「天下之至柔，驰骋天下之至坚」「五指发劲，无坚不破，摧敌首脑，如穿腐土」「人徒知枯坐息思为进德之功，殊不知上达之士，圆通定慧，体用双修，即静而动，虽撄而宁。";
    self.labelCompanyInfo.numberOfLines = 3;
    
    [self addSubview:self.labelCompanyInfo];
    [self.labelCompanyInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labelTitle.mas_bottom);
        make.left.mas_equalTo(self.labelTitle);
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
    }];

    
    
    self.expandBtn = [[UIButton alloc] init];
    [self.expandBtn setImage:[UIImage imageNamed:@"ic_popup_arrow_down.png"] forState:UIControlStateNormal];
    self.expandBtn.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.expandBtn];
    [self.expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.labelCompanyInfo.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(15.0, 15.0));
    }];
    
    
}


//ovride super class method
-(void) bindData:(BaseModel*_Nonnull) data{
    
    
    if(self.data != (ComAbstractModel*)data){
        self.data = (ComAbstractModel*)data;
        
    }
}


- (void)setExpend:(BOOL)expend {
    
    _expend = expend;
    if (_expend) {
        self.labelCompanyInfo.numberOfLines = 0;
        [self.expandBtn setImage:[UIImage imageNamed:@"ic_popup_arrow_up.png"] forState:UIControlStateNormal];

        
    } else {
        
       self.labelCompanyInfo.numberOfLines = 10;
       [self.expandBtn setImage:[UIImage imageNamed:@"ic_popup_arrow_down.png"] forState:UIControlStateNormal];
    }
    
}


//override method
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //更新白色背景
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.leading.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 20, self.frame.size.height - 10));
    }];
    
    CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH - 20.0f title:self.labelCompanyInfo.text font:self.labelCompanyInfo.font];
    self.data.cellHeight = height + self.labelTitle.frame.size.height + self.imgExpandIcon.frame.size.height + 30.0;
}




@end
