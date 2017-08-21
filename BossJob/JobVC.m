//
//  JobVC.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/17.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "JobVC.h"
#import "Constants.h"
#import "Masonry.h"
#import "JobCell.h"
#import "PosLeftFilterCell.h"
#import "CityOrMetroModel.h"
#import "FlowLayout.h"
#import "PaddingLabel.h"
#import "PageSegmentMgr.h"
#import "RecommendStrategy.h"
#import "PositionStrategy.h"
#import "CompanyStrategy.h"

static const int LEFT_BUTTON = 1;
static const int ADD_BUTTON = 2;
static const int SEARCH_BUTTON = 3;

static const int NEW_RECOMMEND_BUTTON = 4;
static const int NEW_NEW_BUTTON = 5;

static const int POS_BUSINESS_CIRCLE_BUTTON = 6;
static const int POS_METRO_BUTTON = 7;
static const int POS_BOTTOM_LINE = 8;

static const int LEFT_TABLEVIEW = 9;
static const int RIGHT_TABLEVIEW = 10;
static const int JOB_TABLEVIEW = 11;
static const int RESET_BUTTON = 12;
static const int CONFIRM_BUTTON = 13;
static const int CONLLECT_MONEY_STEP = 14;

static const int RECOMMEND_PANEL = 15;
static const int POSITION_PANEL = 16;
static const int COMPANY_PANEL = 17;
static const int CONDITION_PANEL = 18;

@implementation JobVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initNavBar];
    [self initFilterNavBar];
    [self initJobListView];
    
}

-(void) initNavBar{
    
    
    UIView* topNavBarLayout = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 45)];
    topNavBarLayout.backgroundColor = UIColorFromHex(235614);
    
    
    self.leftBtn = [[UIButton alloc] init];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.leftBtn setTitle:@"IOS" forState:UIControlStateNormal];
    self.leftBtn.titleLabel.textColor = [UIColor whiteColor];
    self.leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.leftBtn.tag = LEFT_BUTTON;
    [self.leftBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [topNavBarLayout addSubview:self.leftBtn];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90.0, 45.0));
        make.centerY.equalTo(topNavBarLayout);
        make.left.equalTo(topNavBarLayout).offset(12);
    }];
    
    
    self.addBtn = [[UIButton alloc] init];
    [self.addBtn setImage:[UIImage imageNamed:@"ic_f1_add"] forState:UIControlStateNormal];
    self.addBtn.contentMode = UIViewContentModeScaleAspectFit;
    self.addBtn.tag = ADD_BUTTON;
     [self.addBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [topNavBarLayout addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(30.0, 30.0));
        make.centerY.equalTo(topNavBarLayout);
        make.right.equalTo(topNavBarLayout).offset(-60);
    }];
    
    self.searchBtn = [[UIButton alloc] init];
    [self.searchBtn setImage:[UIImage imageNamed:@"ic_action_search"] forState:UIControlStateNormal];
    self.searchBtn.contentMode = UIViewContentModeScaleAspectFit;
    self.searchBtn.tag = SEARCH_BUTTON;
    [self.searchBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [topNavBarLayout addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(30.0, 30.0));
        make.centerY.equalTo(topNavBarLayout);
        make.right.equalTo(topNavBarLayout).offset(-12);
    }];

    [self.view addSubview:topNavBarLayout];


}


/**
 处理所有按钮的点击事件

 @param sender 发送事件的对象
 */
