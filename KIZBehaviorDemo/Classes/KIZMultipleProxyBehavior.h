//
//  KIZMultipleProxyBehavior.h
//  KIZParallaTableDemo
//
//  Created by kingizz on 15/8/17.
//  Copyright (c) 2015年 kingizz. All rights reserved.
//

#import "KIZBehavior.h"

@interface KIZMultipleProxyBehavior : KIZBehavior

@property (nonatomic, strong) IBOutletCollection(id) NSArray* delegateTargets;

@end
