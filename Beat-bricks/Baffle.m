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
        _moveEnabled = NO;
        _touchView = [[TouchView alloc] initWithFrame:view.frame];
        _touchView.delegate = self;
        _currentCenter = self.center;
        [view addSubview:_touchView];
        
    }
    return self;
}

- (instancetype)initWithCenter:(CGPoint)center size:(CGSize)size superView:(UIView *)view{
    self = [self initWithFrame:CGRectMake(center.x-size.width/2, center.y-size.height/2, size.width, size.height) superView:view];
    return self;
}

+ (instancetype)baffleWithCenter:(CGPoint)center size:(CGSize)size superView:(UIView *)view{
    return [[Baffle alloc]initWithCenter:center size:size superView:view];
}

- (void)touchView:(TouchView *)view movePoint:(CGPoint)point{
    if (!_moveEnabled) {
    }else{
        CGPoint center = self.center;
        center.x += point.x;
        CGFloat halfWidth = self.frame.size.width/2;
        if (center.x - halfWidth <= 0 || center.x + halfWidth >= _touchView.frame.size.width) {
            return;
        }
        [self setBaffleCenter:center];
    }
}

- (void)setBaffleCenter:(CGPoint)center{
    self.center = center;
    _currentCenter = center;
}

@end
