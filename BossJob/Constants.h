//
//  Constants.h
//  spirit
//
//  Created by 刘小兵 on 2017/7/11.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */

//考虑转屏的影响，按照实际屏幕方向（UIDeviceOrientation）的宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define STATUSBAR_HEIGHT ([UIApplicationsharedApplication].statusBarFrame.size.height)


//支持16进制颜色值
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]


