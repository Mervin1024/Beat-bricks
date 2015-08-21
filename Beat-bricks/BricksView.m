//
//  BricksView.m
//  Beat-bricks
//
//  Created by sh219 on 15/8/21.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "BricksView.h"

@interface BricksView () {
    BricksOfAll *bricks;
    NSArray *animateItems;
}

@end

@implementation BricksView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        bricks = [[BricksOfAll alloc]init];
        _allBricks = bricks.allBricks;
        for (Brick *brick in _allBricks) {
            brick.alpha = 0;
            [self addSubview:brick];
        }
        animateItems = bricks.animateItems;
    }
    return self;
}

- (void)show{
    for (int i = 0; i < [animateItems count]; i++) {
        NSArray *item = animateItems[i];
        for (int j = 0; j < [item count]; j++) {
            NSArray *brick = item[j];
            [self performSelector:@selector(setAnimateWithBricks:) withObject:brick afterDelay:((double)i)/2];
        }
        
    }
}

- (void)setAnimateWithBricks:(NSArray *)brick{
    [self repeatWithBricks:brick Index:0];
}

- (void)repeatWithBricks:(NSArray *)brick Index:(NSInteger)i{
    if (i >= [brick count]) {
        return;
    }
    [UIView animateWithDuration:0.1 animations:^{
        Brick *a = brick[i];
        a.alpha = 1;
    }completion:^(BOOL finished){
        [self repeatWithBricks:brick Index:i+1];
    }];
}

- (void)dismiss{
    for (Brick *b in _allBricks) {
        b.alpha = 0;
    }
}

@end
