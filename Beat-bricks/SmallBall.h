//
//  SmallBall.h
//  Beat-bricks
//
//  Created by 马遥 on 15/8/7.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "FowardElement.h"

typedef NS_ENUM(NSInteger, SmallBallStrikeBound) {
    SmallBallStrikeLeftBound,
    SmallBallStrikeRightBound,
    SmallBallStrikeTopBound,
    SmallBallStrikeBottomBound
};

@interface SmallBall : FowardElement
- (instancetype)initWithCenter:(CGPoint)center size:(CGSize)size;
@end
