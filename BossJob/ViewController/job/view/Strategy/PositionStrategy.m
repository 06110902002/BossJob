//
//  PositionStrategy.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "PositionStrategy.h"
#import "Constants.h"
#import "CityOrMetroModel.h"
#import "PosLeftFilterCell.h"


static const int POS_BUSINESS_CIRCLE_BUTTON = 6;
static const int POS_METRO_BUTTON = 7;
static const int POS_BOTTOM_LINE = 8;
static const int LEFT_TABLEVIEW = 9;
static const int RIGHT_TABLEVIEW = 10;
static const int RESET_BUTTON = 12;
static const int CONFIRM_BUTTON = 13;

static PositionStrategy* positionStrategy = nil;

static const int NEW_RECOMMEND_BUTTON = 4;
static const int NEW_NEW_BUTTON = 5;

@interface PositionStrategy ()

@end

@implementation PositionStrategy



+(instancetype) getInstanceWithWithFrame:(CGRect)frame{
    
    @synchronized (self) {
        
        if(positionStrategy == nil){
            
            positionStrategy = [[PositionStrategy alloc] initWithFrame:frame];
        }
    }
    return positionStrategy;
    
    
}


//override method
-(void) showLayout:(UIView*) parentView withTag:(NSInteger) tag{
    
    if(!positionStrategy) return;
    
    positionStrategy.tag = tag;
    positionStrategy.backgroundColor = [UIColor whiteColor];
    [parentView addSubview:positionStrategy];
    
    if([positionStrategy subviews].count) return;
    
    [self loadAreaRes];

    
    
    //添加商圈筛选按钮
    UIButton* businessBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH / 2, 40)];
    businessBtn.backgroundColor = [UIColor whiteColor];
    businessBtn.tag = POS_BUSINESS_CIRCLE_BUTTON;
    [businessBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [positionStrategy addSubview:businessBtn];
    
    UIImageView* businessImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4 - 15 / 2 - 30 / 2, 13, 15, 15)];
    
    [businessImg setImage:[UIImage imageNamed:@"ic_filter_district_on.png"]];
    businessImg.contentMode = UIViewContentModeScaleAspectFit;
    [businessBtn addSubview:businessImg];
    
    UILabel* businessLabel = [[UILabel alloc] initWithFrame:CGRectMake(businessImg.center.x + 15, 0, 30, 40)];
    businessLabel.text = @"商圈";
    businessLabel.textColor = [UIColor greenColor];
    businessLabel.font = [UIFont systemFontOfSize:14];
    [businessBtn addSubview:businessLabel];
    
    //添加下划线
    UIImageView* bootomLine = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4 - 40, 37, 80, 3)];
    [bootomLine setBackgroundColor:[UIColor greenColor]];
    bootomLine.tag = POS_BOTTOM_LINE;
    [businessBtn addSubview:bootomLine];
    
    
    //添加地铁筛选按钮
    UIButton* metroBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0.0, SCREEN_WIDTH / 2, 40)];
    metroBtn.backgroundColor = [UIColor whiteColor];
    metroBtn.tag = POS_METRO_BUTTON;
    [metroBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [positionStrategy addSubview:metroBtn];
    
    UIImageView* metroImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4 - 15 / 2 - 30 / 2, 13, 15, 15)];
    
    [metroImg setImage:[UIImage imageNamed:@"ic_filter_district_on.png"]];
    metroImg.contentMode = UIViewContentModeScaleAspectFit;
    [metroBtn addSubview:metroImg];
    
    UILabel* metroLabel = [[UILabel alloc] initWithFrame:CGRectMake(metroImg.center.x + 15, 0, 30, 40)];
    metroLabel.text = @"地铁";
    metroLabel.textColor = [UIColor grayColor];
    metroLabel.font = [UIFont systemFontOfSize:14];
    [metroBtn addSubview:metroLabel];
    
    
    self.leftFilterListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40,  SCREEN_WIDTH *2 / 5, 225)];
    self.leftFilterListView.tag = LEFT_TABLEVIEW;
    self.leftFilterListView.delegate = self;
    self.leftFilterListView.dataSource = self;
    self.leftFilterListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.leftFilterListView layoutIfNeeded];
    [positionStrategy addSubview:self.leftFilterListView];
    
    //添加右侧筛选条件
    //加载默认的筛选数据
    if([self.rightDataSource count] <= 0){
        [self.rightDataSource addObjectsFromArray:[self getDetailAreaOrMetroLineInfo:@"上海"]];
    }
    
    self.rightFilterListView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH *2 / 5, 40,  SCREEN_WIDTH * 3 / 5, 225)];
    self.rightFilterListView.tag = RIGHT_TABLEVIEW;
    self.rightFilterListView.delegate = self;
    self.rightFilterListView.dataSource = self;
    self.rightFilterListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.rightFilterListView layoutIfNeeded];
    [positionStrategy addSubview:self.rightFilterListView];
    
    
    
    //添加重置确定按钮
    
    UIButton* resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 265, SCREEN_WIDTH / 2, 40.0)];
    resetBtn.tag = RESET_BUTTON;
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [resetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    resetBtn.backgroundColor = [UIColor whiteColor];
    [resetBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [positionStrategy addSubview:resetBtn];
    
    
    UIButton* confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 265, SCREEN_WIDTH / 2, 40.0)];
    confirmBtn.tag = CONFIRM_BUTTON;
    [confirmBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = [UIColor greenColor];
    [positionStrategy addSubview:confirmBtn];
    
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
-(void)onClickListener:(UIButton*) sender{
    
    switch(sender.tag){
    
        case RESET_BUTTON:{}break;
            
        case CONFIRM_BUTTON:{}break;
    
    }
    
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(tableView.tag){
            
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
       
        case LEFT_TABLEVIEW:
        case RIGHT_TABLEVIEW:
            return 45.0;
            
            
        default:
            return 0;
    }
    
}



@end
