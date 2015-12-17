//
//  ColorUtil.m
//  LBZBar
//
//  Created by kingly on 15/12/16.
//  Copyright © 2015年 kingly. All rights reserved.
//



#import "ColorUtil.h"

@implementation UIColor (UIColorUtils)

/**
 * 所有页面背景色
 */
+(UIColor *)backgroundColor{
   
   return [self colorWithHexString:@"#eeeeee"];
}

+ (UIColor *)navbackgroundColor{
    
    return [self colorWithHexString:@"#2196F3"];
}
/**
 * 导航字体的颜色以及导航返回按钮的颜色
 */
+(UIColor *)navTitleColor{
    return [self colorWithHexString:@"#FFFFFF"];}

/**
 * 所有button 的背景颜色
 */
+(UIColor *)BtnBgColor{
    return [self colorWithHexString:@"#2196F3"];
}
/**
 * 点击 背景高亮的颜色
 */
+(UIColor *)BtnBgHightedColor{
    return [self colorWithHexString:@"#03A9F4"];
}
/**
 * 点击 背景没有点击态的颜色
 */
+(UIColor *)BtnBgDismissColor{
    
    return [self colorWithHexString:@"#BDBDBD"];
}

+(UIColor *)BtnTitleColor{
    return [self colorWithHexString:@"#FFFFFF"];

}

/**
 *设置选项卡的颜色
 */
+(UIColor *)tabBackGroundColor{
    
    return [self colorWithHexString:@"#FFFFFF"];
}
/**
 *设置选项卡导航的颜色
 */
+(UIColor *)barTintColor{
    
    return [self colorWithHexString:@"#2196F3"];

}

+(UIColor *)lineColor{
    
    return [UIColor lightGrayColor];
}

/**
 *设置主要亲情号图标的颜色
 */
+(UIColor *)parentsMainColor{
    
    return [self colorWithHexString:@"#ff7372"];
    
}
/**
 *设置其他亲人亲情号图标的颜色
 */
+(UIColor *)parentsOtherfamilyColor{
   
    return [self colorWithHexString:@"#13b5b1"];

}

/**
 * 电子栅栏底部横条的颜色背景颜色
 */
+(UIColor *)setAlertAreaBgColor{
    
   return [self colorWithHexString:@"#2196F3"];
}

/**
 * 底部 tabBarItem 字体的颜色
 */
+(UIColor *)tabBarItemStateNormalColor{
    
   return [self colorWithHexString:@"#000000"];
}

/**
 * 底部 tabBarItem  字体被选中的颜色
 */
+(UIColor *)tabBarItemStateSelectedColor{

    return [self colorWithHexString:@"#000000"];
}

/**
 * 底部 tabBarItem 背景颜色
 */
+(UIColor *)tabBarItemBackgroundColor{

    return [self colorWithHexString:@"#ffffff"];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}
//CGColorGetComponents方法返回的是一个数组，存储的是RGBALPHA四个值
+(const CGFloat *)getComponents:(UIColor *)color{

    CGColorRef cgColor = color.CGColor;
    const CGFloat *components = CGColorGetComponents(cgColor);
  return components;
}

@end


