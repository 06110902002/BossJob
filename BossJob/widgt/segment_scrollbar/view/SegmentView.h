//
//  SegmentView.h
//  BossJob
//
//  Created by 刘小兵 on 2017/9/3.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 segmentBar scrollView中间的导航栏
 */
@interface SegmentView : UIToolbar



@property (nonatomic, strong, readonly) UISegmentedControl *segmentControl;

@end
