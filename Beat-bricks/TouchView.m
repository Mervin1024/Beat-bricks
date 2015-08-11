//
//  TouchView.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/11.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if ([self.delegate respondsToSelector:@selector(touchView:movePoint:)]) {
        [self.delegate touchView:self movePoint:touchPoint];
    }
}

@end
