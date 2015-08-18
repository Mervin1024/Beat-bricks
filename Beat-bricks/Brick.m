//
//  Brick.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/13.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "Brick.h"

@implementation Brick

- (instancetype)initWithFrame:(CGRect)frame style:(BrickStyle)style{
    NSString *imageName = @"";
    switch (style) {
        case BrickStyleBlue:
            imageName = @"BlueBrick";
            break;
        case BrickStyleGreen:
            imageName = @"GreenBrick";
            break;
        case BrickStyleOringe:
            imageName = @"OringeBrick";
            break;
        case BrickStylePink:
            imageName = @"PinkBrick";
            break;
        case BrickStyleWhite:
            imageName = @"WhiteBrick";
            break;
        case BrickStyleYellow:
            imageName = @"YellowBrick";
        default:
            break;
    }
    if ((self = [super initWithFrame:frame image:[UIImage imageNamed:imageName]])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isHitWithSmallBall:) name:@"SmallBallCurrentCenter" object:nil];
        _hitEnabled = NO;
    }
    return self;
}

+ (instancetype)brickWithFrame:(CGRect)frame style:(BrickStyle)style{
    return [[Brick alloc] initWithFrame:frame style:style];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)isHitWithSmallBall:(NSNotification*)notification{
    if (!_hitEnabled) {
        return;
    }
    NSDictionary *theData = [notification userInfo];
    SmallBall *smallBall = [theData objectForKey:@"smallBall"];
    CGFloat rectRadius = [self distanceOfPoint:self.center anotherPoint:self.frame.origin];
    CGFloat distance = [self distanceOfPoint:self.currentCenter anotherPoint:smallBall.currentCenter];
    if (distance-rectRadius > smallBall.radius) {
        return;
    }
    /**
     
     四角碰撞
     
     */
    CGPoint leftBottomCorner = CGPointMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height);
    if (smallBall.currentCenter.x < leftBottomCorner.x &&
        smallBall.currentCenter.y > leftBottomCorner.y) {
        if ([self distanceOfPoint:leftBottomCorner anotherPoint:smallBall.currentCenter] <= smallBall.radius) {
            NSLog(@"左下角");
            double newAngle = [self reflectionAngleWithSmallBall:smallBall point:leftBottomCorner];
            [self.Brickdelegate birck:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            return;
        }
    }
    CGPoint rightBottomCorner = CGPointMake(self.frame.origin.x+self.frame.size.width, self.frame.origin.y+self.frame.size.height);
    if (smallBall.currentCenter.x > rightBottomCorner.x &&
        smallBall.currentCenter.y > rightBottomCorner.y) {
        if ([self distanceOfPoint:rightBottomCorner anotherPoint:smallBall.currentCenter] <= smallBall.radius) {
            NSLog(@"右下角");
            double newAngle = [self reflectionAngleWithSmallBall:smallBall point:rightBottomCorner];
            [self.Brickdelegate birck:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            return;
        }
    }
    CGPoint leftTopCorner = self.frame.origin;
    if (smallBall.currentCenter.x < leftTopCorner.x &&
        smallBall.currentCenter.y < leftTopCorner.y) {
        if ([self distanceOfPoint:leftTopCorner anotherPoint:smallBall.currentCenter] <= smallBall.radius) {
            NSLog(@"左上角");
            double newAngle = [self reflectionAngleWithSmallBall:smallBall point:leftTopCorner];
            [self.Brickdelegate birck:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            return;
        }
    }
    CGPoint rightTopCorner = CGPointMake(self.frame.origin.x+self.frame.size.width, self.frame.origin.y);
    if (smallBall.currentCenter.x > rightTopCorner.x &&
        smallBall.currentCenter.y < rightTopCorner.y) {
        if ([self distanceOfPoint:rightTopCorner anotherPoint:smallBall.currentCenter] <= smallBall.radius) {
            NSLog(@"右上角");
            double newAngle = [self reflectionAngleWithSmallBall:smallBall point:rightTopCorner];
            [self.Brickdelegate birck:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            return;
        }
    }
    /**
     
     四边碰撞
     
     */
    if (smallBall.currentCenter.x >= self.aroundPoint.leftPoint.x &&
        smallBall.currentCenter.x <= self.aroundPoint.rightPoint.x) {
        if (smallBall.currentCenter.y - self.aroundPoint.bottomPoint.y <= smallBall.radius &&
            smallBall.currentCenter.y - self.aroundPoint.bottomPoint.y > 0) {
            double newAngle = [SportsSpirit angleFromRadian:atan(-tan([SportsSpirit radianFromAngle:smallBall.currentAngle]))];
            [self.Brickdelegate birck:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            NSLog(@"下边界");
            return;
        }
        if (self.aroundPoint.topPoint.y - smallBall.currentCenter.y <= smallBall.radius &&
            self.aroundPoint.topPoint.y - smallBall.currentCenter.y > 0) {
            double newAngle = [SportsSpirit angleFromRadian:atan(-tan([SportsSpirit radianFromAngle:smallBall.currentAngle]))];
            [self.Brickdelegate birck:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            NSLog(@"上边界");
            return;
        }
    }
    if (smallBall.currentCenter.y <= self.aroundPoint.bottomPoint.y &&
        smallBall.currentCenter.y >= self.aroundPoint.topPoint.y) {
        if (self.aroundPoint.leftPoint.x - smallBall.currentCenter.x <= smallBall.radius &&
            self.aroundPoint.leftPoint.x - smallBall.currentCenter.x > 0) {
            double newAngle = [SportsSpirit angleFromRadian:atan(-tan([SportsSpirit radianFromAngle:smallBall.currentAngle]))];
            [self.Brickdelegate birck:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            NSLog(@"左边界");
            return;
        }
        if (smallBall.currentCenter.x - self.aroundPoint.rightPoint.x <= smallBall.radius &&
            smallBall.currentCenter.x - self.aroundPoint.rightPoint.x > 0) {
            double newAngle = [SportsSpirit angleFromRadian:atan(-tan([SportsSpirit radianFromAngle:smallBall.currentAngle]))];
            [self.Brickdelegate birck:self didHitAngle:newAngle velocity:smallBall.currentVelocity];
            NSLog(@"右边界");
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

@end
