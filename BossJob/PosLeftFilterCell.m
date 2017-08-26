//
//  PosLeftFilterCell.m
//  BossJob
//
//  Created by liuxiaobing on 19/08/2017.
//  Copyright © 2017 刘小兵. All rights reserved.
//

#import "PosLeftFilterCell.h"
#import "Constants.h"
#import "PosFilterModel.h"
#import "Masonry.h"

@implementation PosLeftFilterCell


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
    
    self.labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH * 2 / 5, self.bounds.size.height)];
    self.labelAddress.textColor = [UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1.0];
    self.labelAddress.font = [UIFont systemFontOfSize:14];
    self.labelAddress.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.labelAddress];
    
   
    self.labelSelectCount = [[UILabel alloc] init];
    self.labelSelectCount.backgroundColor = [UIColor colorWithRed:119.0 / 255.0 green:199.0 / 255.0 blue:194.0 / 255.0 alpha:1.0];
    self.labelSelectCount.textColor = [UIColor whiteColor];
    self.labelSelectCount.font = [UIFont systemFontOfSize:12];
    self.labelSelectCount.textAlignment = NSTextAlignmentCenter;
    self.labelSelectCount.layer.cornerRadius = 15.0 / 2;
    self.labelSelectCount.layer.masksToBounds = YES;
    self.labelSelectCount.hidden = true;
    [self addSubview:self.labelSelectCount];
    [self.labelSelectCount mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(15.0, 15.0));
        make.centerY.equalTo(self);
        
    }];

    
    
    
}

//ovride super class method
-(void) bindData:(BaseModel*_Nonnull) data{
    
    if(self.data != (PosFilterModel*)data){
        
        self.data = (PosFilterModel*)data;
        
        self.labelAddress.text = self.data.sAddress;
        
        if(self.data.selectCount){
            
            self.labelSelectCount.text = [NSString stringWithFormat:@"%ld",(long)self.data.selectCount];
            self.labelSelectCount.hidden = false;
            
        }else{
            
            self.labelSelectCount.hidden = true;
        }
        
    }

   
}



@end
