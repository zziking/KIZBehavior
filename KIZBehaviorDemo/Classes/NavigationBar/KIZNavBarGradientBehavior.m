//
//  KIZNavBarGradientBehavior.m
//  KIZParallaTableDemo
//
//  Created by kingizz on 15/10/3.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import "KIZNavBarGradientBehavior.h"
#import "UINavigationBar+KIZExtention.h"


@implementation KIZNavBarGradientBehavior{
    UIColor *_navBarOriginalTintColor;  //导航栏初始时的tintColor
    UIColor *_navBarCurrentTintColor;   //动态变化时导航栏的tintColor
    
    UIImage *_originalShadowImage;      //导航栏的shadowImage
    UIImage *_clearShadowImage;
    UIImage *_curShadowImage;           //当前的shadowImage
    
    CGFloat _navBarCurBgAlpha;          //导航栏当前的透明度
    
    NSDictionary        *_navBarOriginTitleAttribute;   //导航栏初始时的titleTextAttribute
    NSMutableDictionary *_navBarCurTitleAttribute;      //导航栏当前动态变化的titleTextAttribute
    
    UIStatusBarStyle _statusBarStyle;
    
    BOOL _didScrolled;      //是否已经滚动过
    BOOL _navBarDidReset;   //是否恢复了导航栏的状态
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.criticalOffset         = 200;
        self.statusBarStyleChange   = YES;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UINavigationBar *navBar = [self navigationBar];
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //动态变化背景色
    _navBarCurBgAlpha = offsetY > 0 ? scrollView.contentOffset.y / self.criticalOffset : 0;
//    [navBar kiz_setBackgroundAlpha:_navBarCurBgAlpha];
    [navBar kiz_setBackgroundColor:[self.barBackColor colorWithAlphaComponent:_navBarCurBgAlpha]];
    
    //导航栏不透明时，显示原本的shadowImage
    if (_navBarCurBgAlpha > 1) {
        navBar.shadowImage = _originalShadowImage;
        
    }else{
        navBar.shadowImage = _clearShadowImage;
        
    }
    _curShadowImage = navBar.shadowImage;
    
    if (self.statusBarStyleChange && !_navBarDidReset) {
        if (_navBarCurBgAlpha > 0.35) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            
        }else {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    }
    
    
    if (!_navBarOriginalTintColor) {
        _navBarOriginalTintColor = navBar.tintColor;
    }
    
    _didScrolled = YES;
    
    //动态变化tintColor
    if (offsetY >= 0) {
        
        UIColor *tintColor  = nil;
        UIColor *titleColor = nil;
        CGFloat alpha       = 1;
        
        CGFloat offset = self.criticalOffset / 2.0;
        if (offsetY < offset) {
            alpha      = 1 - offsetY / offset;
            tintColor  = [UIColor colorWithWhite:1 alpha:alpha];
            titleColor = tintColor;
            
        }else{
            alpha      = offsetY / offset - 1;
            tintColor  = [_navBarOriginalTintColor colorWithAlphaComponent:alpha];
            titleColor = tintColor;
            
            UIColor *originTitleColor = _navBarOriginTitleAttribute[NSForegroundColorAttributeName];
            if (originTitleColor) {
                titleColor = [originTitleColor colorWithAlphaComponent:alpha];
            }
            
        }
        
        navBar.tintColor = tintColor;
         _navBarCurrentTintColor = tintColor;
        
        _navBarCurTitleAttribute[NSForegroundColorAttributeName] = titleColor;
        navBar.titleTextAttributes = _navBarCurTitleAttribute;
        
    }
    
}


#pragma mark- public
- (void)onViewWillAppear{
    [self initializeOrRecover];
}

- (void)onViewWillDisAppear{
    [self reset];
}

#pragma mark- Navgationbar Appearance
/**
 *  存储导航栏初始时的状态
 *
 *  @param navBar
 */
- (void)storeNaviBarAppearance:(UINavigationBar *)navBar{
    _navBarOriginalTintColor    = navBar.tintColor;
    _navBarOriginTitleAttribute = navBar.titleTextAttributes;
    _statusBarStyle             = [UIApplication sharedApplication].statusBarStyle;
    _originalShadowImage        = navBar.shadowImage;
    
}

/**
 *  恢复导航栏的状态到初始时的状态
 *
 *  @param navBar
 */
- (void)reStoreNaviBarAppearance:(UINavigationBar *)navBar{
    navBar.tintColor           = _navBarOriginalTintColor;
    navBar.titleTextAttributes = _navBarOriginTitleAttribute;
    [navBar kiz_reset];
    [[UIApplication sharedApplication] setStatusBarStyle:_statusBarStyle];
    
}

#pragma mark-
/**
 *  初始化状态
 */
- (void)initialize{
    UINavigationBar *navBar    = [self navigationBar];
    _navBarDidReset            = NO;

    [self storeNaviBarAppearance:navBar];

    [navBar kiz_setBackgroundAlpha:0];
    _clearShadowImage          = [UIImage new];
    navBar.shadowImage         = _clearShadowImage;
    

    UIColor *whiteColor        = [UIColor whiteColor];
    navBar.tintColor           = whiteColor;
    
    _navBarCurTitleAttribute   = [_navBarOriginTitleAttribute mutableCopy];
    if (!_navBarCurTitleAttribute) {
        _navBarCurTitleAttribute   = [NSMutableDictionary dictionary];
    }
    _navBarCurTitleAttribute[NSForegroundColorAttributeName] = whiteColor;
    navBar.titleTextAttributes = _navBarCurTitleAttribute;

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

/**
 *  恢复状态，恢复到重置状态之前时的状态
 */
- (void)recover{
    UINavigationBar *navBar = [self navigationBar];

    if (_navBarCurrentTintColor) {
        navBar.tintColor = _navBarCurrentTintColor;
    }
    
    navBar.titleTextAttributes = _navBarCurTitleAttribute;

//    [navBar kiz_setBackgroundAlpha:_navBarCurBgAlpha];
    [navBar kiz_setBackgroundColor:[self.barBackColor colorWithAlphaComponent:_navBarCurBgAlpha]];
    
    navBar.shadowImage = _curShadowImage;
}

/**
 *  根据当前状态自动调用initialize或者recover方法
 */
- (void)initializeOrRecover{
    if (_didScrolled) {
        [self recover];
        
    }else{
        [self initialize];
    }
}

/**
 *  重置状态，回到初始化时的状态，在Controller的viewWillDisAppear中调用
 */
- (void)reset{
    _navBarDidReset = YES;
    
    UINavigationBar *navBar = [self navigationBar];
    [self reStoreNaviBarAppearance:navBar];
}

#pragma mark-
- (UINavigationBar *)navigationBar{
    return ((UIViewController *)self.owner).navigationController.navigationBar;
}

- (UIColor *)barBackColor{
    if (!_barBackColor) {
        _barBackColor = [self navigationBar].barTintColor;
    }
    return _barBackColor;
}
@end
