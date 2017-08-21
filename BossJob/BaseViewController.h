//
//  BaseViewController.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/17.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 所有UIViewController 的基类，
 UIViewController 均城扩展此类
 */
@interface BaseViewController : UIViewController

@property(nonatomic,assign) CGRect screenSize;

-(CGRect)getScreenSize;                                   //获取屏幕尺寸
-(void)setStatusBarBackgroundColor:(UIColor *)color;      //设置状态栏颜色

@end
