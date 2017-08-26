//
//  JobCell.m
//  BossJob
//
//  Created by liuxiaobing on 20/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import "JobCell.h"
#import "Masonry.h"
#import "UIView+Extension.h"
#import "JobItemModel.h"


@implementation JobCell


//ovride
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{

    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self initItemView];
    }
    return self;
}

//ovride super class method for initView
-(void) initItemView{
    
    self.labelJobTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    self.labelJobTitle.textColor = [UIColor blackColor];
    self.labelJobTitle.font = [UIFont systemFontOfSize:16];
    [self addSubview: self.labelJobTitle];
    [self.labelJobTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.top.equalTo(self).offset(10);
    }];
    
    self.labelSalary = [[UILabel alloc] init];
    self.labelSalary.textColor = [UIColor colorWithRed:208.0 / 255.0 green:108.0 / 255.0 blue:99.0 / 255.0 alpha:1.0];
    self.labelSalary.font = [UIFont systemFontOfSize:16];
    [self addSubview: self.labelSalary];
    [self.labelSalary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-13);
        make.top.equalTo(self.labelJobTitle);
    }];
    
    
    self.labelCompanyName = [[UILabel alloc] init];
    self.labelCompanyName.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelCompanyName.font = [UIFont systemFontOfSize:18];
    [self addSubview: self.labelCompanyName];
    [self.labelCompanyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelJobTitle);
        make.top.equalTo(self.labelJobTitle).offset(30);
    }];
    
    self.labelConllectMoneyStep = [[UILabel alloc] init];
    self.labelConllectMoneyStep.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelConllectMoneyStep.font = [UIFont systemFontOfSize:18];
    [self addSubview: self.labelConllectMoneyStep];
    [self.labelConllectMoneyStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelCompanyName);
        make.leading.equalTo(self.labelCompanyName.mas_trailing).offset(10);
    }];
    
    UIImageView* locationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_location_gray.png"]];
    locationView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:locationView];
    [locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelJobTitle);
        make.top.equalTo(self.labelCompanyName).offset(30);
        make.size.mas_equalTo(CGSizeMake(15.0, 15.0));
    }];


    self.labelCompanyAddress = [[UILabel alloc] init];
    self.labelCompanyAddress.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelCompanyAddress.font = [UIFont systemFontOfSize:14];
    [self addSubview: self.labelCompanyAddress];
    [self.labelCompanyAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationView).offset(20);
        make.top.equalTo(locationView);
    }];
    
    UIImageView* expView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_exp_gray.png"]];
    expView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:expView];
    [expView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labelCompanyAddress.mas_trailing).offset(10);
        make.top.equalTo(self.labelCompanyAddress);
        make.size.mas_equalTo(CGSizeMake(15.0, 15.0));
    }];
    
    
    self.labelCompanyExp = [[UILabel alloc] init];
    self.labelCompanyExp.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelCompanyExp.font = [UIFont systemFontOfSize:14];
    [self addSubview: self.labelCompanyExp];
    [self.labelCompanyExp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(expView.mas_trailing).offset(5);
        make.top.equalTo(expView);
    }];

    
    
    UIImageView* eduView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_degree.png"]];
    eduView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:eduView];
    [eduView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labelCompanyExp.mas_trailing).offset(10);
        make.top.equalTo(self.labelCompanyExp);
        make.size.mas_equalTo(CGSizeMake(15.0, 15.0));
    }];
    
    
    self.labelCompanyEdu = [[UILabel alloc] init];
    self.labelCompanyEdu.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelCompanyEdu.font = [UIFont systemFontOfSize:14];
    [self addSubview: self.labelCompanyEdu];
    [self.labelCompanyEdu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(eduView.mas_trailing).offset(5);
        make.top.equalTo(eduView);
    }];

    
    //底部分隔线
    UIView* lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:232.0 / 255.0 green:232.0 / 255.0 blue:233.0 / 255.0 alpha:1.0];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(locationView).offset(25);
        make.height.mas_equalTo(1);
        
    }];
    
    self.imgUrl = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_3.png"]];
    self.imgUrl.contentMode = UIViewContentModeScaleAspectFit;
    self.imgUrl.layer.masksToBounds = YES;
    self.imgUrl.layer.cornerRadius = 15.0;
    [self addSubview:self.imgUrl];
    
    [self.imgUrl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(locationView);
        make.top.equalTo(lineView).offset(8);
        make.size.mas_equalTo(CGSizeMake(30.0, 30.0));
        
    }];
    
    
    self.labelContactName = [[UILabel alloc] init];
    self.labelContactName.textColor = [UIColor colorWithRed:145.0 / 255.0 green:224.0 / 255.0 blue:201.0 / 255.0 alpha:1.0];
    self.labelContactName.font = [UIFont systemFontOfSize:18];
    [self addSubview: self.labelContactName];
    [self.labelContactName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imgUrl.mas_trailing).offset(10);
        make.top.equalTo(lineView).offset(12);
    }];
    
    //竖分隔线
    UIView* verticalView = [[UIView alloc] init];
    verticalView.backgroundColor = [UIColor colorWithRed:145.0 / 255.0 green:224.0 / 255.0 blue:201.0 / 255.0 alpha:1.0];
    [self addSubview:verticalView];
    [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.labelContactName.mas_trailing).offset(5);
        make.top.equalTo(self.labelContactName);
        make.size.mas_equalTo(CGSizeMake(1.5, 20.0));
        
    }];
    
    self.labelContactLevel = [[UILabel alloc] init];
    self.labelContactLevel.textColor = [UIColor colorWithRed:145.0 / 255.0 green:224.0 / 255.0 blue:201.0 / 255.0 alpha:1.0];
    self.labelContactLevel.font = [UIFont systemFontOfSize:18];
    [self addSubview: self.labelContactLevel];
    [self.labelContactLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(verticalView.mas_trailing).offset(5);
        make.top.equalTo(self.labelContactName);
    }];
    
}

