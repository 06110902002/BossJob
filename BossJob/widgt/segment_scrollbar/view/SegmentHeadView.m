//
//  SegmentHeadView.m
//  BossJob
//
//  Created by 刘小兵 on 2017/9/3.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "SegmentHeadView.h"

@interface SegmentHeadView ()

@property(nonatomic, strong) NSLayoutConstraint *imageTopConstraint;
@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation SegmentHeadView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _baseConfigs];
    }
    return self;
}

- (void)_baseConfigs {
    self.imageView = [[UIImageView alloc] init];
    
    self.imageView.backgroundColor = [UIColor greenColor];
    NSLog(@"30----------:%f",self.frame.size.height);
    
    self.imageView.image = [UIImage imageNamed:@"listdownload.jpg"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self
     addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:self
                                                attribute:NSLayoutAttributeLeft
                                               multiplier:1
                                                 constant:0]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.imageView
                         attribute:NSLayoutAttributeRight
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    self.imageTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:0];
    [self addConstraint:self.imageTopConstraint];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.imageView
                         attribute:NSLayoutAttributeBottom
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
}

- (UIImageView *)backgroundImageView {
    return _imageView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}

@end
