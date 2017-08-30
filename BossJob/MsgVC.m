//
//  MsgVC.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/17.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "MsgVC.h"
#import "Constants.h"
#import "Masonry.h"
#import "ScrollNavBar.h"
#import "InterestedInMeView.h"
#import "HasCheckMeView.h"

@interface MsgVC ()

@end

@implementation MsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initNavBar{
    
    UIView* topNavBarLayout = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 45)];
    topNavBarLayout.backgroundColor = [UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0];
    [self.view addSubview:topNavBarLayout];
    
    NSArray *array = [NSArray arrayWithObjects:@"聊天",@"互动", nil];
    self.navSegment = [[UISegmentedControl alloc]initWithItems:array];
    self.navSegment.selectedSegmentIndex = 0;
    self.navSegment.tintColor = [UIColor whiteColor];
    [self.navSegment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [topNavBarLayout addSubview:self.navSegment];
    
    [self.navSegment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100.0, 30.0));
        make.centerY.equalTo(topNavBarLayout);
        make.centerX.equalTo(topNavBarLayout);
        
    }];
    
    self.segmentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 65.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.segmentScroll.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT);
    self.segmentScroll.alwaysBounceHorizontal = YES;
    self.segmentScroll.pagingEnabled = YES;
    [self.view addSubview:self.segmentScroll];
    
    //使用kvo来监听uiscroll的滑动事件，代替它的协议接口
    //添加注册实现contentOffset监听
    [self.segmentScroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

    
    //创建聊天背景视图
    UIView* chatBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.segmentScroll addSubview:chatBgView];
    chatBgView.backgroundColor = [UIColor whiteColor];
    
    //创建互动视图
    UIView* interactBgView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.segmentScroll addSubview:interactBgView];
    interactBgView.backgroundColor = [UIColor whiteColor];
    
    
    ScrollNavBar* scrollNavBarView = [[ScrollNavBar alloc] initWithFrame:CGRectMake(0.0f, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSMutableArray* title = [NSMutableArray arrayWithObjects:@"对我感兴趣",@"看过我",@"新职位", nil];
    [scrollNavBarView iniTitles:title];
    
    //创建中间滚动视图
    InterestedInMeView* interestedView = [[InterestedInMeView alloc] initWithFrame:CGRectMake(0.0f, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    interestedView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    HasCheckMeView* chkMeView = [[HasCheckMeView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    chkMeView.separatorInset = UIEdgeInsetsMake(0,10,0,10);  //top left right down
    chkMeView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];  //删除底部多余行，及分割线
    NSMutableArray* layout = [NSMutableArray arrayWithObjects:interestedView,chkMeView,nil];
    [scrollNavBarView initSegmentView:layout];
    

    
    
    [interactBgView addSubview:scrollNavBarView];

}

- (void)segmentChange:(UISegmentedControl *)sgc{
   
    NSLog(@"%ld", sgc.selectedSegmentIndex);
    [self.segmentScroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH * sgc.selectedSegmentIndex, 65.0, SCREEN_WIDTH, SCREEN_HEIGHT) animated:NO];
}

//-------------------kvo 实现观察主题 ----------------
//对于滑动翻页使用kvo监听机制
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
    CGPoint oldOffset = [change[NSKeyValueChangeOldKey] CGPointValue];
    CGFloat oldOffsetX = oldOffset.x;
    CGFloat deltaOfOffsetX = offset.x - oldOffsetX;
    
    if(deltaOfOffsetX == 0){
        self.navSegment.selectedSegmentIndex = 0;
    }
    if(deltaOfOffsetX == SCREEN_WIDTH){
        self.navSegment.selectedSegmentIndex = 1;
    }
    
    
}

-(void)dealloc{
    [self.segmentScroll removeObserver:self forKeyPath:@"contentOffset" context:nil];
}
//-------------------kvo 实现观察主题 end----------------

@end
