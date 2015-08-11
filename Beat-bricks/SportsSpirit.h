//
//  FowardElementView.h
//  Beat-bricks
//
//  Created by 马遥 on 15/8/7.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, StrikeBoundState) {
    StrikeLeftNone = 0,
    StrikeLeftBound,
    StrikeRightBound,
    StrikeTopBound,
    StrikeBottomBound
};

@class SportsSpirit;
@protocol SportsSpiritDelegate <NSObject>

- (NSDictionary *(^)(void))terminationConditionOfSportsSpirit:(SportsSpirit *)sender;

@end

typedef struct {
    CGFloat topBounds;
    CGFloat bottomBounds;
    CGFloat leftBounds;
    CGFloat rightBounds;
}SportsSpiritBounds;

@interface SportsSpirit : UIView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;
@property (weak, nonatomic) id<SportsSpiritDelegate> delegate;

@property (assign, nonatomic, readonly) SportsSpiritBounds currentBounds;
@property (assign, nonatomic, readonly) CGPoint currentCenter;
@property (assign, nonatomic, readonly) double currentAngle;

@property (assign, nonatomic) BOOL movementState;

//                       angle(360°)             velocity = CGPoint/0.1s
- (void)fowardWithAngle:(double)angle velocity:(double)velocity;
- (void)setSportsSpiritCenter:(CGPoint)center;
@end
