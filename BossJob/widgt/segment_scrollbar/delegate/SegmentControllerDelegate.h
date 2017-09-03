//
//  SegmentControllerDelegate.h
//  BossJob
//
//  Created by 刘小兵 on 2017/9/3.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 segment协议 接口，主要规范segment标题与获取中间uiScrollView
 */
@protocol SegmentControllerDelegate <NSObject>

@optional
- (NSString *) segmentTitle;
- (UIScrollView *) streachScrollView;

@end
