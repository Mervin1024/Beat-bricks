//
//  SmallBall.h
//  Beat-bricks
//
//  Created by 马遥 on 15/8/7.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "SportsSpirit.h"
//@class SmallBall;
//@protocol SmallBallDelegate <NSObject>
//
//- (NSDictionary *(^)(void))terminationConditionOfSmallBall:(SmallBall *)sender;
//
//@end

@interface SmallBall : SportsSpirit

- (instancetype)initWithCenter:(CGPoint)center size:(CGSize)size;
+ (instancetype)smallBallWithCenter:(CGPoint)center size:(CGSize)size;

//@property (nonatomic, weak) id<SmallBallDelegate> smallBallDelegate;
@property (nonatomic, assign, readonly) CGFloat radius;
@end
