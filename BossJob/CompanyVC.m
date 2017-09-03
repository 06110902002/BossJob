//
//  CompanyVC.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/17.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "CompanyVC.h"
#import "Masonry.h"
#import "Constants.h"
#import "FilterNavBar.h"
#import "CompanyFilterView.h"
#import "JobCell.h"
#import "JobItemModel.h"
#import "ComAbstractTableVC.h"
#import "ScrollSegmentVC.h"



static const int SEARCH_BUTTON = 21;
static const int FILTER_PANEL = 22;

@interface CompanyVC ()<FilterChangeListener,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    [self initFilterNavBar];
    [self initCompanyListView];
}


-(void) initNavBar{
    
    
    UIView* topNavBarLayout = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 45)];
    topNavBarLayout.backgroundColor = [UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0];
    
    
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

//private method
//初始化筛选导航栏
-(void) initFilterNavBar{
    
    NSMutableArray* title = [NSMutableArray arrayWithObjects:@"融资",@"规模",@"行业", nil];
    
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

-(void) initCompanyListView{
    
    
    self.companyDataList = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 5; i++) {
        
        JobItemModel* jobData = [[JobItemModel alloc] init];
        
        jobData.sJobTitle = @"桃花岛";
        jobData.sSalary = @"10k-50k";
        jobData.sCompanyName = @"桃花影落飞神剑";
        jobData.sConllectMoneyStep = @"落英神掌";
        jobData.sCompanyAddress = @"南宋 临安 桃桦岛";
        jobData.sCompanyExp = @"1-3年";
        jobData.sCompanyEdu = @"不限";
        jobData.sContactName = @"黄药师";
        jobData.sContactLevel = @"桃花岛主";
        
        [self.companyDataList addObject:jobData];
    }

    
    self.companyListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105,  SCREEN_WIDTH, SCREEN_HEIGHT-150.0)];
    self.companyListView.backgroundColor = [UIColor colorWithRed:235.0 / 255.0 green:238.0/255.0 blue:237.0/255.0 alpha:1.0];
    self.companyListView.delegate = self;
    self.companyListView.dataSource = self;
    [self.companyListView layoutIfNeeded];
    [self.view addSubview:self.companyListView];
    
}

/**
 处理所有按钮的点击事件
 
 @param sender 发送事件的对象
 */
-(void)onClickListener:(UIButton*) sender{
    
    switch (sender.tag) {
        case SEARCH_BUTTON:
            NSLog(@"62----------：SEARCH_BUTTON");
            break;
            
        default:
            break;
    }
    
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
    
    CompanyFilterView* companyFileView = [CompanyFilterView getInstanceWithWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 200)];
    
    if(![self.filterMaskBgView viewWithTag:FILTER_PANEL]){
        
        [companyFileView add2ParentView:self.filterMaskBgView withTag:FILTER_PANEL];
    }
     [companyFileView showFilterLayout:[self getFilterDataList:index] withType:index];
    
    return;
}

-(NSArray*) getFilterDataList:(NSInteger) type{

    NSArray* tmpList = nil;
    switch(type){
            
        case 0:{
            tmpList =  @[@"全部",@"未融资",@"天使轮",@"A轮",@"B轮",@"C轮",@"D轮及以上",@"已上市",@"不需要融资"];
        }
            break;
        
        case 1:{
            tmpList =  @[@"全部",@"0-20人",@"20-99人",@"100-499人",@"500-999人",@"1000-9999",@"10000人以上"];
        }
            break;
        
        case 2:{
            tmpList =  @[@"全部",@"非互联网行业",@"健康医疗",@"生活服务",@"旅游",@"金融",@"信息安全",
                         @"广告营销",@"数据服务",@"智能硬件",@"文件娱乐",@"网络招聘",@"分类信息",@"电子商务",
                         @"移动互联网",@"企业服务",@"社交网络",@"教育培训",@"O2O",@"游戏",@"互联网",
                         @"媒体",@"IT软件"];
        }
            break;
    }
    return tmpList;

}

/**
 处理筛选过滤条件的手势事件
 
 @param sender 手势对象
 */
- (void)handleMaskViewGesture:(UIGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.filterMaskBgView];
    NSLog(@"X:%f  Y:%f  self.nCurPageIndex:  %ld",point.x,point.y,(long)self.nCurPageIndex);
    switch(self.nCurPageIndex){
            
        case 0:
        case 1:{
            
            if(point.y >= 165){
                [self closeFilterMaskLayer];
            }
            
        }break;
            
        case 2:{
            
            if(point.y >= 365){
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
        
        [self.filterMaskBgView removeFromSuperview];
        self.filterMaskBgView = nil;
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.companyDataList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JobCell* cell = [[JobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JobItem"];
    
    [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150.0)];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    JobItemModel* data = ((JobItemModel* )self.companyDataList[indexPath.row]);
    
    [cell bindData:data];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ComAbstractTableVC *table = [[ComAbstractTableVC alloc] init];
    //    CollectionViewController *collectionView = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
    
   // ComAbstractTableVC *table1 = [[ComAbstractTableVC alloc] initWithNibName:@"TableViewController" bundle:nil];
    
    ScrollSegmentVC *pager = [[ScrollSegmentVC alloc] init];
    [pager setViewControllers:@[table,table]];
    pager.segmentMiniTopInset = 64;
    pager.headerHeight = 200;
    pager.freezenHeaderWhenReachMaxHeaderHeight = YES;
   
    
    //观察标题的变化
    //[self.pager addObserver:self forKeyPath:@"segmentTopInset" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    [self presentModalViewController:pager  animated: YES ];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   return 150.0;
}




@end
