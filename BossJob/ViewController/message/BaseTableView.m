//
//  BaseTableView.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/29.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "BaseTableView.h"
#import "Constants.h"
#import "BaseModel.h"
#import "BaseTabViewCell.H"

@implementation BaseTableView

-(instancetype) initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
    
        [self initAttr];
    
    }
    return self;

}

-(void) initAttr{

    self.dataList = [NSMutableArray array];
    
//    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,  SCREEN_WIDTH, SCREEN_HEIGHT)];
//    self.mTableView.backgroundColor = [UIColor colorWithRed:235.0 / 255.0 green:238.0/255.0 blue:237.0/255.0 alpha:1.0];
//    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.mTableView.delegate = self;
//    self.mTableView.dataSource = self;
//    [self.mTableView layoutIfNeeded];
//    [self addSubview:self.mTableView];
    
   
    self.backgroundColor = [UIColor colorWithRed:235.0 / 255.0 green:238.0/255.0 blue:237.0/255.0 alpha:1.0];
    self.delegate = self;
    self.dataSource = self;
    [self layoutIfNeeded];
}

-(BaseTabViewCell*) buildTableViewCell{

    NSLog(@"这里必须重载");
    return nil;
}

-(CGFloat) getCellHeight{

    return 0.0f;
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataList count];

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BaseTabViewCell* cell = [self buildTableViewCell];
    
    [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self getCellHeight])];
    
    cell.backgroundColor = [UIColor colorWithRed:235.0 / 255.0 green:238.0/255.0 blue:237.0/255.0 alpha:1.0];
    
    BaseModel* data = ((BaseModel* )self.dataList[indexPath.row]);
    
    [cell bindData:data];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self getCellHeight];
}
//-------------------uitableView 协议方法结束-----------------------

@end
