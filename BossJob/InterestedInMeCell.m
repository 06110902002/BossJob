//
//  InterestedInMeCell.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/30.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "InterestedInMeCell.h"
#import "Constants.h"
#import "Masonry.h"
#import "InterestedInMeModel.h"

@implementation InterestedInMeCell


//ovride
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self initItemView];
    }
    return self;
}

//ovride super class method for initView
-(void) initItemView{
    
    self.backgroundColor = [UIColor redColor];

    
    self.imgEmpty = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_job_success_share.png"]];
    self.imgEmpty.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imgEmpty];
    [self.imgEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(140);
        make.size.mas_equalTo(CGSizeMake(120.0, 120.0));
        make.centerX.equalTo(self);
    }];
    
    self.labelEmpty = [[UILabel alloc] init];
    self.labelEmpty.textColor = [UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1.0];
    self.labelEmpty.font = [UIFont systemFontOfSize:16];
    self.labelEmpty.text = @"还没有Boss对你感兴趣,快去主动联系吧!";
    self.labelEmpty.numberOfLines = 2;
    self.labelEmpty.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.labelEmpty];
    
    [self.labelEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgEmpty).offset(140.0);
        make.size.mas_equalTo(CGSizeMake(240.0, 40.0));
        make.centerX.equalTo(self);
    }];
    
    
    self.btnEmpty = [[UIButton alloc] init];
    self.btnEmpty.layer.cornerRadius = 5.0f;
    self.btnEmpty.layer.borderWidth = 1.0f;
    self.btnEmpty.layer.borderColor = [UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0].CGColor;
    [self.btnEmpty setTitle:@"找职位" forState:UIControlStateNormal];
    [self.btnEmpty setTitleColor:[UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.btnEmpty.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.btnEmpty];
    
    [self.btnEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelEmpty).offset(50.0);
        make.size.mas_equalTo(CGSizeMake(150.0, 40.0));
        make.centerX.equalTo(self);
    }];
    
    
}


//ovride super class method
-(void) bindData:(BaseModel*_Nonnull) data{
    

//    if(self.data != (InterestedInMeModel*)data){
//    
//        self.data = (InterestedInMeModel*)data;
//        
//    }
    
   
        
}

//此接口用来移除观察者
-(void) recycRes{
    
    [super recycRes];
    
    
}



@end
