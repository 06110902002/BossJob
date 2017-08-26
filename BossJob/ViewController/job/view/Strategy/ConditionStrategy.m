//
//  ConditionStrategy.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/22.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ConditionStrategy.h"
#import "PaddingLabel.h"
#import "Constants.h"
#import "Masonry.h"
#import "FlowLayout.h"



static const int CONDITION_RESET_BUTTON = 19;
static const int CONDITION_CONFIRM_BUTTON = 20;

static ConditionStrategy* conditionStrategy = nil;



@interface ConditionStrategy ()

@end

@implementation ConditionStrategy



+(instancetype) getInstanceWithWithFrame:(CGRect)frame{
    
    @synchronized (self) {
        
        if(conditionStrategy == nil){
            
            conditionStrategy = [[ConditionStrategy alloc] initWithFrame:frame];
        }
    }
    return conditionStrategy;
    
    
}


//override method
-(void) showLayout:(UIView*) parentView withTag:(NSInteger) tag{
    
    if(!conditionStrategy) return;
    
    conditionStrategy.tag = tag;
    conditionStrategy.backgroundColor = [UIColor whiteColor];
    [parentView addSubview:conditionStrategy];
    
    if([conditionStrategy subviews].count) return;
    

    //添加融资阶段组：
    PaddingLabel* eduLabel = [[PaddingLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    eduLabel.text = @"学历";
    eduLabel.textColor = [UIColor grayColor];
    eduLabel.font = [UIFont systemFontOfSize:12.0f];
    eduLabel.backgroundColor = [UIColor whiteColor];
    eduLabel.padding = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f);
    [conditionStrategy addSubview:eduLabel];
    
    [eduLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(conditionStrategy.mas_top);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,35.0f));
        
    }];
    
    
    FlowLayout* eduLayout = [self buildFlowLayout:self.eduBtnList];
    [conditionStrategy addSubview:eduLayout];
    
    // 设置约束，不需要设置高度相关的约束
    [eduLayout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(eduLabel).offset(eduLabel.frame.size.height);
        
        make.left.equalTo(conditionStrategy.mas_left);
        make.right.equalTo(conditionStrategy.mas_right);
    }];
    
    
    //添加经验组：延迟0.3s创建规模组，因为添加约束之后会自动调用ifNeedLayout重新布局一次，
    //加此延时，防止布局未完成时就开始下一项布局开始启动导致布局错乱
    PaddingLabel* expLabel = [[PaddingLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    expLabel.text = @"经验";
    expLabel.textColor = [UIColor grayColor];
    expLabel.font = [UIFont systemFontOfSize:12.0f];
    expLabel.backgroundColor = [UIColor whiteColor];
    expLabel.padding = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f);
    [conditionStrategy addSubview:expLabel];
    
    //更新位置这里主要有2种方法，第一种使用GCD进行依赖关系
    __block FlowLayout* expLayout= nil;
    dispatch_group_t group =dispatch_group_create();
    dispatch_group_async(group,dispatch_get_main_queue(), ^{
        
        [expLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(eduLayout).offset(eduLayout.height);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,35.0f));
            
            
            make.left.equalTo(conditionStrategy.mas_left);
            make.right.equalTo(conditionStrategy.mas_right);
        }];
        
        expLayout = [self buildFlowLayout:self.expBtnList];
        [conditionStrategy addSubview:expLayout];
        
        // 设置约束，不需要设置高度相关的约束
        [expLayout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(expLabel).offset(35.0);
            
            make.left.equalTo(conditionStrategy.mas_left);
            make.right.equalTo(conditionStrategy.mas_right);
        }];
        
    });
    
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        //薪水
        PaddingLabel* salaryLabel = [[PaddingLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        salaryLabel.text = @"薪水(单选)";
        salaryLabel.textColor = [UIColor grayColor];
        salaryLabel.font = [UIFont systemFontOfSize:12.0f];
        salaryLabel.backgroundColor = [UIColor whiteColor];
        salaryLabel.padding = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f);
        [conditionStrategy addSubview:salaryLabel];
        [salaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(expLayout).offset(expLayout.height);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,35.0f));
            
//            make.left.equalTo(verticalContainerView.mas_left);
//            make.right.equalTo(scrollerBgLayout.mas_right);
        }];
        
        
        FlowLayout* salaryLayout = [self buildFlowLayout:self.salaryBtnList];
        salaryLayout.tag = 33;
        [conditionStrategy addSubview:salaryLayout];
        [salaryLayout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(salaryLabel).offset(salaryLabel.frame.size.height);
            
            make.left.equalTo(conditionStrategy.mas_left);
            make.right.equalTo(conditionStrategy.mas_right);
            
        }];
    
    });
    
    
    
    
    
    //添加重置确定按钮
    UIButton* resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, conditionStrategy.frame.size.height - 40, SCREEN_WIDTH / 2, 40.0)];
    resetBtn.tag = CONDITION_RESET_BUTTON;
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [resetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    resetBtn.backgroundColor = [UIColor whiteColor];
    [resetBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [conditionStrategy addSubview:resetBtn];
    
    
    UIButton* confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, conditionStrategy.frame.size.height - 40, SCREEN_WIDTH / 2, 40.0)];
    confirmBtn.tag = CONDITION_CONFIRM_BUTTON;
    [confirmBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = [UIColor greenColor];
    [conditionStrategy addSubview:confirmBtn];
    
}

