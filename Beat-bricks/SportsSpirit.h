//
//  FowardElementView.h
//  Beat-bricks
//
//  Created by 马遥 on 15/8/7.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HitState) {
    HitNone = 0,
    HitLeftBound,
    HitRightBound,
    HitTopBound,
    HitBottomBound
};

@class SportsSpirit;
@protocol SportsSpiritDelegate <NSObject>
- (NSDictionary *(^)(void))terminationConditionOfSportsSpirit:(SportsSpirit *)sender;
@optional
- (void)hitTheSportsSpirit:(SportsSpirit *)sender;

@end

typedef struct {
    CGPoint topPoint;
    CGPoint bottomPoint;
    CGPoint leftPoint;
    CGPoint rightPoint;
}SportsSpiritAroundPoint;

@interface SportsSpirit : UIView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;
@property (weak, nonatomic) id<SportsSpiritDelegate> delegate;

@property (assign, nonatomic, readonly) SportsSpiritAroundPoint aroundPoint;
@property (assign, nonatomic, readonly) CGPoint currentCenter;
@property (assign, nonatomic, readonly) double currentAngle;
@property (assign, nonatomic, readonly) double currentVelocity;

@property (assign, nonatomic) BOOL movementState;

+ (double)radianFromAngle:(double)angle;
+ (double)angleFromRadian:(double)radian;
//                       angle(360°)             velocity = CGPoint/0.1s
- (void)moveWithAngle:(double)angle velocity:(double)velocity;
- (void)setSportsSpiritCenter:(CGPoint)center;
@end
