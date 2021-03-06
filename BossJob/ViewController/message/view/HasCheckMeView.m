//
//  HasCheckMeView.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/30.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "HasCheckMeView.h"
#import "HasCheckMeCell.h"

#import "ChkMeOrNewJobModel.h"

@implementation HasCheckMeView




-(instancetype) initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
    }
    return self;
    
}

//@override method
-(void) initAttr{
    
    [super initAttr];
    
    for(int i = 0 ; i < 9; i++){
        
        ChkMeOrNewJobModel* model = [[ChkMeOrNewJobModel alloc] init];
        model.sHR_JobTitle = @"数连金融 CTO";
        model.sJobTitle_Company = @"招聘 COCOS2D";
        model.sCompanyExp = @"经验不限";
        model.sCompanyEdu = @"本科";
        model.sSalary = @"40k-90k";
        
        [self.dataList addObject:model];
        
        
    }
    
    
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
