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
#import "PosRightFilterCell.h"
#import "PosFilterModel.h"


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

    self.singalDelegate = self;
    
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
    self.rightFilterListView.backgroundColor = [UIColor colorWithRed:234.0 / 255.0 green:249.0 / 255.0 blue:249.0 / 255.0 alpha:1.0];
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
                    
                    PosFilterModel* data = [[PosFilterModel alloc] init];
                    data.sAddress = values;
                    [self.leftDataSource addObject:data];
                     //[self.leftDataSource addObject:values];
                }
                NSLog(@"418---------key :%@  value:%@",key,values);
            }];
            
            
        }
        
        //初始化时添加，第0项进来
        NSString* key = [(PosFilterModel*)[self.leftDataSource objectAtIndex:0] sAddress];
        //先清空地区--详细信息映射字典，再构建
        if(![self.area_detailDict objectForKey:key]){
            [self.area_detailDict setValue:[self getDetailAreaOrMetroLineInfo:key] forKey:key];
        }

    }
}

-(NSMutableArray*) getDetailAreaOrMetroLineInfo:(NSString*) keyValue{
    
    if(!self.areaOrMetroLineArray || [self.areaOrMetroLineArray count] <= 0) return nil;
    
    NSMutableArray* tmpArray = [NSMutableArray array];
    
    
    for (CityOrMetroModel* cityMetro in self.areaOrMetroLineArray) {
        
        if([[cityMetro areaOrMetroLineName] isEqualToString:keyValue]){
            
            //[tmpArray addObjectsFromArray:[cityMetro areasOrMetroLineArr]];
            
            [[cityMetro areasOrMetroLineArr ] enumerateObjectsUsingBlock:^(NSString* obj,NSUInteger idx,BOOL* stop){
                
                PosFilterModel* data = [[PosFilterModel alloc] init];
                data.sAddress = obj;
                [tmpArray addObject:data];
            }];
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
-(NSMutableDictionary*) area_detailDict{
    
    if(!_area_detailDict){
        _area_detailDict = [[NSMutableDictionary alloc] init];
    }
    return _area_detailDict;
}
//-------------------laz load end ----------------

-(void)onClickListener:(UIButton*) sender{
    
    switch(sender.tag){
    
        case RESET_BUTTON:{}break;
            
        case CONFIRM_BUTTON:{}break;
            
            
        case POS_BUSINESS_CIRCLE_BUTTON:{
            
            UIButton *businessBtn = (UIButton *)[positionStrategy viewWithTag:POS_BUSINESS_CIRCLE_BUTTON];
            
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
            UIButton *metroBtn = (UIButton *)[positionStrategy viewWithTag:POS_METRO_BUTTON];
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
            
            UIButton *metroBtn = (UIButton *)[positionStrategy viewWithTag:POS_METRO_BUTTON];
            
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
            UIButton *businessBtn = (UIButton *)[positionStrategy viewWithTag:POS_BUSINESS_CIRCLE_BUTTON];
            //修改文本为绿色
            UILabel* businessLabel = [(UILabel*) businessBtn subviews][1];
            businessLabel.textColor = [UIColor grayColor];
            
            //当大于3移除下划线
            if([[businessBtn subviews] count] >= 3){
                [[businessBtn subviews].lastObject removeFromSuperview];
            }
            
            
        }
            break;
    
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
            
            self.leftCell = [[PosLeftFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeftFilterItem"];
            
//            NSString* data = ((NSString* )self.leftDataSource[indexPath.row]);
//            
//            self.leftCell.textLabel.text = data;
            
            PosFilterModel* data = (PosFilterModel*)self.leftDataSource[indexPath.row];
            
            [self.leftCell bindData:data];
            
            return self.leftCell;
        }
            
        case RIGHT_TABLEVIEW:{
            
            self.rightCell = [[PosRightFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RightFilterItem"];
            
            //NSString* data = ((NSString* )self.rightDataSource[indexPath.row]);
            //cell.textLabel.text = data;
            
            PosFilterModel* data = (PosFilterModel*)self.rightDataSource[indexPath.row];
            
            [self.rightCell bindData:data];
            
            return  self.rightCell;
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
            
            NSString* key = [(PosFilterModel*)[self.leftDataSource objectAtIndex:indexPath.row] sAddress];
            [self.rightDataSource addObjectsFromArray:[self getDetailAreaOrMetroLineInfo:key]];
            [self.rightFilterListView reloadData];
            
            //先清空地区--详细信息映射字典，再构建
            if(![self.area_detailDict objectForKey:key]){
                [self.area_detailDict setValue:[self getDetailAreaOrMetroLineInfo:key] forKey:key];
            }
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

-(void) recycRes{
    
    if(self.rightCell){
        [self.rightCell recycRes];
    }
    
}

//--------------实现消息观察协议接口--主要用于左右2个uitableView 中cell中的状态更新-------------
-(NSString*) registerSubject:(NSString *)subject{
    
    return subject;

}

/**
 更新右边筛选框，打勾标志，更新逻辑如下：
 1.勾选第0项，本组其他项，均为不选中状态。
 2.勾选第1~n项,将勾选的项设置为选中状态，并将第0项，置为不勾选状态
 
 更新左边列表的逻辑为：
 1.右边勾选第0项，左边列表不显示选中条数
 2.右边勾选的是第1~n项，将选中的条数更新到左边去。
 
 以上更新状态由点击右边列表项发起

 @param msg 获取到的点击项
 */
-(void) update:(NSObject*) msg{

    //先处理右边列表选中项状态，获取到右边状态项之后再显示左边选中条数
    [self.rightDataSource enumerateObjectsUsingBlock:^(PosFilterModel* obj,NSUInteger idx,BOOL* stop){
    
        if([msg isEqual:[obj sAddress]]){
            
             NSLog(@"442------------UItableView收到的信息为:%@   在列表中的索引为:%ld",msg,idx);
            
            if(idx == 0){
                
                obj.select = !obj.select;
                NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:0];
                [self.rightFilterListView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
            
                for(int i = 1; i < [self.rightDataSource count]; i ++){
                    ((PosFilterModel*)self.rightDataSource[i]).select = NO;
                }
                
                [self.rightFilterListView reloadData];
                
                
            }else{
                
                ((PosFilterModel*)self.rightDataSource[0]).select = NO;     //处理第0个
                
                *stop = true;
                obj.select = !obj.select;
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:0];
                [self.rightFilterListView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                
                NSIndexPath *path0 = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.rightFilterListView reloadRowsAtIndexPaths:@[path0] withRowAnimation:UITableViewRowAnimationNone];
            }
            
            
            [self updateLeftListView:idx forKey:(NSString*)msg addTag:obj.select];
        }
    
    }];
    
}
//-----------------------------消息通知中心逻辑end--------------------------

/**
 更新左边列表选中状态：
 1.判断右边选中项在左边列表的索引
 2.选中为第0个时，左边筛选列表不显示选中条数
 3.将选中的item对象保存起来，方便发送请求到服务器去

 @param type 更新的位置索引，主要区别0与非0位置
 @param msg 点击右边传来的item内容
 @param bIsAdd 是否增加的开着标志
 */
-(void) updateLeftListView:(NSInteger) type forKey:(NSString*) msg addTag:(BOOL) bIsAdd{
    

    [self.area_detailDict enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSArray* list,BOOL * stop){
        
        [list enumerateObjectsUsingBlock:^(PosFilterModel* obj,NSUInteger idx,BOOL* stop2){
            
            if([obj.sAddress isEqualToString:msg]){
                
                
                //判断对应所在键，位于左边列表中的哪一个对象
                [self.leftDataSource enumerateObjectsUsingBlock:^(PosFilterModel* leftModel,NSUInteger leftIdx,BOOL *stop3){
                    
                    if([leftModel.sAddress isEqualToString:key]){
                        
                        self.selectModel = leftModel;
                        
                        if(type == 0){
                            
                            leftModel.selectCount = 0;
                            
                        }else{
                            
                            leftModel.selectCount = bIsAdd ? leftModel.selectCount + 1: leftModel.selectCount - 1;
                        }

                        
                        NSLog(@"532---------对应左边的对象为：%@",leftModel.sAddress);
                    }else{
                        leftModel.selectCount = 0;
                    }
                    [self.leftFilterListView reloadData];
                    
                }];
                
                NSLog(@" 519---------------item:%@  对应的键为: %@",msg,key);
            }
            
        }];
        
        
    }];
    
}



@end
