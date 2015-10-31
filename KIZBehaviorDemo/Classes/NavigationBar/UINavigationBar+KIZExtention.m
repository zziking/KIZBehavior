//
//  UINavigationBar+KIZExtention.m
//  KIZParallaTableDemo
//
//  Created by kingizz on 15/10/3.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import "UINavigationBar+KIZExtention.h"
#import <objc/runtime.h>

static char originBackgroundImage;
static char originShadowImage;
static char backgroundView;

@implementation UINavigationBar (KIZExtention)

#pragma mark- getters & setters
- (UIImage *)kiz_originBackgroundImage{
    return objc_getAssociatedObject(self, &originBackgroundImage);
}
- (void)kiz_setOriginBackgroundImage:(UIImage *)image{
    objc_setAssociatedObject(self, &originBackgroundImage, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)kiz_originShadowImage{
    return objc_getAssociatedObject(self, &originShadowImage);
}

- (void)kiz_setOriginShadowImage:(UIImage *)image{
    objc_setAssociatedObject(self, &originShadowImage, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)kiz_backgroundView{
    return objc_getAssociatedObject(self, &backgroundView);
}

- (void)kiz_setBackgroundView:(UIView *)view{
    objc_setAssociatedObject(self, &backgroundView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark -

- (void)kiz_setBackgroundAlpha:(CGFloat)alpha{
    [self kiz_setBackgroundColor:[self.barTintColor colorWithAlphaComponent:alpha]];
}

- (void)kiz_setBackgroundColor:(UIColor *)color{
    if (![self kiz_backgroundView]) {
        [self kiz_setOriginBackgroundImage:[self backgroundImageForBarMetrics:UIBarMetricsDefault]];
        [self kiz_setOriginShadowImage:self.shadowImage];
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:nil];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
        bgView.userInteractionEnabled = NO;
        [self insertSubview:bgView atIndex:0];
        [self kiz_setBackgroundView:bgView];
    }
    self.kiz_backgroundView.backgroundColor = color;

}

- (void)kiz_reset{
    [self setBackgroundImage:self.kiz_originBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:self.kiz_originShadowImage];
    
    [self kiz_setOriginBackgroundImage:nil];
    [self kiz_setOriginShadowImage:nil];
    
    [self.kiz_backgroundView removeFromSuperview];
    [self kiz_setBackgroundView:nil];
}


@end
