//
//  UINavigationBar+KIZExtention.h
//  KIZParallaTableDemo
//
//  Created by kingizz on 15/10/3.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (KIZExtention)

/**
 *  设置导航栏透明度
 *
 *  @param alpha
 */
- (void)kiz_setBackgroundAlpha:(CGFloat)alpha;

/**
 *  设置导航栏背景颜色
 *
 *  @param color
 */
- (void)kiz_setBackgroundColor:(UIColor *)color;

/**
 *  重置导航栏的状态，恢复到初始时的状态
 */
- (void)kiz_reset;

@end
