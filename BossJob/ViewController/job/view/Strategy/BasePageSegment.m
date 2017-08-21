//
//  BasePageSegment.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "BasePageSegment.h"

@interface BasePageSegment ()

@end

@implementation BasePageSegment



-(void) showLayout:(UIView*) parentView withTag:(NSInteger) tag{

   
    
    self.tag = tag;
    self.backgroundColor = [UIColor whiteColor];

    UILabel* testLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 25, self.frame.size.height / 2 - 20, 50.0f, 40.0f)];
    
    testLabel.text = @"俺是策略基类，快去扩展吧";
    
    [self addSubview:testLabel];
    [parentView addSubview:self];
}

@end
