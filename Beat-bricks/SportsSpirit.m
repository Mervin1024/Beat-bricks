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

- (NSDictionary *(^)(void))terminationConditionOfSportsSpirit{
    return [self.delegate terminationConditionOfSportsSpirit:self];
}
// 运动行为实现
- (void)moveWithAngle:(double)angle velocity:(double)velocity{
    _currentAngle = angle;
    _currentVelocity = velocity;
    if (!_movementState) {
        return;
    }
    CGPoint center = _currentCenter;
    _currentCenter.x = _currentCenter.x + velocity/100 * cos(angle/180*M_PI);
    _currentCenter.y = _currentCenter.y - velocity/100 * sin(angle/180*M_PI);
    [self setCurrentBoundsWithCenter:_currentCenter];
    // 终止条件
    NSDictionary *(^condition)(void) = [self terminationConditionOfSportsSpirit];
    NSDictionary *cond = [NSDictionary dictionary];
    if (condition) {
        cond = condition();
        if (cond.allKeys.count == 0) {
        }else{
            _currentCenter = center;
            if ([cond objectForKey:@"movementState"]) {
                _movementState = [cond objectForKey:@"movementState"];
            }
            if ([cond objectForKey:@"velocity"]) {
                velocity = [[cond objectForKey:@"velocity"] doubleValue];
            }
            if ([cond objectForKey:@"angle"]) {
                angle = [[cond objectForKey:@"angle"] doubleValue];
            }
            if ([self.delegate respondsToSelector:@selector(hitTheSportsSpirit:)]) {
                [self.delegate hitTheSportsSpirit:self];
            }
            [self moveWithAngle:angle velocity:velocity];
            return;
        }
    }else{
        NSLog(@"%@无终止条件",NSStringFromClass([self class]));
        _movementState = NO;
        return;
    }
    
    self.center = _currentCenter;

    NSDictionary *dic = @{@"velocity":@(velocity),@"angle":@(angle)};
    [self performSelector:@selector(repeat:) withObject:dic afterDelay:0.001];
}

- (void)repeat:(NSDictionary *)sender{
    [self moveWithAngle:[[sender objectForKey:@"angle"] doubleValue] velocity:[[sender objectForKey:@"velocity"] doubleValue]];
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

+ (double)radianFromAngle:(double)angle{
    return angle/180*M_PI;
}

+ (double)angleFromRadian:(double)radian{
    return radian/M_PI*180;
}

@end
