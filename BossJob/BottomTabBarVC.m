//
//  BottomTabBarVC.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/17.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "BottomTabBarVC.h"
#import "JobVC.h"
#import "CompanyVC.h"
#import "MsgVC.h"
#import "MineVC.h"
#import "UIImage+UIImageExtras.h"

@implementation BottomTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMenu];
}
-(void) viewDidAppear:(BOOL)animated{

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self updateTips:0 withCount:23];
//        });
//    });
    
}

-(void) initMenu{
    

    
    self.jobVC = [[JobVC alloc] init];
    self.jobVC.tabBarItem.title = NSLocalizedString(@"home_job",nil);
    self.jobVC.view.tag = 0;
    UIImage* selectImg = [UIImage imageNamed:@"ic_main_tab_find_pre"];
    self.jobVC.tabBarItem.selectedImage = [selectImg imageByScalingToSize:CGSizeMake(30, 30)];
    UIImage* normalImg = [UIImage imageNamed:@"ic_main_tab_find_nor"];
    self.jobVC.tabBarItem.image = [normalImg imageByScalingToSize:CGSizeMake(30, 30)];
    

    self.companyVC = [[CompanyVC alloc] init];
    self.companyVC.tabBarItem.title = NSLocalizedString(@"home_company",nil);
    self.companyVC.view.tag = 1;
    UIImage* company_selectImg = [UIImage imageNamed:@"ic_filter_district_off"];
    self.companyVC.tabBarItem.selectedImage = [company_selectImg imageByScalingToSize:CGSizeMake(30, 30)];
    UIImage* company_normalImg = [UIImage imageNamed:@"ic_filter_district_on"];
    self.companyVC.tabBarItem.image = [company_normalImg imageByScalingToSize:CGSizeMake(30, 30)];
    
    
    
    self.msgVC = [[MsgVC alloc] init];
    self.msgVC.tabBarItem.title = NSLocalizedString(@"home_message",nil);
    self.msgVC.view.tag = 2;
    UIImage* msg_selectImg = [UIImage imageNamed:@"ic_main_tab_contacts_nor"];
    self.msgVC.tabBarItem.selectedImage = [msg_selectImg imageByScalingToSize:CGSizeMake(30, 30)];
    UIImage* msg_normalImg = [UIImage imageNamed:@"ic_main_tab_contacts_pre"];
    self.msgVC.tabBarItem.image = [msg_normalImg imageByScalingToSize:CGSizeMake(30, 30)];
    
    
    
    self.mineVC = [[MineVC alloc] init];
    self.mineVC.tabBarItem.title = NSLocalizedString(@"home_mine",nil);
    self.mineVC.view.tag = 3;
    UIImage* mine_selectImg = [UIImage imageNamed:@"ic_main_tab_my_nor"];
    self.mineVC.tabBarItem.selectedImage = [mine_selectImg imageByScalingToSize:CGSizeMake(30, 30)];
    UIImage* mine_normalImg = [UIImage imageNamed:@"ic_main_tab_my_pre"];
    self.mineVC.tabBarItem.image = [mine_normalImg imageByScalingToSize:CGSizeMake(30, 30)];
    
    self.viewControllers = @[self.jobVC, self.companyVC, self.msgVC, self.mineVC];
    self.delegate = self;
}

-(void) updateTips:(NSInteger) index withCount:(NSInteger) count{

    switch(index){
            
        case 0:{
            self.jobVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",count];
            self.jobVC.tabBarItem.badgeColor = [UIColor redColor];
        }
            break;
            
        case 1:{
            self.companyVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",count];
            self.companyVC.tabBarItem.badgeColor = [UIColor redColor];
        }
            break;
            
        case 2:{
            self.msgVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",count];
            self.msgVC.tabBarItem.badgeColor = [UIColor redColor];
        }
            break;
            
        case 3:{
            self.mineVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",count];
            self.mineVC.tabBarItem.badgeColor = [UIColor redColor];
        }
            break;
    }

    
}

//实现UITabBarController 协议方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    switch(viewController.view.tag){
            
        case 0:{
            
            self.jobVC.tabBarItem.badgeValue = nil;
            
        }
            break;
        case 1:{
            self.companyVC.tabBarItem.badgeValue = nil;
        }
            break;
            
        case 2:{
            
            self.msgVC.tabBarItem.badgeValue = nil;
        }
            break;
        case 3:{
            
            self.mineVC.tabBarItem.badgeValue = nil;
        }
            break;
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
