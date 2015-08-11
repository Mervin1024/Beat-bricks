//
//  FowardElementView.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/7.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "SportsSpirit.h"

@interface SportsSpirit(){
    
}

@end
@implementation SportsSpirit

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image{
    if ((self = [super initWithFrame:frame])) {
        [self setCurrentBoundsWithCenter:self.center];
        _movementState = NO;
        _currentCenter = self.center;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:(CGRect){0,0,frame.size}];
        imageView.image = image;
        [self addSubview:imageView];
        
    }
    return self;
}

// 子类重载此方法完成个性化
- (NSDictionary *(^)(void))terminationConditionOfSportsSpirit{
    return [self.delegate terminationConditionOfSportsSpirit:self];
}

// 运动行为实现
- (void)fowardWithAngle:(double)angle velocity:(double)velocity{
    _currentAngle = angle;
    
    if (!_movementState) {
        return;
    }
    CGPoint center = _currentCenter;
    _currentCenter.x = _currentCenter.x + velocity/10 * cos(angle/180*M_PI);
    _currentCenter.y = _currentCenter.y - velocity/10 * sin(angle/180*M_PI);
    [self setCurrentBoundsWithCenter:_currentCenter];
    // 终止条件
    NSDictionary *(^condition)(void) = [self terminationConditionOfSportsSpirit];
    NSDictionary *cond = condition();
    if (condition && cond.allKeys.count == 0) {
    }else{
        _currentCenter = center;
        _movementState = NO;
        if ([cond objectForKey:@"movementState"]) {
            _movementState = [cond objectForKey:@"movementState"];
        }
        if ([cond objectForKey:@"velocity"]) {
            velocity = [[cond objectForKey:@"velocity"] doubleValue];
        }
        if ([cond objectForKey:@"angle"]) {
            angle = [[cond objectForKey:@"angle"] doubleValue];
        }
        [self fowardWithAngle:angle velocity:velocity];
        return;
        
    }
    self.center = _currentCenter;

    NSDictionary *dic = @{@"velocity":@(velocity),@"angle":@(angle)};
    [self performSelector:@selector(repeat:) withObject:dic afterDelay:0.01];
}

- (void)repeat:(NSDictionary *)sender{
    [self fowardWithAngle:[[sender objectForKey:@"angle"] doubleValue] velocity:[[sender objectForKey:@"velocity"] doubleValue]];
}

- (void)setSportsSpiritCenter:(CGPoint)center{
    self.center = center;
    _currentCenter = center;
}
// aroundPoint
- (void)setCurrentBoundsWithCenter:(CGPoint)center{
    _aroundPoint.leftPoint = (CGPoint){center.x - self.frame.size.width/2,center.y};
    _aroundPoint.rightPoint = (CGPoint){center.x + self.frame.size.width/2,center.y};
    _aroundPoint.topPoint = (CGPoint){center.x,center.y - self.frame.size.height/2};
    _aroundPoint.bottomPoint = (CGPoint){center.x,center.y + self.frame.size.height/2};
}

@end
