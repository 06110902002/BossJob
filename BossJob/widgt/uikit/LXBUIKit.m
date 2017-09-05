//
//  LXBUIKit.m
//  BossJob
//
//  Created by 刘小兵 on 2017/9/4.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "LXBUIKit.h"

@implementation LXBUIKit

#pragma mark --------- Label --------

+ (UILabel *)labelTextColor:(UIColor *)textColor
                   fontSize:(CGFloat)size {
    return [LXBUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:textColor textAlignment:NSTextAlignmentLeft numberOfLines:1 text:nil fontSize:size];
    
}

+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)size {
    return [LXBUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:text fontSize:size];
    
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                  numberOfLines:(NSInteger)numberOfLines
                           text:(NSString *)text
                       fontSize:(CGFloat)size {
    return [LXBUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:textColor textAlignment:NSTextAlignmentLeft numberOfLines:numberOfLines text:text fontSize:size];
    
}

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                        numberOfLines:(NSInteger)numberOfLines
                                 text:(NSString *)text
                             fontSize:(CGFloat)size {
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backgroundColor;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    return label;
}

#pragma mark --------- ImageView --------

+ (UIImageView *)imageViewWithImage:(UIImage *)image {
    
    return [LXBUIKit imageViewWithContentMode:UIViewContentModeScaleToFill userInteractionEnabled:NO image:image];
}

+ (UIImageView *)imageViewWithImage:(UIImage *)image
             userInteractionEnabled:(BOOL)enabled {
    
    return [LXBUIKit imageViewWithContentMode:UIViewContentModeScaleToFill userInteractionEnabled:enabled image:image];
}

+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)mode
                                    image:(UIImage *)image {
    
    return [LXBUIKit imageViewWithContentMode:mode userInteractionEnabled:NO image:image];
}

+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)mode
                   userInteractionEnabled:(BOOL)enabled
                                    image:(UIImage *)image {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = mode;
    imageView.userInteractionEnabled = enabled;
    imageView.image = image;
    return imageView;
}

#pragma mark --------- UIButton --------

+ (UIButton *)buttonWithImage:(UIImage *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    return btn;
    
}


+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)size {
    
    return [LXBUIKit buttonWithBackgroundColor:backgroundColor titleColor:titleColor titleHighlightColor:titleColor title:title fontSize:size];
}

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                    titleHighlightColor:(UIColor *)titleHighlightColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)size {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = backgroundColor;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleHighlightColor forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:size];
    btn.adjustsImageWhenHighlighted = NO;
    return btn;
}


+ (UITableView *)tableViewWithFrame:(CGRect)frame
                              style:(UITableViewStyle)style
                           delegate:(id)delegate {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.backgroundColor = [UIColor whiteColor];
    UIView *footerView = [[UIView alloc] init];
    tableView.tableFooterView = footerView;
    return tableView;
}

+ (void)sj_tableView:(UITableView *)tableView withDelegate:(id)delegate {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.backgroundColor = [UIColor whiteColor];
    UIView *footerView = [[UIView alloc] init];
    tableView.tableFooterView = footerView;
    
}


@end
