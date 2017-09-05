//
//  ComAbstractView.m
//  BossJob
//
//  Created by 刘小兵 on 2017/9/4.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ComAbstractView.h"
#import "ComIntroductCell.h"
#import "Constants.h"

#import "ComAbstractModel.h"

@interface ComAbstractView ()

@property(nonatomic,strong) ComIntroductCell* cell;

@end

@implementation ComAbstractView


-(instancetype) initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
    }
    return self;
    
}

//@override method
-(void) initAttr{
    
    [super initAttr];
    
    
    //测试代码
    ComAbstractModel* model = [[ComAbstractModel alloc] init];
    model.expaned = false;
    model.cellHeight = 150.0f;
    [self.dataList addObject:model];
}

//@override method
//-(BaseTabViewCell*) buildTableViewCell{
//    
//    return nil;
//    
//}


//override method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.cell = [[ComIntroductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ComIntroductCell"];
    

    ComAbstractModel *object = (ComAbstractModel *)self.dataList[indexPath.row];
    self.cell.expend = object.expaned;
    
    [self.cell bindData:object];
    
    
    return self.cell;

}

//@override method
//-(CGFloat) getCellHeight{
//    
//    return 0.0f;
//}

//@override method
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    ComAbstractModel *object = (ComAbstractModel *)self.dataList[indexPath.row];
    return object.expaned ? object.cellHeight : 150.0f;
}


//@override method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    ComAbstractModel *object = (ComAbstractModel *)self.dataList[indexPath.row];
    object.expaned = !object.expaned;
    
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

@end
