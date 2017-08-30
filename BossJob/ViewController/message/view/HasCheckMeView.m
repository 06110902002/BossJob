//
//  HasCheckMeView.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/30.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "HasCheckMeView.h"
#import "HasCheckMeCell.h"

#import "InterestedInMeModel.h"

@implementation HasCheckMeView




-(instancetype) initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
    }
    return self;
    
}

//@override method
-(void) initAttr{
    
    [super initAttr];
    
    InterestedInMeModel* model = [[InterestedInMeModel alloc] init];
    
    model.imgPath = @"";
    model.tips = @"还没有Boss对你感兴趣,快去主动\n联系吧!";
    
    [self.dataList addObject:model];
    
}

//@override method
-(BaseTabViewCell*) buildTableViewCell{
    
    return [[HasCheckMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HasCheckMeCell"];
}

//@override method
-(CGFloat) getCellHeight{
    
    return 70.0f;
}




@end
