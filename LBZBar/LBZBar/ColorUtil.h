//
//  ColorUtil.h
//  LBZBar
//
//  Created by kingly on 15/12/16.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColorUtils)

+(UIColor *)backgroundColor;  //所有视图背景颜色

+ (UIColor *)navbackgroundColor; //导航背景颜色
/**
 * 导航字体的颜色以及导航返回按钮的颜色
 */
+(UIColor *)navTitleColor;
/**
 * 所有button 的背景颜色
 */
+(UIColor *)BtnBgColor;
/**
 * 点击 背景高亮的颜色
 */
+(UIColor *)BtnBgHightedColor;
/**
 * 点击 背景没有点击态的颜色
 */
+(UIColor *)BtnBgDismissColor;
/**
 * button 上的title 颜色
 */
+(UIColor *)BtnTitleColor;
/**
 *设置选项卡导航的颜色
 */
+(UIColor *)barTintColor;
/**
 *设置选项卡的颜色
 */
+(UIColor *)tabBackGroundColor;
/**
 * 所有分割线的颜色
 */
+(UIColor *)lineColor;
/**
 *设置主要亲情号图标的颜色
 */
+(UIColor *)parentsMainColor;
/**
 *设置其他亲人亲情号图标的颜色
 */
+(UIColor *)parentsOtherfamilyColor;

/**
 * 电子栅栏底部横条的颜色背景颜色
 */
+(UIColor *)setAlertAreaBgColor;

+(UIColor *)colorWithHexString:(NSString *)color;

/**
 * 底部 tabBarItem 字体的颜色
 */
+(UIColor *)tabBarItemStateNormalColor;

/**
 * 底部 tabBarItem 字体被选中的颜色
 */
+(UIColor *)tabBarItemStateSelectedColor;
/**
 * 底部 tabBarItem 背景颜色
 */
+(UIColor *)tabBarItemBackgroundColor;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+(const CGFloat *)getComponents:(UIColor *)color;

@end