//ovride super class method
-(void) bindData:(BaseModel*_Nonnull) data{
    
    if(self.data != (JobItemModel*)data){
        self.data = (JobItemModel*)data;
        self.labelJobTitle.text = self.data.sJobTitle;
        CGFloat width = [UILabel getWidthWithTitle:self.labelJobTitle.text font:self.labelJobTitle.font];
        self.labelJobTitle.frame = CGRectMake(0, 0, width + 10, 30);  //重新调整的宽度进行宽度自适应
        
        self.labelSalary.text = self.data.sSalary;
        CGFloat width2 = [UILabel getWidthWithTitle:self.labelSalary.text font:self.labelSalary.font];
        self.labelSalary.frame = CGRectMake(0, 0, width2 + 10, 30);
        
        self.labelCompanyName.text = self.data.sCompanyName;
        CGFloat width3 = [UILabel getWidthWithTitle:self.labelCompanyName.text font:self.labelCompanyName.font];
        self.labelCompanyName.frame = CGRectMake(0, 0, width3 + 10, 30);
        
        self.labelConllectMoneyStep.text = self.data.sConllectMoneyStep;
        CGFloat w4 = [UILabel getWidthWithTitle:self.labelConllectMoneyStep.text font:self.labelConllectMoneyStep.font];
        self.labelConllectMoneyStep.frame = CGRectMake(0, 0, w4 + 10, 30);
        
        self.labelCompanyAddress.text = self.data.sCompanyAddress;
        CGFloat w5 = [UILabel getWidthWithTitle:self.labelCompanyAddress.text font:self.labelCompanyAddress.font];
        self.labelCompanyAddress.frame = CGRectMake(0, 0, w5 + 10, 30);
        
        self.labelCompanyExp.text = self.data.sCompanyExp;
        CGFloat w6 = [UILabel getWidthWithTitle:self.labelCompanyExp.text font:self.labelCompanyExp.font];
        self.labelCompanyExp.frame = CGRectMake(0, 0, w6 + 10, 30);
        
        self.labelCompanyEdu.text = self.data.sCompanyEdu;
        CGFloat w7 = [UILabel getWidthWithTitle:self.labelCompanyEdu.text font:self.labelCompanyEdu.font];
        self.labelCompanyEdu.frame = CGRectMake(0, 0, w7 + 10, 30);
        
        self.labelContactName.text = self.data.sContactName;
        CGFloat w8 = [UILabel getWidthWithTitle:self.labelContactName.text font:self.labelContactName.font];
        self.labelContactName.frame = CGRectMake(0, 0, w8 + 10, 30);
        
        self.labelContactLevel.text = self.data.sContactLevel;
        CGFloat w9 = [UILabel getWidthWithTitle:self.labelContactLevel.text font:self.labelContactLevel.font];
        self.labelContactLevel.frame = CGRectMake(0, 0, w9 + 10, 30);
       
    }
}

//override 重载设置边框达到设置单元格分组效果
- (void)setFrame:(CGRect)frame{
    
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}



@end
