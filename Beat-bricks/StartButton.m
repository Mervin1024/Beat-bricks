//
//  startButton.m
//  Beat-bricks
//
//  Created by sh219 on 15/8/21.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "StartButton.h"

@interface StartButton (){
    BOOL startAnimation;
    NSUInteger count;
}

@end

@implementation StartButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0;
//        [self setImage:[UIImage imageNamed:@"gameHandle"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"gameHandle"] forState:UIControlStateNormal];
        startAnimation = NO;
        count = 0;
    }
    return self;
}

- (instancetype)initWithCenter:(CGPoint)center{
    CGSize size = CGSizeMake(60, 60);
    return [self initWithFrame:CGRectMake(center.x-size.width/2, center.y-size.height/2, size.width, size.height)];
}

+ (instancetype)buttonWithCenter:(CGPoint)center{
    return [[StartButton alloc]initWithCenter:center];
}

- (void)showWithTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
    if ([title length] <= 2) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }else{
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    if (self.alpha == 1) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    startAnimation = YES;
    [self performSelector:@selector(setAnimate) withObject:nil afterDelay:0.5];
}

- (void)dismiss{
    if (self.alpha == 0) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }];
    count = 4;
    startAnimation = NO;
}

- (void)setAnimate{
    if (!startAnimation) {
        return;
    }else{
        count = 0;
    }
    [self performSelector:@selector(shakeStart) withObject:nil afterDelay:2];
}

- (void)shakeStart{
    if (count >= 3) {
        [self performSelector:@selector(setAnimate) withObject:nil afterDelay:2];
        return;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformRotate(self.transform, M_PI/6);
    }];
    [self performSelector:@selector(shakeStop) withObject:nil afterDelay:0.1];
}

- (void)shakeStop{
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformRotate(self.transform, -M_PI/6);
        count++;
    }];
    [self performSelector:@selector(shakeStart) withObject:nil afterDelay:0.1];
}

@end