//构建流式标签
-(FlowLayout*) buildFlowLayout:(NSMutableArray*) dataList{
    
    if(!dataList || [dataList count] <= 0) return nil;
    
    FlowLayout *flowButtonView = [[FlowLayout alloc] initWithButtonList:dataList];
    flowButtonView.backgroundColor = [UIColor lightGrayColor];
    [flowButtonView setOnClickBlock:^(UIButton* button,NSInteger idx){
        
        NSLog(@"147-----------:%@",button.titleLabel.text);
        
        //处理薪水单选
        if([[button superview] isEqual:[conditionStrategy viewWithTag:33]]){
            
            for(int i = 0; i< [dataList count]; i++){
                UIButton* tmpBtn = (UIButton*)dataList[i];
                
                if(i == idx ){
                    tmpBtn.backgroundColor = [UIColor greenColor];
                    [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    tmpBtn.layer.borderColor = [UIColor clearColor].CGColor;
                    
                }else{
                    
                    tmpBtn.backgroundColor = [UIColor whiteColor];
                    [tmpBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    tmpBtn.layer.borderColor = [UIColor grayColor].CGColor;
                }
            }
            
            
            
        }else{
            
            if(idx == 0){
                
                for(int i = 0; i< [dataList count]; i++){
                    UIButton* tmpBtn = (UIButton*)dataList[i];
                    
                    if(i == 0 ){
                        tmpBtn.backgroundColor = [UIColor greenColor];
                        [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        tmpBtn.layer.borderColor = [UIColor clearColor].CGColor;
                        
                    }else{
                        
                        tmpBtn.backgroundColor = [UIColor whiteColor];
                        [tmpBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                        tmpBtn.layer.borderColor = [UIColor grayColor].CGColor;
                    }
                }
                
            }else{
                [self switchBtnStatus:button];
                
                UIButton* tmpBtn = (UIButton*)dataList[0];
                tmpBtn.backgroundColor = [UIColor whiteColor];
                [tmpBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                tmpBtn.layer.borderColor = [UIColor grayColor].CGColor;
            }
            
        }
        
        
    }];
    flowButtonView.backgroundColor = [UIColor whiteColor];
    
    return flowButtonView;
}


// laz load resource
- (NSMutableArray *)eduBtnList {
    if (_eduBtnList == nil) {
        
        _eduBtnList = [NSMutableArray array];
        NSArray* collectMoneyStep = @[@"全部",@"中专及以下",@"高中",@"大专",@"本科",@"硕士",@"博士"];
        _eduBtnList = [self buildCompanyFilterBtn:collectMoneyStep];
    }
    return _eduBtnList;
}

-(NSMutableArray*) expBtnList{
    
    if(!_expBtnList){
        _expBtnList = [NSMutableArray array];
        NSArray* dataList = @[@"全部",@"应聘生",@"1年以内",@"1-3年",@"3-5年",@"5-10年",@"10年以上"];
        _expBtnList = [self buildCompanyFilterBtn:dataList];
    }
    
    return _expBtnList;
    
}

-(NSMutableArray*)salaryBtnList{
    
    if(!_salaryBtnList){
        _salaryBtnList = [NSMutableArray array];
        NSArray* dataList = @[@"全部",@"3k以下",@"3k-5k",@"5k-10k",@"10-20k",@"20k-50k",@"50k以上"];
        _salaryBtnList = [self buildCompanyFilterBtn:dataList];
    }
    
    return _salaryBtnList;
    
}


//private method
-(void) switchBtnStatus:(UIButton* ) button{
    
    if([[button titleColorForState:UIControlStateNormal] isEqual:[UIColor grayColor]]){
        
        button.backgroundColor = [UIColor greenColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor clearColor].CGColor;
        
    }else{
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor grayColor].CGColor;
    }
    
}

//private method
-(NSMutableArray*) buildCompanyFilterBtn:(NSArray*) dataList{
    
    NSMutableArray* tmpFilterList = [NSMutableArray array];
    
    for (int i = 0; i < [dataList count]; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [button setTitle:dataList[i] forState:UIControlStateNormal];
        
        button.layer.borderWidth = 0.5f;
        button.layer.cornerRadius = 5.0f;
        
        if(i == 0){
            
            button.backgroundColor = [UIColor greenColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.borderColor = [UIColor clearColor].CGColor;
            
        }else{
            
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.layer.borderColor = [UIColor grayColor].CGColor;
        }
        
        button.contentEdgeInsets = UIEdgeInsetsMake(0,5,0,5);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        CGFloat width = [UILabel getWidthWithTitle:button.titleLabel.text font:button.titleLabel.font];
        button.frame = CGRectMake(0, 0, width + 10, 40);  //重新调整的宽度需要额外添加内容边距
        [tmpFilterList addObject:button];
    }
    return tmpFilterList;
}

-(void)onClickListener:(UIButton*) sender{
    
    switch (sender.tag) {
        case CONDITION_RESET_BUTTON:
            NSLog(@"222---------------COMPANY_RESET_BUTTON");
            break;
            
        case CONDITION_CONFIRM_BUTTON:
            NSLog(@"226---------------COMPANY_CONFIRM_BUTTON");
            break;
            
        default:
            break;
    }
}



@end
