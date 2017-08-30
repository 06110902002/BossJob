//
//  MsgVC.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/17.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MsgVC : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UISegmentedControl* navSegment;

@property(nonatomic,strong) UIScrollView* segmentScroll;

@property(nonatomic,strong) UITableView* chatListView;

@property(nonatomic,strong) UITableView* interactListView;

-(void) initNavBar;

@end
