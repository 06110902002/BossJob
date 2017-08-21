//
//  FilterNavBar.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/18.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "FilterNavBar.h"
#import "Constants.h"


@implementation FilterNavBar

-(instancetype) initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
    
        [self initAttr];
    }
    return self;

}

-(void) initAttr{
    
    
}

-(void)iniTitles:(NSMutableArray*) titles{
    
    self.titleList = titles;
    
    double itemWidth = SCREEN_WIDTH / [self.titleList count];
    
    
    [self.titleList enumerateObjectsUsingBlock:^(NSString* title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(idx * itemWidth, 0, itemWidth, 40)];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = idx;
        [self addSubview:button];
       
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 30, 40)];
        titleLabel.text = title;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:12];
        [button addSubview:titleLabel];
        
        UIImageView* titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(titleLabel.center.x + 12, 16, 8, 8)];
        [titleImg setImage:[UIImage imageNamed:@"popup_arrow_down_gray.png"]];
        titleImg.contentMode = UIViewContentModeCenter;
        
        [button addSubview:titleImg];
       
    }];
}

-(void)onClickListener:(UIButton*) button{
    
    if(self.delegate != nil){
        [self.delegate onChange:button.tag];
    }
    
    
    UILabel* titleLabel = (UILabel*) [button subviews].firstObject;
    titleLabel.textColor = [UIColor greenColor];
    UIImageView* titleImg = (UIImageView*) [button subviews].lastObject;
    [titleImg setImage:[UIImage imageNamed:@"popup_arrow_down_green.png"]];
    titleImg.contentMode = UIViewContentModeCenter;

    [self updateTitleBtnStatus:button.tag];
    
}

-(void) updateTitleBtnStatus:(NSInteger)idx{
    
    NSArray* allBtns = [self subviews];
    
    
    for(int i = 0;i < [allBtns count]; i++){
        
        if(idx == i) continue;
        
        UILabel* titleLabel = [(UILabel*) [allBtns objectAtIndex:i] subviews].firstObject;
        titleLabel.textColor = [UIColor grayColor];
        UIImageView* titleImg = [(UIImageView*) [allBtns objectAtIndex:i] subviews].lastObject;
        [titleImg setImage:[UIImage imageNamed:@"popup_arrow_down_gray.png"]];
        titleImg.contentMode = UIViewContentModeCenter;
        
    }

    
}


@end
