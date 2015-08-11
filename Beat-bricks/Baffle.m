//
//  Baffle.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/11.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "Baffle.h"

@interface Baffle(){
    
}

@end

@implementation Baffle

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)view{
    if ((self = [super initWithFrame:frame])) {
        self.image = [UIImage imageNamed:@"Baffle"];
        _touchView = [[TouchView alloc] initWithFrame:view.frame];
        _touchView.alpha = 0;
        _touchView.delegate = self;
        [view addSubview:_touchView];
        
    }
    return self;
}

+ (instancetype)baffleWithFrame:(CGRect)frame superView:(UIView *)view{
    return [[Baffle alloc]initWithFrame:frame superView:view];
}

- (void)touchView:(TouchView *)view movePoint:(CGPoint)point{
    CGPoint center = self.center;
    center.x = point.x;
    self.center = center;
}

@end
