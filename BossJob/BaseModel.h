//
//  BaseModel.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/22.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 构建UItableView cell的类型枚举

 - CellItemDefaultType: 默认类型
 - CellItemJobListType: 职位列表类型
 */
typedef NS_ENUM(NSInteger, CellItemType) {
    
    CellItemDefaultType = 1,
    CellItemJobListType,
    CellItemSelect,         //地区过滤列表是否选中
    InterestedInMe,         //对我感兴趣类型
    ChatType,               //聊天页面信息实体类型
    ChatHeadType,           //聊天页面头部说明信息实体类型
    
};

/**
 数据类型协议接口，通常用于同一个tableView中展示不同的item类型
 */
@protocol ItemType <NSObject>

@optional
-(CellItemType) getItemType;

@end


/**
 列表中的基类接口
 */
@interface BaseModel : NSObject<ItemType>

@property(nonatomic,weak) id<ItemType> delegate;


@end
