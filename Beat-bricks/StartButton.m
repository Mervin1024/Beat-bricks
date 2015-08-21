//
//  startButton.m
//  Beat-bricks
//
//  Created by sh219 on 15/8/21.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "StartButton.h"

static StartButton *button = Nil;

@implementation StartButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

+ (instancetype)buttonWithFrame:(CGRect)frame{
    return [[StartButton alloc]initWithFrame:frame];
}

- (void)showWithTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss{
    if (self.alpha == 0) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }];
}

@end
