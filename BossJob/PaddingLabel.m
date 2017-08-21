//
//  PaddingLabel.m
//  BossJob
//
//  Created by liuxiaobing on 20/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import "PaddingLabel.h"

@implementation PaddingLabel


//@override
- (instancetype)init {
    if (self = [super init]) {
        _padding = UIEdgeInsetsZero;
    }
    return self;
}

//@override
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _padding = UIEdgeInsetsZero;
    }
    return self;
}

//@override
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _padding)];
}


@end
