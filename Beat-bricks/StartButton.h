//
//  startButton.h
//  Beat-bricks
//
//  Created by sh219 on 15/8/21.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartButton : UIButton

- (instancetype)initWithCenter:(CGPoint)center;
+ (instancetype)buttonWithCenter:(CGPoint)center;

- (void)showWithTitle:(NSString *)title;
- (void)dismiss;

@end
