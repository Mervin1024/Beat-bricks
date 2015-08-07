//
//  SmallBall.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/7.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "SmallBall.h"

@implementation SmallBall

- (instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame image:[UIImage imageNamed:@"GreenBall"]])) {
        
    }
    return self;
}

- (instancetype)initWithCenter:(CGPoint)center size:(CGSize)size{
    CGFloat width = size.width;
    CGFloat height = size.height;
    if ((self = [self initWithFrame:CGRectMake(center.x-width/2, center.y-height/2, width, height)])) {
        
    }
    return self;
}

@end