-(void)onClickListener:(UIButton*) sender{
    
    switch (sender.tag) {
        case LEFT_BUTTON:{
            NSLog(@"61-----------:");
        }
            break;
            
        case ADD_BUTTON:
            break;
            
        case SEARCH_BUTTON:
            break;
            
        
        case NEW_RECOMMEND_BUTTON:{
            
            //修改选中的控件颜色
            UIButton *recBtn = (UIButton *)[self.filterMaskBgView viewWithTag:NEW_RECOMMEND_BUTTON];
            UILabel* recLabel = [recBtn subviews].firstObject;
            recLabel.textColor = [UIColor greenColor];
            
            if([[recBtn subviews] count] < 2){
                
                UIImageView* selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(recLabel.center.x + 17, 13, 15, 15)];
                [selectedImg setImage:[UIImage imageNamed:@"ic_selected_done.png"]];
                selectedImg.contentMode = UIViewContentModeScaleAspectFit;
                [recBtn addSubview:selectedImg];
            }
           
            
            //还原未选中的颜色
            UIButton *NewBtn = (UIButton *)[self.filterMaskBgView viewWithTag:NEW_NEW_BUTTON];
            UILabel* newLabel = [NewBtn subviews].firstObject;
            newLabel.textColor = [UIColor grayColor];
            
            if([[NewBtn subviews] count] >= 2){
                UIImageView* newImg = [NewBtn subviews].lastObject;
                if(newImg != NULL){
                    [newImg removeFromSuperview];
                }
            }
            NSLog(@"131------------更新列表数据，筛选条件为推荐");
           
        }
            break;
            
        case NEW_NEW_BUTTON:{
        
            //修改选中的控件颜色
            UIButton *NewBtn = (UIButton *)[self.filterMaskBgView viewWithTag:NEW_NEW_BUTTON];
            UILabel* newLabel = [NewBtn subviews].firstObject;
            newLabel.textColor = [UIColor greenColor];
            
            if([[NewBtn subviews] count] < 2){
                
                UIImageView* selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(newLabel.center.x + 17, 13, 15, 15)];
                [selectedImg setImage:[UIImage imageNamed:@"ic_selected_done.png"]];
                selectedImg.contentMode = UIViewContentModeScaleAspectFit;
                [NewBtn addSubview:selectedImg];
            }
            
            
            //还原未选中的颜色
            UIButton *recBtn = (UIButton *)[self.filterMaskBgView viewWithTag:NEW_RECOMMEND_BUTTON];
            UILabel* recLabel = [recBtn subviews].firstObject;
            recLabel.textColor = [UIColor grayColor];
            
            if([[recBtn subviews] count] >= 2){
                
                UIImageView* newImg = [recBtn subviews].lastObject;
                if(newImg != NULL){
                    [newImg removeFromSuperview];
                }
            }
            
            NSLog(@"161------------更新列表数据，筛选条件为最新");
        }
            break;
            
        case POS_BUSINESS_CIRCLE_BUTTON:{
            
            UIButton *businessBtn = (UIButton *)[self.filterMaskBgView viewWithTag:POS_BUSINESS_CIRCLE_BUTTON];
            
            //修改文本为绿色
            UILabel* businessLabel = [(UILabel*) businessBtn subviews][1];
            businessLabel.textColor = [UIColor greenColor];
            
            //当少于3说明没有下划线
            if([[businessBtn subviews] count] < 3){
            
                UIImageView* bootomLine = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4 - 40, 37, 80, 3)];
                [bootomLine setBackgroundColor:[UIColor greenColor]];
                bootomLine.tag = POS_BOTTOM_LINE;
                [businessBtn addSubview:bootomLine];
            }
            
            //再调整地铁栏样式
            UIButton *metroBtn = (UIButton *)[self.filterMaskBgView viewWithTag:POS_METRO_BUTTON];
            //修改文本为绿色
            UILabel* metroLabel = [(UILabel*) metroBtn subviews][1];
            metroLabel.textColor = [UIColor grayColor];
            
            //当大于3移除下划线
            if([[metroBtn subviews] count] >= 3){
               [[metroBtn subviews].lastObject removeFromSuperview];
            }

            
           
            
        }
            break;
            
            
        case POS_METRO_BUTTON:{
            
            UIButton *metroBtn = (UIButton *)[self.filterMaskBgView viewWithTag:POS_METRO_BUTTON];
            
            //修改文本为绿色
            UILabel* metroLabel = [(UILabel*) metroBtn subviews][1];
            metroLabel.textColor = [UIColor greenColor];
            
            //当少于3说明没有下划线
            if([[metroBtn subviews] count] < 3){
                
                UIImageView* bootomLine = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4 - 40, 37, 80, 3)];
                [bootomLine setBackgroundColor:[UIColor greenColor]];
                bootomLine.tag = POS_BOTTOM_LINE;
                [metroBtn addSubview:bootomLine];
            }
            
            //再调整地铁栏样式
            UIButton *businessBtn = (UIButton *)[self.filterMaskBgView viewWithTag:POS_BUSINESS_CIRCLE_BUTTON];
            //修改文本为绿色
            UILabel* businessLabel = [(UILabel*) businessBtn subviews][1];
            businessLabel.textColor = [UIColor grayColor];
            
            //当大于3移除下划线
            if([[businessBtn subviews] count] >= 3){
                [[businessBtn subviews].lastObject removeFromSuperview];
            }

            
        }
            break;
            
        default:
            break;
    }
    
}

