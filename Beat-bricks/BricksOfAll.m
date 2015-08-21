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
    NSMutableArray *item_1 = [NSMutableArray array];
    NSMutableArray *item_2 = [NSMutableArray array];
    NSMutableArray *item_3 = [NSMutableArray array];
    NSMutableArray *item_4 = [NSMutableArray array];
    
    // 白色砖块
    NSMutableArray *whiteBricks_0 = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/11) + view.center.x-brickWidth/2*1, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleWhite];
        [whiteBricks_0 addObject:brick];
    }
    [_whiteBricks addObjectsFromArray:whiteBricks_0];
    [item_1 addObject:whiteBricks_0];
    // 绿色砖块
    NSMutableArray *greenBricks_0 = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/9) + view.center.x-brickWidth/2*3, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleGreen];
        [greenBricks_0 addObject:brick];
    }
    [_greenBricks addObjectsFromArray:greenBricks_0];
    [item_2 addObject:greenBricks_0];
    
    NSMutableArray *greenBricks_1 = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/9) + view.center.x+brickWidth/2*1, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleGreen];
        [greenBricks_1 addObject:brick];
    }
    [_greenBricks addObjectsFromArray:greenBricks_1];
    [item_2 addObject:greenBricks_1];
    // 橘红砖块
    NSMutableArray *oringeBricks_0 = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/7) + view.center.x-brickWidth/2*5, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleOringe];
        [oringeBricks_0 addObject:brick];
    }
    [_oringeBricks addObjectsFromArray:oringeBricks_0];
    [item_3 addObject:oringeBricks_0];
    
    NSMutableArray *oringeBricks_1 = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/7) + view.center.x+brickWidth/2*3, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleOringe];
        [oringeBricks_1 addObject:brick];
    }
    [_oringeBricks addObjectsFromArray:oringeBricks_1];
    [item_3 addObject:oringeBricks_1];
    // 粉色砖块
    NSMutableArray *pinkBricks_0 = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/7) + view.center.x-brickWidth/2*7, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStylePink];
        [pinkBricks_0 addObject:brick];
    }
    [_pinkBricks addObjectsFromArray:pinkBricks_0];
    [item_4 addObject:pinkBricks_0];
    NSMutableArray *pinkBricks_1 = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/7) + view.center.x+brickWidth/2*5, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStylePink];
        [pinkBricks_1 addObject:brick];
    }
    [_pinkBricks addObjectsFromArray:pinkBricks_1];
    [item_4 addObject:pinkBricks_1];
    
    [_allBricks addObjectsFromArray:_whiteBricks];
    [_allBricks addObjectsFromArray:_greenBricks];
    [_allBricks addObjectsFromArray:_oringeBricks];
    [_allBricks addObjectsFromArray:_pinkBricks];
    
    _animateItems = @[item_1,item_2,item_3,item_4];
    
}

+ (NSArray *)bricksOfAll{
    return [[BricksOfAll alloc]init].allBricks;
}

@end
