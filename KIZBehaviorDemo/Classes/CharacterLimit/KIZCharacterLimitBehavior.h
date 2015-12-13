//
//  KIZCharacterLimitBehavior.h
//  KIZBehaviorDemo https://github.com/zziking/KIZBehavior
//
//  Created by kingizz on 15/11/7.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import "KIZBehavior.h"

@interface KIZCharacterLimitBehavior : KIZBehavior<UITextViewDelegate>

@property (nonatomic, weak  ) IBOutlet UITextView *textView;
@property (nonatomic, weak  ) IBOutlet UILabel *countLabel;
@property (nonatomic, assign) IBInspectable NSUInteger maxCount;
@property (nonatomic, assign) IBInspectable BOOL hideKeyboardOnReturn;

@end