//private method
//初始化筛选导航栏
-(void) initFilterNavBar{
    
    NSMutableArray* title = [NSMutableArray arrayWithObjects:@"推荐",@"地点",@"公司",@"要求", nil];
    
    FilterNavBar* filter = [[FilterNavBar alloc] init];
    filter.delegate = self;
    [filter iniTitles:title];
    [self.view addSubview:filter];
    [filter mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40.0));
        make.top.equalTo(self.view).offset(65);
    
    }];
    
}

//实现 FilterNavBar 中筛选栏点击协议方法
-(void) onChange:(NSInteger)index{
    
    if(self.filterMaskBgView == nil){
        
        self.filterMaskBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 105, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.filterMaskBgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        self.filterMaskBgView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMaskViewGesture:)];
        gesture.delegate  = self;
        [self.filterMaskBgView addGestureRecognizer:gesture];
        [self.view addSubview:self.filterMaskBgView];
    }
    

    switch(index){
            
        case 0:{
            
            //先删除其他面板的子视图
            //删除地点面板元素
            if([self.filterMaskBgView viewWithTag:POSITION_PANEL]){
                [[self.filterMaskBgView viewWithTag:POSITION_PANEL] removeFromSuperview];
            }
            //删除公司面板元素
            if([self.filterMaskBgView viewWithTag:COMPANY_PANEL]){
                [[self.filterMaskBgView viewWithTag:COMPANY_PANEL] removeFromSuperview];
            }
            //删除要求面板元素
            if([self.filterMaskBgView viewWithTag:CONDITION_PANEL]){
                [[self.filterMaskBgView viewWithTag:CONDITION_PANEL] removeFromSuperview];
            }
            
            if([self.filterMaskBgView viewWithTag:RECOMMEND_PANEL]) return;
            
            [[PageSegmentMgr getInstance] selectStrategy:[RecommendStrategy getInstanceWithWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 80)]];
            [[PageSegmentMgr getInstance] showLayout:self.filterMaskBgView withTag:RECOMMEND_PANEL];
            
            //[[RecommendStrategy getInstanceWithWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 80)] showLayout:self.filterMaskBgView withTag:RECOMMEND_PANEL];
            
            
            
//            UIView* bgLayout = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 80)];
//            bgLayout.tag = RECOMMEND_PANEL;
//            bgLayout.backgroundColor = [UIColor whiteColor];
//            [self.filterMaskBgView addSubview:bgLayout];
//            
//            UIButton* recommendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 40)];
//            //recommendBtn.backgroundColor = [UIColor whiteColor];
//            recommendBtn.tag = NEW_RECOMMEND_BUTTON;
//            [recommendBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            UILabel* recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 30, 40)];
//            recommendLabel.text = @"推荐";
//            recommendLabel.textColor = [UIColor grayColor];
//            recommendLabel.font = [UIFont systemFontOfSize:14];
//            [recommendBtn addSubview:recommendLabel];
//            
//            UIButton* NewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,40, SCREEN_WIDTH, 40)];
//            //NewBtn.backgroundColor = [UIColor whiteColor];
//            NewBtn.tag = NEW_NEW_BUTTON;
//            [NewBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            UILabel* newLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 30, 40)];
//            newLabel.text = @"最新";
//            newLabel.textColor = [UIColor grayColor];
//            newLabel.font = [UIFont systemFontOfSize:14];
//            [NewBtn addSubview:newLabel];
//            
//            [bgLayout addSubview:recommendBtn];
//            [bgLayout addSubview:NewBtn];
            
            
            
        
        }
            break;
            
        case 1:{
            
            //删除推荐面板元素
            if([self.filterMaskBgView viewWithTag:RECOMMEND_PANEL]){
                [[self.filterMaskBgView viewWithTag:RECOMMEND_PANEL] removeFromSuperview];
            }
            //删除公司面板元素
            if([self.filterMaskBgView viewWithTag:COMPANY_PANEL]){
                [[self.filterMaskBgView viewWithTag:COMPANY_PANEL] removeFromSuperview];
            }
            //删除要求面板元素
            if([self.filterMaskBgView viewWithTag:CONDITION_PANEL]){
                [[self.filterMaskBgView viewWithTag:CONDITION_PANEL] removeFromSuperview];
            }

            if([self.filterMaskBgView viewWithTag:POSITION_PANEL]) return;
            
            [[PageSegmentMgr getInstance] selectStrategy:[PositionStrategy getInstanceWithWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 270)]];
            [[PageSegmentMgr getInstance] showLayout:self.filterMaskBgView withTag:POSITION_PANEL];
            
