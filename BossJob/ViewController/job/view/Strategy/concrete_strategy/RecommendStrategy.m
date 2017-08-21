//
//  RecommendStrategy.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "RecommendStrategy.h"
#import "Constants.h"

static RecommendStrategy* recommendStrategy = nil;

static const int NEW_RECOMMEND_BUTTON = 4;
static const int NEW_NEW_BUTTON = 5;

@interface RecommendStrategy ()

@end

@implementation RecommendStrategy


+(instancetype) getInstanceWithWithFrame:(CGRect)frame{
    
    @synchronized (self) {
        
        if(recommendStrategy == nil){
            
            recommendStrategy = [[RecommendStrategy alloc] initWithFrame:frame];
        }
    }
    return recommendStrategy;


}


//override method
-(void) showLayout:(UIView*) parentView withTag:(NSInteger) tag{

    if(!recommendStrategy) return;

    recommendStrategy.tag = tag;
    recommendStrategy.backgroundColor = [UIColor whiteColor];
    [parentView addSubview:recommendStrategy];
    
    if([recommendStrategy subviews].count)return;
    
    recommendStrategy.tag = tag;
    recommendStrategy.backgroundColor = [UIColor whiteColor];
    [parentView addSubview:recommendStrategy];
    
    UIButton* recommendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 40)];
    recommendBtn.tag = NEW_RECOMMEND_BUTTON;
    [recommendBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel* recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 30, 40)];
    recommendLabel.text = @"推荐";
    recommendLabel.textColor = [UIColor grayColor];
    recommendLabel.font = [UIFont systemFontOfSize:14];
    [recommendBtn addSubview:recommendLabel];
    
    UIButton* NewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,40, SCREEN_WIDTH, 40)];
    NewBtn.tag = NEW_NEW_BUTTON;
    [NewBtn addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel* newLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 30, 40)];
    newLabel.text = @"最新";
    newLabel.textColor = [UIColor grayColor];
    newLabel.font = [UIFont systemFontOfSize:14];
    [NewBtn addSubview:newLabel];
    
    [recommendStrategy addSubview:recommendBtn];
    [recommendStrategy addSubview:NewBtn];

}

//private method
-(void)onClickListener:(UIButton*) sender{

    switch(sender.tag){
    
        case NEW_RECOMMEND_BUTTON:{
            
            //修改选中的控件颜色
            UIButton *recBtn = (UIButton *)[recommendStrategy viewWithTag:NEW_RECOMMEND_BUTTON];
            UILabel* recLabel = [recBtn subviews].firstObject;
            recLabel.textColor = [UIColor greenColor];
            
            if([[recBtn subviews] count] < 2){
                
                UIImageView* selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(recLabel.center.x + 17, 13, 15, 15)];
                [selectedImg setImage:[UIImage imageNamed:@"ic_selected_done.png"]];
                selectedImg.contentMode = UIViewContentModeScaleAspectFit;
                [recBtn addSubview:selectedImg];
            }
            
            
            //还原未选中的颜色
            UIButton *NewBtn = (UIButton *)[recommendStrategy viewWithTag:NEW_NEW_BUTTON];
            UILabel* newLabel = [NewBtn subviews].firstObject;
            newLabel.textColor = [UIColor grayColor];
            
            if([[NewBtn subviews] count] >= 2){
                UIImageView* newImg = [NewBtn subviews].lastObject;
                if(newImg != NULL){
                    [newImg removeFromSuperview];
                }
            }
            NSLog(@"131------------更新列表数据，筛选条件为推荐");
            
        }
            break;
            
        case NEW_NEW_BUTTON:{
            
            //修改选中的控件颜色
            UIButton *NewBtn = (UIButton *)[recommendStrategy viewWithTag:NEW_NEW_BUTTON];
            UILabel* newLabel = [NewBtn subviews].firstObject;
            newLabel.textColor = [UIColor greenColor];
            
            if([[NewBtn subviews] count] < 2){
                
                UIImageView* selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(newLabel.center.x + 17, 13, 15, 15)];
                [selectedImg setImage:[UIImage imageNamed:@"ic_selected_done.png"]];
                selectedImg.contentMode = UIViewContentModeScaleAspectFit;
                [NewBtn addSubview:selectedImg];
            }
            
            
            //还原未选中的颜色
            UIButton *recBtn = (UIButton *)[recommendStrategy viewWithTag:NEW_RECOMMEND_BUTTON];
            UILabel* recLabel = [recBtn subviews].firstObject;
            recLabel.textColor = [UIColor grayColor];
            
            if([[recBtn subviews] count] >= 2){
                
                UIImageView* newImg = [recBtn subviews].lastObject;
                if(newImg != NULL){
                    [newImg removeFromSuperview];
                }
            }
            
            NSLog(@"161------------更新列表数据，筛选条件为最新");
        }
            break;

    
    
    
    }
    
    
}

@end
