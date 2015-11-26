//
//  UINavigationBar+KIZExtention.m
//  KIZParallaTableDemo
//
//  Created by kingizz on 15/10/3.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import "UINavigationBar+KIZExtention.h"
#import <objc/runtime.h>

@interface UINavigationBar ()

@property (nonatomic, assign) BOOL     kizOriginIsTranslucent;
@property (nonatomic, strong) UIImage *kizOriginBackgroundImage;
@property (nonatomic, strong) UIImage *kizOriginShadowImage;
@property (nonatomic, strong) UIView  *kizBackgroundView;

@end

@implementation UINavigationBar (KIZExtention)


- (void)kiz_setBackgroundAlpha:(CGFloat)alpha{
    [self kiz_setBackgroundColor:[self.barTintColor colorWithAlphaComponent:alpha]];
}

- (void)kiz_setBackgroundColor:(UIColor *)color{
    if (!self.kizBackgroundView) {
        self.kizOriginBackgroundImage = [self backgroundImageForBarMetrics:UIBarMetricsDefault];
        self.kizOriginShadowImage     = self.shadowImage;
        self.kizOriginIsTranslucent   = self.translucent;
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:nil];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
        bgView.userInteractionEnabled = NO;
        [self insertSubview:bgView atIndex:0];
        
        self.kizBackgroundView = bgView;
        self.translucent       = YES;

    }
    self.kizBackgroundView.backgroundColor = color;

}

- (void)kiz_reset{
    [self setBackgroundImage:self.kizOriginBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:self.kizOriginShadowImage];
    [self setTranslucent:self.kizOriginIsTranslucent];
    
    [self.kizBackgroundView removeFromSuperview];
    self.kizOriginBackgroundImage = nil;
    self.kizOriginShadowImage     = nil;
    self.kizBackgroundView        = nil;
}

#pragma mark- getters & setters

- (UIImage *)kizOriginBackgroundImage{
    return objc_getAssociatedObject(self, @selector(kizOriginBackgroundImage));
}
- (void)setKizOriginBackgroundImage:(UIImage *)kizOriginBackgroundImage{
    objc_setAssociatedObject(self, @selector(kizOriginBackgroundImage), kizOriginBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)kizOriginShadowImage{
    return objc_getAssociatedObject(self, @selector(kizOriginShadowImage));
}
- (void)setKizOriginShadowImage:(UIImage *)kizOriginShadowImage{
    objc_setAssociatedObject(self, @selector(kizOriginShadowImage), kizOriginShadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)kizBackgroundView{
    return objc_getAssociatedObject(self, @selector(kizBackgroundView));
}
- (void)setKizBackgroundView:(UIView *)kizBackgroundView{
    objc_setAssociatedObject(self, @selector(kizBackgroundView), kizBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)kizOriginIsTranslucent{
    return [objc_getAssociatedObject(self, @selector(kizOriginIsTranslucent)) boolValue];
}
- (void)setKizOriginIsTranslucent:(BOOL)kizOriginIsTranslucent{
    objc_setAssociatedObject(self, @selector(kizOriginIsTranslucent), @(kizOriginIsTranslucent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
