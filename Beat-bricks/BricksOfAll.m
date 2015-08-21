//
//  BricksOfAll.m
//  Beat-bricks
//
//  Created by sh219 on 15/8/21.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "BricksOfAll.h"

@implementation BricksOfAll

CGFloat const brickHight = 15.0f;
NSInteger const numberOfBricksAtRow = 17;

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initBricks];
    }
    return self;
}

- (void)initBricks{
    _allBricks = [NSMutableArray arrayWithCapacity:60];
    _whiteBricks = [NSMutableArray arrayWithCapacity:15];
    _oringeBricks = [NSMutableArray arrayWithCapacity:15];
    _greenBricks = [NSMutableArray arrayWithCapacity:15];
    _pinkBricks = [NSMutableArray arrayWithCapacity:15];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    CGFloat brickWidth = view.frame.size.width/numberOfBricksAtRow;
    // 白色砖块
    for (int i = 0; i < 9; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/11) + view.center.x-brickWidth/2*1, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleWhite];
        [_whiteBricks addObject:brick];
    }
    // 绿色砖块
    for (int i = 0; i < 7; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/9) + view.center.x-brickWidth/2*3, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleGreen];
        [_greenBricks addObject:brick];
    }
    for (int i = 0; i < 7; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/9) + view.center.x+brickWidth/2*1, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleGreen];
        [_greenBricks addObject:brick];
    }
    // 橘红砖块
    for (int i = 0; i < 5; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/7) + view.center.x-brickWidth/2*5, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleOringe];
        [_oringeBricks addObject:brick];
    }
    for (int i = 0; i < 5; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/7) + view.center.x+brickWidth/2*3, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleOringe];
        [_oringeBricks addObject:brick];
    }
    // 粉色砖块
    for (int i = 0; i < 3; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/7) + view.center.x-brickWidth/2*7, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStylePink];
        [_pinkBricks addObject:brick];
    }
    for (int i = 0; i < 3; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/7) + view.center.x+brickWidth/2*5, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStylePink];
        [_pinkBricks addObject:brick];
    }
    [_allBricks addObjectsFromArray:_whiteBricks];
    [_allBricks addObjectsFromArray:_greenBricks];
    [_allBricks addObjectsFromArray:_oringeBricks];
    [_allBricks addObjectsFromArray:_pinkBricks];
    
}

+ (NSArray *)bricksOfAll{
    return [[BricksOfAll alloc]init].allBricks;
}

@end
