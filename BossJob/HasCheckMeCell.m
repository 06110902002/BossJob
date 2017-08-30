//
//  HasCheckMeCell.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/30.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "HasCheckMeCell.h"
#import "Masonry.h"

@implementation HasCheckMeCell


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

    self.label_HR_JobTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    self.label_HR_JobTitle.textColor = [UIColor blackColor];
    self.label_HR_JobTitle.text = @"广联达软件 部门经理";
    self.label_HR_JobTitle.font = [UIFont systemFontOfSize:14];
    [self addSubview: self.label_HR_JobTitle];
    [self.label_HR_JobTitle mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    self.label_JobTitle_Company = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    self.label_JobTitle_Company.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"招聘 Cocos2d"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0]
                          range:NSMakeRange(2, [AttributedStr length] - 2)];
    self.label_JobTitle_Company.attributedText = AttributedStr;
    self.label_JobTitle_Company.font = [UIFont systemFontOfSize:12];
    [self addSubview: self.label_JobTitle_Company];
    [self.label_JobTitle_Company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_HR_JobTitle);
        make.top.equalTo(self.label_HR_JobTitle).offset(20);
    }];

    //初始下面的经验 学历 薪资
    UIImageView* expView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_exp_gray.png"]];
    expView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:expView];
    [expView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_JobTitle_Company);
        make.top.equalTo(self.label_JobTitle_Company).offset(20);
        make.size.mas_equalTo(CGSizeMake(15.0, 15.0));
    }];
    
    
    self.labelCompanyExp = [[UILabel alloc] init];
    self.labelCompanyExp.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelCompanyExp.text = @"1-3年";
    self.labelCompanyExp.font = [UIFont systemFontOfSize:12];
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
    self.labelCompanyEdu.font = [UIFont systemFontOfSize:12];
    self.labelCompanyEdu.text = @"本科";
    [self addSubview: self.labelCompanyEdu];
    [self.labelCompanyEdu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(eduView.mas_trailing).offset(5);
        make.top.equalTo(eduView);
    }];
    
    UIImageView* salaryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_salary.png"]];
    salaryView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:salaryView];
    [salaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labelCompanyEdu.mas_trailing).offset(10);
        make.top.equalTo(self.labelCompanyEdu);
        make.size.mas_equalTo(CGSizeMake(15.0, 15.0));
    }];
    
    self.labelSalary = [[UILabel alloc] init];
    self.labelSalary.textColor = [UIColor colorWithRed:71.0 / 255.0 green:71.0 / 255.0 blue:71.0 / 255.0 alpha:1.0];
    self.labelSalary.font = [UIFont systemFontOfSize:12];
    self.labelSalary.text = @"30k-60k";
    [self addSubview: self.labelSalary];
    [self.labelSalary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(salaryView.mas_trailing).offset(5);
        make.top.equalTo(salaryView);
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