//            [self loadAreaRes];
//            
//            
//            UIView* bgLayout = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 270)];
//            bgLayout.tag = POSITION_PANEL;
//            bgLayout.backgroundColor = [UIColor whiteColor];
//            [self.filterMaskBgView addSubview:bgLayout];
//            
//            
//            //添加商圈筛选按钮
//            UIButton* businessBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH / 2, 40)];
//            businessBtn.backgroundColor = [UIColor whiteColor];
//            businessBtn.tag = POS_BUSINESS_CIRCLE_BUTTON;
//            [businessBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
//            [bgLayout addSubview:businessBtn];
//            
//            UIImageView* businessImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4 - 15 / 2 - 30 / 2, 13, 15, 15)];
//            
//            [businessImg setImage:[UIImage imageNamed:@"ic_filter_district_on.png"]];
//            businessImg.contentMode = UIViewContentModeScaleAspectFit;
//            [businessBtn addSubview:businessImg];
//            
//            UILabel* businessLabel = [[UILabel alloc] initWithFrame:CGRectMake(businessImg.center.x + 15, 0, 30, 40)];
//            businessLabel.text = @"商圈";
//            businessLabel.textColor = [UIColor greenColor];
//            businessLabel.font = [UIFont systemFontOfSize:14];
//            [businessBtn addSubview:businessLabel];
//
//            //添加下划线
//            UIImageView* bootomLine = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4 - 40, 37, 80, 3)];
//            [bootomLine setBackgroundColor:[UIColor greenColor]];
//            bootomLine.tag = POS_BOTTOM_LINE;
//            [businessBtn addSubview:bootomLine];
//            
//            
//            //添加地铁筛选按钮
//            UIButton* metroBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0.0, SCREEN_WIDTH / 2, 40)];
//            metroBtn.backgroundColor = [UIColor whiteColor];
//            metroBtn.tag = POS_METRO_BUTTON;
//            [metroBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
//            [bgLayout addSubview:metroBtn];
//            
//            UIImageView* metroImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4 - 15 / 2 - 30 / 2, 13, 15, 15)];
//            
//            [metroImg setImage:[UIImage imageNamed:@"ic_filter_district_on.png"]];
//            metroImg.contentMode = UIViewContentModeScaleAspectFit;
//            [metroBtn addSubview:metroImg];
//            
//            UILabel* metroLabel = [[UILabel alloc] initWithFrame:CGRectMake(metroImg.center.x + 15, 0, 30, 40)];
//            metroLabel.text = @"地铁";
//            metroLabel.textColor = [UIColor grayColor];
//            metroLabel.font = [UIFont systemFontOfSize:14];
//            [metroBtn addSubview:metroLabel];
//            
//            
//            self.leftFilterListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40,  SCREEN_WIDTH *2 / 5, 225)];
//            self.leftFilterListView.tag = LEFT_TABLEVIEW;
//            self.leftFilterListView.delegate = self;
//            self.leftFilterListView.dataSource = self;
//            self.leftFilterListView.separatorStyle = UITableViewCellSeparatorStyleNone;
//            [self.leftFilterListView layoutIfNeeded];
//            [bgLayout addSubview:self.leftFilterListView];
//            
//            //添加右侧筛选条件
//            //加载默认的筛选数据
//            if([self.rightDataSource count] <= 0){
//                [self.rightDataSource addObjectsFromArray:[self getDetailAreaOrMetroLineInfo:@"上海"]];
//            }
//            
//            self.rightFilterListView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *2 / 5, 40,  SCREEN_WIDTH * 3 / 5, 225)];
//            self.rightFilterListView.tag = RIGHT_TABLEVIEW;
//            self.rightFilterListView.delegate = self;
//            self.rightFilterListView.dataSource = self;
//            self.rightFilterListView.separatorStyle = UITableViewCellSeparatorStyleNone;
//            [self.rightFilterListView layoutIfNeeded];
//            [bgLayout addSubview:self.rightFilterListView];
//            
//            
//            
//            //添加重置确定按钮
//            
//            UIButton* resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 265, SCREEN_WIDTH / 2, 40.0)];
//            resetBtn.tag = RESET_BUTTON;
//            [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
//            resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//            [resetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            resetBtn.backgroundColor = [UIColor whiteColor];
//            [resetBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
//            [bgLayout addSubview:resetBtn];
//            
//            
//            UIButton* confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 265, SCREEN_WIDTH / 2, 40.0)];
//            confirmBtn.tag = CONFIRM_BUTTON;
//            [confirmBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
//            [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
//            confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//            confirmBtn.titleLabel.textColor = [UIColor whiteColor];
//            confirmBtn.backgroundColor = [UIColor greenColor];
//            [bgLayout addSubview:confirmBtn];
            
            
            
        }
            break;
            
        case 2:{
            
            //删除推荐面板元素
            if([self.filterMaskBgView viewWithTag:RECOMMEND_PANEL]){
                [[self.filterMaskBgView viewWithTag:RECOMMEND_PANEL] removeFromSuperview];
            }
            //删除地点面板元素
            if([self.filterMaskBgView viewWithTag:POSITION_PANEL]){
                [[self.filterMaskBgView viewWithTag:POSITION_PANEL] removeFromSuperview];
            }
            //删除要求面板元素
            if([self.filterMaskBgView viewWithTag:CONDITION_PANEL]){
                [[self.filterMaskBgView viewWithTag:CONDITION_PANEL] removeFromSuperview];
            }
            
            if([self.filterMaskBgView viewWithTag:COMPANY_PANEL]) return;
            
            [[PageSegmentMgr getInstance] selectStrategy:[CompanyStrategy getInstanceWithWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 270)]];
            [[PageSegmentMgr getInstance] showLayout:self.filterMaskBgView withTag:COMPANY_PANEL];
            
            //[self loadCompanyFilterData];
            
            
        }
            break;
    
    }
    

}

