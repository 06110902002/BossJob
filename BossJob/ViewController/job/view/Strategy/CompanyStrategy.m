//
//  CompanyStrategy.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "CompanyStrategy.h"
#import "PaddingLabel.h"
#import "Constants.h"
#import "Masonry.h"
#import "FlowLayout.h"


static const int CONLLECT_MONEY_STEP = 14;

static CompanyStrategy* companyStrategy = nil;

@interface CompanyStrategy ()

@end

@implementation CompanyStrategy


+(instancetype) getInstanceWithWithFrame:(CGRect)frame{
    
    @synchronized (self) {
        
        if(companyStrategy == nil){
            
            companyStrategy = [[CompanyStrategy alloc] initWithFrame:frame];
        }
    }
    return companyStrategy;
    
    
}


//override method
-(void) showLayout:(UIView*) parentView withTag:(NSInteger) tag{
    
    if(!companyStrategy) return;
    
    companyStrategy.tag = tag;
    companyStrategy.backgroundColor = [UIColor whiteColor];
    [parentView addSubview:companyStrategy];
    
    if([companyStrategy subviews].count) return;
    
   
    
    //添加融资阶段组：
    PaddingLabel* conllectMoneyLabel = [[PaddingLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    conllectMoneyLabel.tag = CONLLECT_MONEY_STEP;
    conllectMoneyLabel.text = @"融资阶段";
    conllectMoneyLabel.textColor = [UIColor grayColor];
    conllectMoneyLabel.font = [UIFont systemFontOfSize:12.0f];
    conllectMoneyLabel.backgroundColor = [UIColor whiteColor];
    conllectMoneyLabel.padding = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f);
    [companyStrategy addSubview:conllectMoneyLabel];
    
    [conllectMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(companyStrategy.mas_top);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,35.0f));
    }];
    
    
    FlowLayout *flowButtonView = [[FlowLayout alloc] initWithButtonList:self.financingBtnList];
    flowButtonView.backgroundColor = [UIColor lightGrayColor];
    [flowButtonView setOnClickBlock:^(UIButton* button,NSInteger idx){
        
        NSLog(@"523-----------:%@",button.titleLabel.text);
        
        if(idx == 0){
            
            for(int i = 0; i< [self.financingBtnList count]; i++){
                UIButton* tmpBtn = (UIButton*)self.financingBtnList[i];
                
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
            
            UIButton* tmpBtn = (UIButton*)self.financingBtnList[0];
            tmpBtn.backgroundColor = [UIColor whiteColor];
            [tmpBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            tmpBtn.layer.borderColor = [UIColor grayColor].CGColor;
        }
        
    }];
    flowButtonView.backgroundColor = [UIColor whiteColor];
    [companyStrategy addSubview:flowButtonView];
    
    // 设置约束，不需要设置高度相关的约束
    [flowButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(conllectMoneyLabel).offset(conllectMoneyLabel.frame.size.height);
        make.left.equalTo(companyStrategy.mas_left);
        make.right.equalTo(companyStrategy.mas_right);
    }];

    
}



// laz load resource
- (NSMutableArray *)financingBtnList {
    if (_financingBtnList == nil) {
        
        _financingBtnList = [NSMutableArray array];
        NSArray* collectMoneyStep = @[@"全部",@"未融资",@"天使轮",@"A轮",@"B轮",@"C轮",@"D轮及以上",@"已上市",@"不需要融资"];
        _financingBtnList = [self buildCompanyFilterBtn:collectMoneyStep];
    }
    return _financingBtnList;
}

-(NSMutableArray*) compSizeBtnList{
    
    if(!_compSizeBtnList){
        _compSizeBtnList = [NSMutableArray array];
        NSArray* dataList = @[@"全部",@"0-20人",@"20-99人",@"100-499人",@"500-999人",@"1000-9999",@"10000人以上"];
        _compSizeBtnList = [self buildCompanyFilterBtn:dataList];
    }
    
    return _compSizeBtnList;
    
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

@end
