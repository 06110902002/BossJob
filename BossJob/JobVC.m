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
#import "PageSegmentMgr.h"
#import "RecommendStrategy.h"
#import "PositionStrategy.h"
#import "CompanyStrategy.h"
#import "ConditionStrategy.h"
#import "JobItemModel.h"

static const int LEFT_BUTTON = 1;
static const int ADD_BUTTON = 2;
static const int SEARCH_BUTTON = 3;

static const int JOB_TABLEVIEW = 11;

static const int RECOMMEND_PANEL = 25;
static const int POSITION_PANEL = 26;
static const int COMPANY_PANEL = 27;
static const int CONDITION_PANEL = 28;

@implementation JobVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initNavBar];
    [self initFilterNavBar];
    [self initJobListView];

}

-(void) initNavBar{
    
    
    UIView* topNavBarLayout = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 45)];
    topNavBarLayout.backgroundColor = [UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0];
    
    
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
    
    self.nCurPageIndex = 0;
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
    
    self.nCurPageIndex = index;
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
            
            [[PageSegmentMgr getInstance] selectStrategy:[CompanyStrategy getInstanceWithWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 480)]];
            [[PageSegmentMgr getInstance] showLayout:self.filterMaskBgView withTag:COMPANY_PANEL];
            
           
        }
            break;
            
        case 3:{
            
            //删除推荐面板元素
            if([self.filterMaskBgView viewWithTag:RECOMMEND_PANEL]){
                [[self.filterMaskBgView viewWithTag:RECOMMEND_PANEL] removeFromSuperview];
            }
            //删除地点面板元素
            if([self.filterMaskBgView viewWithTag:POSITION_PANEL]){
                [[self.filterMaskBgView viewWithTag:POSITION_PANEL] removeFromSuperview];
            }
            //删除公司面板元素
            if([self.filterMaskBgView viewWithTag:COMPANY_PANEL]){
                [[self.filterMaskBgView viewWithTag:COMPANY_PANEL] removeFromSuperview];
            }
            
            if([self.filterMaskBgView viewWithTag:CONDITION_PANEL]) return;
            
            [[PageSegmentMgr getInstance] selectStrategy:[ConditionStrategy getInstanceWithWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 480)]];
            [[PageSegmentMgr getInstance] showLayout:self.filterMaskBgView withTag:CONDITION_PANEL];
            
            
        }
            break;

    
    }
    

}


/**
 处理筛选过滤条件的手势事件

 @param sender 手势对象
 */
- (void)handleMaskViewGesture:(UIGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.filterMaskBgView];
    NSLog(@"X:%f  Y:%f  self.nCurPageIndex:  %ld",point.x,point.y,(long)self.nCurPageIndex);
    switch(self.nCurPageIndex){
    
        case 0:{
            
            if(point.y >= 95){
                [self closeFilterMaskLayer];
            }
            
        }break;
            
        case 1:{
        
            if(point.y >= 313){
                
                [self closeFilterMaskLayer];
            }
        
        }break;
            
        case 2:
        case 3:{
            
            if(point.y >= 503){
                [self closeFilterMaskLayer];
            }
        
        }break;
            

    }
}

//private method
//关闭过滤蒙层
-(void) closeFilterMaskLayer{

    [self.filterMaskBgView.layer removeAllAnimations];
    [self.filterMaskBgView.layer addAnimation:self.closeAnim forKey:@"onClose"];

}



//laz load
-(CABasicAnimation*) closeAnim{

    if(!_closeAnim){
        _closeAnim = [CABasicAnimation animationWithKeyPath:@"position"];
        _closeAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.filterMaskBgView.layer.position.x, self.filterMaskBgView.layer.position.y)];
        _closeAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(self.filterMaskBgView.layer.position.x, -self.filterMaskBgView.frame.size.height)];
        _closeAnim.removedOnCompletion = NO;
        _closeAnim.fillMode = kCAFillModeForwards;
        _closeAnim.duration = 0.5;
        _closeAnim.delegate = self;
    }
    return _closeAnim;
}

#pragma mark - CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim{

}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if([self.filterMaskBgView.layer.animationKeys.lastObject isEqualToString:@"onClose"]){
        
        if([self.filterMaskBgView viewWithTag:POSITION_PANEL]){
            [(PositionStrategy*)[self.filterMaskBgView viewWithTag:POSITION_PANEL] recycRes];
        }
        
        [self.filterMaskBgView removeFromSuperview];
        self.filterMaskBgView = nil;
        
    }
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

-(void) initJobListView{
    
    self.jobDataSource = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 5; i++) {
        
        JobItemModel* jobData = [[JobItemModel alloc] init];
        
        jobData.sJobTitle = @"IOS";
        jobData.sSalary = @"10k-50k";
        jobData.sCompanyName = @"上海白泽网络科技有限公司";
        jobData.sConllectMoneyStep = @"A轮";
        jobData.sCompanyAddress = @"上海 浦东新区 广兰路";
        jobData.sCompanyExp = @"1-3年";
        jobData.sCompanyEdu = @"不限";
        jobData.sContactName = @"黄蓉";
        jobData.sContactLevel = @"桃花岛主之女";
        
        [self.jobDataSource addObject:jobData];
    }
    
    self.jobListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105,  SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.jobListView.backgroundColor = [UIColor colorWithRed:235.0 / 255.0 green:238.0/255.0 blue:237.0/255.0 alpha:1.0];
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
            
            
        default:
            return 0;
            
    }
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (tableView.tag) {
            
        case JOB_TABLEVIEW:{
            
            JobCell* cell = [[JobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JobItem"];
            
            [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150.0)];
            
            cell.backgroundColor = [UIColor whiteColor];
            
            JobItemModel* data = ((JobItemModel* )self.jobDataSource[indexPath.row]);
            
            [cell bindData:data];
            
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
        
        default:
            break;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (tableView.tag) {
        case JOB_TABLEVIEW:
            return 150.0;
            
        default:
            return 0;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
