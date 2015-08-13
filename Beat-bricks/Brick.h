//
//  Brick.h
//  Beat-bricks
//
//  Created by 马遥 on 15/8/13.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "SportsSpirit.h"
#import "SmallBall.h"

typedef NS_ENUM(NSInteger, BrickStyle) {
    BrickStyleWhite,
    BrickStyleYellow,
    BrickStyleBlue,
    BrickStylePink,
    BrickStyleOringe,
    BrickStyleGreen
};
@class Brick;
@protocol BrickDelegate <NSObject>

- (BOOL)birck:(Brick *)brick didHitAngle:(double)angle velocity:(double)velocity;

@end

@interface Brick : SportsSpirit

- (instancetype)initWithFrame:(CGRect)frame style:(BrickStyle)style;
+ (instancetype)brickWithFrame:(CGRect)frame style:(BrickStyle)style;

@property (weak, nonatomic) id<BrickDelegate> Brickdelegate;
@end