-(void) loadAreaRes{
    
    if(!self.areaOrMetroLineArray || [self.areaOrMetroLineArray count] == 0){
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Area" ofType:@"plist"];
        NSArray* dataSets = [NSArray arrayWithContentsOfFile:path];
        
        self.leftDataSource = [NSMutableArray array];
        
        for (NSDictionary *dict in dataSets) {
            
            CityOrMetroModel *myModel = [CityOrMetroModel modelWithDict:dict];
            [self.areaOrMetroLineArray addObject:myModel];
            
            [dict enumerateKeysAndObjectsUsingBlock:^(NSString* key, id values, BOOL * _Nonnull stop) {
                
                if([key isEqualToString:@"name"]){
                    
                    [self.leftDataSource addObject:values];
                }
                NSLog(@"418---------key :%@  value:%@",key,values);
            }];
            
            
        }
    }
}

-(NSMutableArray*) getDetailAreaOrMetroLineInfo:(NSString*) keyValue{
    
    if(!self.areaOrMetroLineArray || [self.areaOrMetroLineArray count] <= 0) return nil;

    NSMutableArray* tmpArray = [NSMutableArray array];
    

    for (CityOrMetroModel* cityMetro in self.areaOrMetroLineArray) {
        
        if([[cityMetro areaOrMetroLineName] isEqualToString:keyValue]){
        
            [tmpArray addObjectsFromArray:[cityMetro areasOrMetroLineArr]];
        }
    }

    
    return tmpArray;


}

