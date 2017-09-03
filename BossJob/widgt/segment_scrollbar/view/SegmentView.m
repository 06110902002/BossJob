//
//  SegmentView.m
//  BossJob
//
//  Created by 刘小兵 on 2017/9/3.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "SegmentView.h"

@interface SegmentView (){

    UIView *_bottomLine;
}

@end

@implementation SegmentView

#pragma mark - init methods

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _baseConfigs];
    }
    return self;
}

#pragma mark - private methods
- (void)_baseConfigs {
    self.translucent = NO;
    
    _segmentControl = [[UISegmentedControl alloc] init];
    _segmentControl.selectedSegmentIndex = 0;
    [self addSubview:self.segmentControl];
    
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_bottomLine];
    
    self.segmentControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.segmentControl
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.segmentControl
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.segmentControl
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:-14]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.segmentControl
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:-16]];
    
    
    _bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_bottomLine
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeLeading
                         multiplier:1
                         constant:0]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_bottomLine
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1
                         constant:0]];
    [_bottomLine addConstraint:[NSLayoutConstraint
                                constraintWithItem:_bottomLine
                                attribute:NSLayoutAttributeHeight
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:0
                                multiplier:1
                                constant:1]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_bottomLine
                         attribute:NSLayoutAttributeBottom
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
}

@end
