//
//  ChatView.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/31.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ChatView.h"
#import "ChatCell.h"
#import "ChatHeadCell.h"
#import "ChatHeadModel.h"
#import "ChatModel.h"

@implementation ChatView


-(instancetype) initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
    }
    return self;
    
}

//@override method
-(void) initAttr{
    
    [super initAttr];
    
    
    ChatHeadModel* head = [[ChatHeadModel alloc] init];
    [self.dataList addObject:head];
    
    for(int i=0; i< 5; i++){
    
        ChatModel* chat = [[ChatModel alloc] init];
        
        [self.dataList addObject:chat];
    
    }
    
    
    
}

//@override method -(BaseTabViewCell*) buildTableViewCell  这个方法不生写了，直接重写下面的那个方法
//- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

//@override method
//-(CGFloat) getCellHeight{
//    
//    return 70.0f;
//}

//@override UITableView protcal method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseModel *baseModel = self.dataList[indexPath.row];
    
    switch ([baseModel getItemType]) {
        case ChatHeadType:
             NSLog(@"63-------------cell on click ChatHeadType");
            break;
        case ChatType:
            NSLog(@"66-------------cell on click ChatType");
            break;
        default:
            break;
    }

    
   
}

//重写此方法，达到一个列表中展现不同的cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BaseModel *baseModel = self.dataList[indexPath.row];
    BaseTabViewCell *cell;
    NSString *cellIdentifier;
    
    switch ([baseModel getItemType]) {
        case ChatHeadType:
            cellIdentifier = @"ChatHeadType";
            break;
        case ChatType:
            cellIdentifier = @"ChatType";
            break;
        default:
            break;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        switch ([baseModel getItemType]) {
            case ChatHeadType:
                cell = [[ChatHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                break;
            case ChatType:
                cell = [[ChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                break;
            default:
                break;
        }
    }
    
    [cell bindData:baseModel];
    return cell;
}
//重写此方法达到不同的cell有不同的高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseModel *baseModel = self.dataList[indexPath.row];
    CGFloat height = 0.0f;
    
    switch ([baseModel getItemType]) {
            
        case ChatHeadType:
            height = 40.0f;
            break;
            
        case ChatType:
            height = 70.0f;
            break;
            
        default:
            break;
    }

    return height;
}


@end
