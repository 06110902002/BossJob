//
//  JobCell.m
//  BossJob
//
//  Created by liuxiaobing on 20/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import "JobCell.h"

@implementation JobCell

//override 重载设置边框达到设置单元格分组效果
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

@end
