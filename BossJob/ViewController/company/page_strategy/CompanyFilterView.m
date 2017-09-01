//
//  CompanyFilterView.m
//  BossJob
//
//  Created by 刘小兵 on 2017/9/1.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "CompanyFilterView.h"
#import "FlowLayout.h"
#import "Constants.h"
#import "Masonry.h"
#import "PaddingLabel.h"

static const int RESET_BUTTON = 37;
static const int CONFIRM_BUTTON = 38;
static CompanyFilterView* comFilterView = nil;

@implementation CompanyFilterView


+(instancetype) getInstanceWithWithFrame:(CGRect)frame{
    
    @synchronized (self) {
        
        if(comFilterView == nil){
            
            comFilterView = [[CompanyFilterView alloc] initWithFrame:frame];
        }
    }
    return comFilterView;
    
    
}

-(void) add2ParentView:(UIView*) parentView withTag:(NSInteger) tag{

    if(!comFilterView) return;
    
    comFilterView.tag = tag;
    comFilterView.backgroundColor = [UIColor whiteColor];
    [parentView addSubview:comFilterView];

}

-(void) showFilterLayout:(NSArray*) filterBtnList withType:(NSInteger) type{

    CGRect frame = CGRectZero;
    switch(type){
            
        case 0:
        case 1:{
        
            frame = comFilterView.frame;
            frame.size.height = 165.0;
            comFilterView.frame = frame;
        }
            break;
    
        case 2:{
            
            frame = comFilterView.frame;
            frame.size.height += 150.0;
            comFilterView.frame = frame;
        }
            break;
            
    }
    
    while([[comFilterView subviews] count]){
        [[[comFilterView subviews] lastObject] removeFromSuperview];
    }
    
    FlowLayout* conllectMoneyLayout = [self buildFlowLayout:[self buildFilterBtn:filterBtnList]];
    [comFilterView addSubview:conllectMoneyLayout];
    
    // 设置约束，不需要设置高度相关的约束
    [conllectMoneyLayout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(comFilterView.mas_top);
        make.left.equalTo(comFilterView.mas_left);
        make.right.equalTo(comFilterView.mas_right);
    }];
    
    //添加重置确定按钮
    UIButton* resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, comFilterView.frame.size.height - 40, SCREEN_WIDTH / 2, 40.0)];
    resetBtn.tag = RESET_BUTTON;
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [resetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    resetBtn.backgroundColor = [UIColor whiteColor];
    [resetBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [comFilterView addSubview:resetBtn];
    
    
    UIButton* confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, comFilterView.frame.size.height - 40, SCREEN_WIDTH / 2, 40.0)];
    confirmBtn.tag = CONFIRM_BUTTON;
    [confirmBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = [UIColor greenColor];
    [comFilterView addSubview:confirmBtn];

    [comFilterView layoutIfNeeded];
}


-(void)onClickListener:(UIButton*) sender{
    
    switch(sender.tag){
            
        case RESET_BUTTON:
            NSLog(@"130--------------:RESET_BUTTON");
            break;
            
        case CONFIRM_BUTTON:
             NSLog(@"134--------------:CONFIRM_BUTTON");
            break;
            
    }
}

//构建流式标签
-(FlowLayout*) buildFlowLayout:(NSMutableArray*) dataList{
    
    if(!dataList || [dataList count] <= 0) return nil;
    
    FlowLayout *flowButtonView = [[FlowLayout alloc] initWithButtonList:dataList];
    flowButtonView.backgroundColor = [UIColor lightGrayColor];
    [flowButtonView setOnClickBlock:^(UIButton* button,NSInteger idx){
        
        NSLog(@"183-----------:%@",button.titleLabel.text);
        
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
        
    }];
    flowButtonView.backgroundColor = [UIColor whiteColor];
    
    return flowButtonView;
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


-(NSMutableArray*) buildFilterBtn:(NSArray*) dataList{
    
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
