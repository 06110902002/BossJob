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


static const int COMPANY_RESET_BUTTON = 15;
static const int COMPANY_CONFIRM_BUTTON = 16;

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
    
    UIScrollView* scrollerBgLayout = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, companyStrategy.frame.size.height - 40.0f)];
    scrollerBgLayout.contentSize = CGSizeMake(SCREEN_WIDTH, 1500);
    [companyStrategy addSubview:scrollerBgLayout];
    
    
    // 设置scrollView的子视图，即过渡视图contentSize，并设置其约束
    UIView *verticalContainerView = [[UIView alloc]init];
    [scrollerBgLayout addSubview:verticalContainerView];
    [verticalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(scrollerBgLayout).with.insets(UIEdgeInsetsZero);
        make.width.equalTo(scrollerBgLayout);
    }];
    
    
    //添加融资阶段组：
    PaddingLabel* conllectMoneyLabel = [[PaddingLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    conllectMoneyLabel.text = @"融资阶段";
    conllectMoneyLabel.textColor = [UIColor grayColor];
    conllectMoneyLabel.font = [UIFont systemFontOfSize:12.0f];
    conllectMoneyLabel.backgroundColor = [UIColor whiteColor];
    conllectMoneyLabel.padding = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f);
    [verticalContainerView addSubview:conllectMoneyLabel];
    
    [conllectMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollerBgLayout.mas_top);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,35.0f));
        
        make.left.equalTo(verticalContainerView.mas_left);
        make.right.equalTo(scrollerBgLayout.mas_right);
    }];
    
    
    FlowLayout* conllectMoneyLayout = [self buildFlowLayout:self.financingBtnList];
    [verticalContainerView addSubview:conllectMoneyLayout];
    
    // 设置约束，不需要设置高度相关的约束
    [conllectMoneyLayout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(conllectMoneyLabel).offset(conllectMoneyLabel.frame.size.height);
        make.left.equalTo(verticalContainerView.mas_left);
        make.right.equalTo(scrollerBgLayout.mas_right);
    }];

    
    //添加人员规模组：延迟0.3s创建规模组，因为添加约束之后会自动调用ifNeedLayout重新布局一次，
    //加此延时，防止布局未完成时就开始下一项布局开始启动导致布局错乱
    PaddingLabel* companySizeLabel = [[PaddingLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    companySizeLabel.text = @"人员规模";
    companySizeLabel.textColor = [UIColor grayColor];
    companySizeLabel.font = [UIFont systemFontOfSize:12.0f];
    companySizeLabel.backgroundColor = [UIColor whiteColor];
    companySizeLabel.padding = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f);
    [verticalContainerView addSubview:companySizeLabel];

    //更新位置这里主要有2种方法，第一种使用GCD进行依赖关系
    __block FlowLayout* companySizeLayout= nil;
    dispatch_group_t group =dispatch_group_create();
    dispatch_group_async(group,dispatch_get_main_queue(), ^{
        
        [companySizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(conllectMoneyLayout).offset(conllectMoneyLayout.height);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,35.0f));
            
            
            make.left.equalTo(verticalContainerView.mas_left);
            make.right.equalTo(scrollerBgLayout.mas_right);
        }];
        
        companySizeLayout = [self buildFlowLayout:self.compSizeBtnList];
        [verticalContainerView addSubview:companySizeLayout];
        
        // 设置约束，不需要设置高度相关的约束
        [companySizeLayout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(companySizeLabel).offset(companySizeLabel.frame.size.height);
            make.left.equalTo(verticalContainerView.mas_left);
            make.right.equalTo(scrollerBgLayout.mas_right);
        }];

    });
    
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        //添加行业
        PaddingLabel* industryLabel = [[PaddingLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        industryLabel.text = @"行业";
        industryLabel.textColor = [UIColor grayColor];
        industryLabel.font = [UIFont systemFontOfSize:12.0f];
        industryLabel.backgroundColor = [UIColor whiteColor];
        industryLabel.padding = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f);
        [verticalContainerView addSubview:industryLabel];
        [industryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(companySizeLayout).offset(companySizeLayout.height);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,35.0f));
            
            make.left.equalTo(verticalContainerView.mas_left);
            make.right.equalTo(scrollerBgLayout.mas_right);
        }];
        
        
        FlowLayout* industryLayout = [self buildFlowLayout:self.industryBtnList];
        [verticalContainerView addSubview:industryLayout];
        [industryLayout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(industryLabel).offset(industryLabel.frame.size.height);
            make.left.equalTo(verticalContainerView.mas_left);
            make.right.equalTo(scrollerBgLayout.mas_right);
            
        }];
        
        // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）
        [verticalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.bottom.equalTo(scrollerBgLayout.mas_bottom).offset(-30);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 580.0f));
        }];
        
    });
    
    
   
    
    
    //添加重置确定按钮
    UIButton* resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, companyStrategy.frame.size.height - 40, SCREEN_WIDTH / 2, 40.0)];
    resetBtn.tag = COMPANY_RESET_BUTTON;
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [resetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    resetBtn.backgroundColor = [UIColor whiteColor];
    [resetBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [companyStrategy addSubview:resetBtn];
    
    
    UIButton* confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, companyStrategy.frame.size.height - 40, SCREEN_WIDTH / 2, 40.0)];
    confirmBtn.tag = COMPANY_CONFIRM_BUTTON;
    [confirmBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = [UIColor greenColor];
    [companyStrategy addSubview:confirmBtn];
    
}

//构建流式标签
-(FlowLayout*) buildFlowLayout:(NSMutableArray*) dataList{
    
    if(!dataList || [dataList count] <= 0) return nil;
    
    FlowLayout *flowButtonView = [[FlowLayout alloc] initWithButtonList:dataList];
    flowButtonView.backgroundColor = [UIColor lightGrayColor];
    [flowButtonView setOnClickBlock:^(UIButton* button,NSInteger idx){
        
        NSLog(@"147-----------:%@",button.titleLabel.text);
        
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

-(NSMutableArray*)industryBtnList{

    if(!_industryBtnList){
        _industryBtnList = [NSMutableArray array];
        NSArray* dataList = @[@"全部",@"非互联网行业",@"健康医疗",@"生活服务",@"旅游",@"金融",@"信息安全",
                              @"广告营销",@"数据服务",@"智能硬件",@"文件娱乐",@"网络招聘",@"分类信息",@"电子商务",
                              @"移动互联网",@"企业服务",@"社交网络",@"教育培训",@"O2O",@"游戏",@"互联网",
                              @"媒体",@"IT软件"];
        _industryBtnList = [self buildCompanyFilterBtn:dataList];
    }
    
    return _industryBtnList;
    
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
        case COMPANY_RESET_BUTTON:
            NSLog(@"222---------------COMPANY_RESET_BUTTON");
            break;
            
        case COMPANY_CONFIRM_BUTTON:
            NSLog(@"226---------------COMPANY_CONFIRM_BUTTON");
            break;
            
        default:
            break;
    }
}

@end