-(void) loadCompanyFilterData{
    
    //删除推荐面板元素
    if([self.filterMaskBgView viewWithTag:RECOMMEND_PANEL]){
        [[self.filterMaskBgView viewWithTag:RECOMMEND_PANEL] removeFromSuperview];
    }
    //删除地点面板元素
    if([self.filterMaskBgView viewWithTag:POSITION_PANEL]){
        [[self.filterMaskBgView viewWithTag:POSITION_PANEL] removeFromSuperview];
    }
    //删除要求面板元素
    if([self.filterMaskBgView viewWithTag:CONDITION_PANEL]){
        [[self.filterMaskBgView viewWithTag:CONDITION_PANEL] removeFromSuperview];
    }

    if([self.filterMaskBgView viewWithTag:COMPANY_PANEL]) return;
    
    UIView* bgLayout = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 270)];
    bgLayout.tag = COMPANY_PANEL;
    bgLayout.backgroundColor = [UIColor whiteColor];
    [self.filterMaskBgView addSubview:bgLayout];
    
    //添加融资阶段组：
    PaddingLabel* conllectMoneyLabel = [[PaddingLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    conllectMoneyLabel.tag = CONLLECT_MONEY_STEP;
    conllectMoneyLabel.text = @"融资阶段";
    conllectMoneyLabel.textColor = [UIColor grayColor];
    conllectMoneyLabel.font = [UIFont systemFontOfSize:12.0f];
    conllectMoneyLabel.backgroundColor = [UIColor whiteColor];
    conllectMoneyLabel.padding = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f);
    [bgLayout addSubview:conllectMoneyLabel];
    
    [conllectMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.filterMaskBgView.mas_top);
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
    [bgLayout addSubview:flowButtonView];

    // 设置约束，不需要设置高度相关的约束
    [flowButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(conllectMoneyLabel).offset(conllectMoneyLabel.frame.size.height);
        make.left.equalTo(bgLayout.mas_left);
        make.right.equalTo(bgLayout.mas_right);
    }];


}



//-------------------laz load satrt----------------
- (NSArray *)areaOrMetroLineArray{
    if (!_areaOrMetroLineArray) {
        _areaOrMetroLineArray = [NSMutableArray array];
    }
    return _areaOrMetroLineArray;
}

-(NSMutableArray*) rightDataSource{
    
    if(!_rightDataSource){
        _rightDataSource = [NSMutableArray array];
    }
    return _rightDataSource;

}

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

//-------------------laz load end------------------


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

/**
 处理筛选过滤条件的手势事件

 @param sender 手势对象
 */
- (void)handleMaskViewGesture:(UIGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"X:%f  Y:%f",point.x,point.y);
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

-(void) initJobListView{
    
    self.jobDataSource = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 5; i++) {
        
        [self.jobDataSource addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    self.jobListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105,  SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.jobListView.tag = JOB_TABLEVIEW;
    self.jobListView.delegate = self;
    self.jobListView.dataSource = self;
    [self.jobListView layoutIfNeeded];
    [self.view addSubview:self.jobListView];
}


#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(tableView.tag){
            
        case JOB_TABLEVIEW:
            return self.jobDataSource.count;
            
        case LEFT_TABLEVIEW:
            
            return self.leftDataSource.count;
            
        case RIGHT_TABLEVIEW:
            
            return self.rightDataSource.count;
            
        default:
            return 0;
            
    }
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (tableView.tag) {
            
        case JOB_TABLEVIEW:{
            
            JobCell* cell = [[JobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JobItem"];
            
            [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150.0)];
            
            cell.backgroundColor = [UIColor greenColor];
            
            NSString* data = ((NSString* )self.jobDataSource[indexPath.row]);
            
            cell.textLabel.text = data;
            
            return cell;
        }
            
        case LEFT_TABLEVIEW:{
            
            PosLeftFilterCell* cell = [[PosLeftFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeftFilterItem"];
            
            NSString* data = ((NSString* )self.leftDataSource[indexPath.row]);
            
            cell.textLabel.text = data;
            
            return cell;
        }
            
        case RIGHT_TABLEVIEW:{
            
            PosLeftFilterCell* cell = [[PosLeftFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RightFilterItem"];
            
            NSString* data = ((NSString* )self.rightDataSource[indexPath.row]);
            
            cell.textLabel.text = data;
            cell.backgroundColor = [UIColor grayColor];
            
            return cell;
        }

            

            
            
        default:
            return nil;
    }
    
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (tableView.tag) {
        case JOB_TABLEVIEW:
            NSLog(@"455-----------");
            break;
            
        case LEFT_TABLEVIEW:{
            
            [self.rightDataSource removeAllObjects];
            
            [self.rightDataSource addObjectsFromArray:[self getDetailAreaOrMetroLineInfo:[self.leftDataSource objectAtIndex:indexPath.row]]];
            
            [self.rightFilterListView reloadData];
        }
            break;
        
        default:
            break;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (tableView.tag) {
        case JOB_TABLEVIEW:
            return 150.0;
            
        
        case LEFT_TABLEVIEW:
        case RIGHT_TABLEVIEW:
            return 45.0;
           
            
        default:
            return 0;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
