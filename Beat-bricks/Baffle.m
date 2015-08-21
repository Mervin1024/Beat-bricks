//
//  Baffle.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/11.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "Baffle.h"
#import "SmallBall.h"

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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isHitWithSmallBall:) name:@"SmallBallCurrentCenter" object:nil];
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
        if (center.x <= 0 + halfWidth|| center.x >= _touchView.frame.size.width - halfWidth) {
            return;
        }
        [self setBaffleCenter:center];
    }
}

- (void)setBaffleCenter:(CGPoint)center{
    self.center = center;
    _currentCenter = center;
}

- (void)isHitWithSmallBall:(NSNotification*)notification{
//    if (!_moveEnabled) {
//        return;
//    }
    NSDictionary *theData = [notification userInfo];
    SmallBall *smallBall = [theData objectForKey:@"smallBall"];
    CGFloat rectRadius = [self distanceOfPoint:self.center anotherPoint:self.frame.origin];
    CGFloat distance = [self distanceOfPoint:self.currentCenter anotherPoint:smallBall.currentCenter];
    
    if (distance-rectRadius > smallBall.radius) {
        if (!_moveEnabled) {
            _moveEnabled = YES;
        }
        return;
    }
    /**
     
     四角碰撞
     
     */
    CGPoint leftBottomCorner = CGPointMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height);
    if ([self distanceOfPoint:leftBottomCorner anotherPoint:smallBall.currentCenter] <= smallBall.radius) {
        if (smallBall.aroundPoint.topPoint.x >= leftBottomCorner.x ||
            smallBall.aroundPoint.rightPoint.y <= leftBottomCorner.y) {
            
        }else{
                        NSLog(@"左下角");
            double newAngle = [self reflectionAngleWithSmallBall:smallBall point:leftBottomCorner];
            [self.delegate baffle:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            return;
        }
    }
    CGPoint rightBottomCorner = CGPointMake(self.frame.origin.x+self.frame.size.width, self.frame.origin.y+self.frame.size.height);
    if ([self distanceOfPoint:rightBottomCorner anotherPoint:smallBall.currentCenter] <= smallBall.radius) {
        if (smallBall.aroundPoint.topPoint.x <= rightBottomCorner.x ||
            smallBall.aroundPoint.leftPoint.y <= rightBottomCorner.y) {
            
        }else{
                        NSLog(@"右下角");
            double newAngle = [self reflectionAngleWithSmallBall:smallBall point:rightBottomCorner];
            [self.delegate baffle:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            return;
        }
    }
    
    CGPoint leftTopCorner = self.frame.origin;
    if ([self distanceOfPoint:leftTopCorner anotherPoint:smallBall.currentCenter] <= smallBall.radius) {
        if (smallBall.aroundPoint.bottomPoint.x >= leftTopCorner.x ||
            smallBall.aroundPoint.rightPoint.y >= leftTopCorner.y) {
            
        }else{
//                        NSLog(@"左上角");
            double newAngle = [self reflectionAngleWithSmallBall:smallBall point:leftTopCorner];
            [self.delegate baffle:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            return;
        }
    }
    //    }
    CGPoint rightTopCorner = CGPointMake(self.frame.origin.x+self.frame.size.width, self.frame.origin.y);
    if ([self distanceOfPoint:rightTopCorner anotherPoint:smallBall.currentCenter] <= smallBall.radius) {
        if (smallBall.aroundPoint.bottomPoint.x <= rightTopCorner.x ||
            smallBall.aroundPoint.leftPoint.y >= rightTopCorner.y) {
            
        }else{
//                        NSLog(@"右上角");
            double newAngle = [self reflectionAngleWithSmallBall:smallBall point:rightTopCorner];
            [self.delegate baffle:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            return;
        }
        
    }
    /**
     
     四边碰撞
     
     */
    if (smallBall.currentCenter.x >= self.frame.origin.x &&
        smallBall.currentCenter.x <= self.frame.origin.x+self.frame.size.width) {
        if (smallBall.currentCenter.y - (self.frame.origin.y+self.frame.size.height) <= smallBall.radius &&
            smallBall.currentCenter.y - (self.frame.origin.y+self.frame.size.height) > 0) {
            double newAngle = 360-smallBall.currentAngle;
            [self.delegate baffle:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            //            NSLog(@"下边界");
            return;
        }
        if (self.frame.origin.y - smallBall.currentCenter.y <= smallBall.radius &&
            self.frame.origin.y - smallBall.currentCenter.y > 0) {;
            double newAngle = 360-smallBall.currentAngle;
            [self.delegate baffle:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
//                        NSLog(@"上边界");
            return;
        }
    }
    if (smallBall.currentCenter.y <= self.frame.origin.y+self.frame.size.height &&
        smallBall.currentCenter.y >= self.frame.origin.y) {
            if (self.frame.origin.x - smallBall.currentCenter.x <= smallBall.radius &&
                self.frame.origin.x - smallBall.currentCenter.x > 0) {
                double newAngle = 180-smallBall.currentAngle;
                [self.delegate baffle:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
//                NSLog(@"左边界");
                return;
            }
            if (smallBall.currentCenter.x - (self.frame.origin.x+self.frame.size.width) <= smallBall.radius &&
                smallBall.currentCenter.x - (self.frame.origin.x+self.frame.size.width) > 0) {
                double newAngle = 180-smallBall.currentAngle;
                [self.delegate baffle:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
//                NSLog(@"右边界");
                return;
            }
        
    }
    
    
}

- (CGFloat)distanceOfPoint:(CGPoint)point_1 anotherPoint:(CGPoint)point_2{
    return sqrtf(powf(point_1.x-point_2.x, 2) + powf(point_1.y-point_2.y, 2));
}

- (double)reflectionAngleWithSmallBall:(SmallBall *)smallBall point:(CGPoint)point{
    double a = atan((smallBall.center.y-point.y)/(point.x-smallBall.center.x));
    double b = [SportsSpirit radianFromAngle:smallBall.currentAngle] - a;
    CGPoint vector = CGPointMake(cos(a)*(-sin(b)-cos(b)), -sin(a)*(-sin(b)+cos(b)));
    double Angle = atan2(vector.y, vector.x);
    double newAngle = [SportsSpirit angleFromRadian:Angle];
    return newAngle;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
