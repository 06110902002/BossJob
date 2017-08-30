//
//  InterestedInMeView.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/30.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "InterestedInMeView.h"
#import "Constants.h"
#import "InterestedInMeCell.h"
#import "InterestedInMeModel.h"

@implementation InterestedInMeView

-(instancetype) initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
    }
    return self;
    
}

-(void) initAttr{
    
    [super initAttr];
    
    InterestedInMeModel* model = [[InterestedInMeModel alloc] init];
    
    model.imgPath = @"";
    model.tips = @"还没有Boss对你感兴趣,快去主动\n联系吧!";
    
    [self.dataList addObject:model];
    
}

-(BaseTabViewCell*) buildTableViewCell{
    
    return [[InterestedInMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InterestedInMeCell"];
;
}

-(CGFloat) getCellHeight{
    
    return SCREEN_HEIGHT - 150.0f;
}

@end
