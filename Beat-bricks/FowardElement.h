//
//  FowardElementView.h
//  Beat-bricks
//
//  Created by 马遥 on 15/8/7.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, StrikeBound) {
    StrikeLeftBound,
    StrikeRightBound,
    StrikeTopBound,
    StrikeBottomBound
};

@class FowardElement;
@protocol FowardElementDelegate <NSObject>
@optional
- (BOOL)movementStateOfFowardElement:(FowardElement *)sender;
- (double)fowardVelocityOfFowardElement:(FowardElement *)sender;
- (double)fowardAngleOfFowardElement:(FowardElement *)sender;

@end

typedef struct {
    CGFloat upperBounds;
    CGFloat lowerBounds;
    CGFloat leftBounds;
    CGFloat rightBounds;
}FowardElementBounds;

@interface FowardElement : UIView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;
@property (weak, nonatomic) id<FowardElementDelegate> delegate;

@property (assign, nonatomic, readonly) FowardElementBounds fowardElementBounds;
@property (assign, nonatomic, readonly) CGPoint currentCenter;
@property (assign, nonatomic, readonly) double currentAngle;

@property (assign, nonatomic) BOOL movementState;

//                       angle(360°)             velocity = CGPoint/0.1s
- (void)fowardWithAngle:(double)angle velocity:(double)velocity stopCondition:(BOOL(^)(void))condition;


- (void)setFowardElementCenter:(CGPoint)center;
@end
