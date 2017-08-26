//
//  PosRightFilterCell.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/23.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "PosRightFilterCell.h"
#import "Masonry.h"
#import "PosFilterModel.h"
#import "Constants.h"
#import "SubjectMgr.h"
#import "BaseObserver.h"
#import "PositionStrategy.h"


@interface PosRightFilterCell ()

@end

@implementation PosRightFilterCell


//ovride
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self initItemView];
    }
    return self;
}

//ovride super class method for initView
-(void) initItemView{
    
    self.backgroundColor = [UIColor clearColor];
    
    self.labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH * 3 / 5, self.bounds.size.height)];
    self.labelAddress.textColor = [UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1.0];
    self.labelAddress.font = [UIFont systemFontOfSize:12];
    self.labelAddress.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.labelAddress];

    
    self.imgSelect = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_pay_unchecked.png"]];
    self.imgSelect.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imgSelect];
    [self.imgSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(15.0, 15.0));
        make.centerY.equalTo(self);
        
       
    }];
    
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    gesture.delegate  = self;
    [self addGestureRecognizer:gesture];
    
    
}

/**
 处理筛选过滤条件的手势事件
 
 @param sender 手势对象
 */
- (void)handleGesture:(UIGestureRecognizer *)sender{
    
    NSLog(@"67-----------%@",self.data.sAddress);
    
    [[SubjectMgr getInstance] bindObserver:[PositionStrategy getInstanceWithWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 270)] forSubject:self.data.sAddress];
    [[SubjectMgr getInstance] brodcastSingal:self.data.sAddress];

}

//ovride super class method
-(void) bindData:(BaseModel*_Nonnull) data{
    
    if(self.data != (PosFilterModel*)data){
    
        self.data = (PosFilterModel*)data;
        
        self.labelAddress.text = self.data.sAddress;
        
        if(![self.data select]){
            
            self.imgSelect.image = [UIImage imageNamed:@"ic_pay_unchecked.png"];
            
        }else{
            
            self.imgSelect.image = [UIImage imageNamed:@"ic_pay_checked.png"];
        }
        
    }
    
}

//此接口用来移除观察者
-(void) recycRes{
    
    [super recycRes];
    
    [[SubjectMgr getInstance] deleteObserver:[PositionStrategy getInstanceWithWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 270)]];

}




@end
