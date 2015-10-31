//
//  KIZParallaxTableBehavior.h
//  KIZParallaTableDemo
//
//  Created by kingizz on 15/8/18.
//  Copyright (c) 2015年 kingizz. All rights reserved.
//

#import "KIZBehavior.h"

@interface KIZParallaxHeaderBehavior : KIZBehavior<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIView* targetView;
/**
 *   向上滚动时，背景与scrollview offsetY的视差倍率，默认0.6
 */
@property (nonatomic, assign) IBInspectable CGFloat offsetMultiple;


@end
