//
//  ViewController.m
//  FlowLabelLayout
//
//  Created by liuxiaobing on 20/08/2017.
//  Copyright © 2017 liuxiaobingliu. All rights reserved.
//

#import "FlowLayout.h"

@implementation FlowLayout

- (instancetype)initWithButtonList:(NSMutableArray *)buttonList {
    
    if (self = [super init]) {
        _buttonList = buttonList;
        [self buildButton];
        self.rowMargin = 10;
        self.colMargin = 10;
        
    }
    return self;
}

//private method
-(void) buildButton{
    
    [_buttonList enumerateObjectsUsingBlock:^(UIButton* button,NSUInteger idx,BOOL* stop){
        
        button.tag = idx;
        [button addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }];
    
    
}
//private method
-(void)onClickListener:(UIButton*) button{
    
    if(self.onClickBlock){
        self.onClickBlock(button,button.tag);
    }
}


/**
 @oerride method 重新布局子视图 调用时机  ifNeddLayout  NeedLayout
 达到流式布局的逻辑为：
 1.先将所有的子视图添加到本容器中（self 为View 可视为本容器对象）
 2.用一个列表来保存每行的第一个子元素，然后索引每行的第一个元素在_buttonList 的位置，假设为 k
 3.从第k个来计算本行已经添加子视图的宽度：试算式为：每个元素的宽度+行间距 设置此时的宽度为 width
 4.如果width超过了view的宽度 ，则另起一行，一般作为容器View对象的宽度常与屏幕同宽
 5.如果没有超过屏幕赛诺，则继续计算。
 
 */
- (void)layoutSubviews {
    
    // 存放每行的第一个Button
    NSMutableArray *rowFirstButtons = [NSMutableArray array];
    
    // 对第一个Button进行设置
    UIButton *button0 = self.buttonList[0];
    button0.x = self.rowMargin;
    button0.y = self.colMargin;
    [rowFirstButtons addObject:self.buttonList[0]];
    
    // 对其他Button进行设置
    int row = 0;
    
    for (int i = 1; i < self.buttonList.count; i++) {
        
        UIButton *button = self.buttonList[i];
        
        int sumWidth = 0;
        
        int start = (int)[self.buttonList indexOfObject:rowFirstButtons[row]];
        
        for (int j = start; j <= i; j++) {
            UIButton *button = self.buttonList[j];
            sumWidth += (button.width + self.rowMargin);
        }
        sumWidth += self.rowMargin;
        
        UIButton *lastButton = self.buttonList[i - 1];  //这一句比较重要，取上一个元素的位置，方便ytsh下一个的元素的位置
        
        if (sumWidth >= self.width) {
            button.x = self.rowMargin;
            button.y = lastButton.y + self.colMargin + button.height;
            [rowFirstButtons addObject:button];
            row ++;
        } else {
            button.x = sumWidth - self.rowMargin - button.width;
            button.y = lastButton.y;
        }
    }
    
    
    UIButton *lastButton = self.buttonList.lastObject;
    self.height = CGRectGetMaxY(lastButton.frame) + self.colMargin;  //更新下本容器的高度
    
    
}


@end
