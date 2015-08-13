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
    NSDictionary *theData = [notification userInfo];
    SmallBall *smallBall = [theData objectForKey:@"smallBall"];
    if (((NSInteger)smallBall.aroundPoint.bottomPoint.y == (NSInteger)self.frame.origin.y &&
         smallBall.aroundPoint.bottomPoint.x >= self.frame.origin.x &&
         smallBall.aroundPoint.bottomPoint.x < self.frame.origin.x+self.frame.size.width) ||
        ((NSInteger)smallBall.aroundPoint.topPoint.y == (NSInteger)self.frame.origin.y+self.frame.size.height &&
         smallBall.aroundPoint.topPoint.x >= self.frame.origin.x &&
         smallBall.aroundPoint.topPoint.x < self.frame.origin.x+self.frame.size.width)) {
        [self.Brickdelegate birck:self
                      didHitAngle:(360-smallBall.currentAngle)
                         velocity:smallBall.currentVelocity];
    }else if (((NSInteger)smallBall.aroundPoint.leftPoint.x == (NSInteger)self.frame.origin.x &&
              smallBall.aroundPoint.leftPoint.y >= self.frame.origin.y &&
              smallBall.aroundPoint.leftPoint.y < self.frame.origin.y+self.frame.size.height) ||
        ((NSInteger)smallBall.aroundPoint.rightPoint.x == (NSInteger)self.frame.origin.x+self.frame.size.width &&
         smallBall.aroundPoint.rightPoint.y >= self.frame.origin.y &&
         smallBall.aroundPoint.rightPoint.y < self.frame.origin.y+self.frame.size.height)){
            [self.Brickdelegate birck:self
                          didHitAngle:(180-smallBall.currentAngle)
                             velocity:smallBall.currentVelocity];
    }

}

@end
