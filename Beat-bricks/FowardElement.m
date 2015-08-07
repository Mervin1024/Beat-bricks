//
//  FowardElementView.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/7.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "FowardElement.h"

@implementation FowardElement
@synthesize fowardElementBounds,currentCenter,currentAngle;
@synthesize movementState;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image{
    if ((self = [super initWithFrame:frame])) {
        [self setFowardElementBoundsWithCenter:self.center];
        movementState = NO;
        currentCenter = self.center;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:(CGRect){0,0,frame.size}];
        imageView.image = image;
        [self addSubview:imageView];
    }
    return self;
}

- (void)fowardWithAngle:(double)angle velocity:(double)velocity stopCondition:(BOOL(^)(void))condition{
    currentAngle = angle;
    
    if (!movementState) {
        return;
    }
    CGPoint center = currentCenter;
    currentCenter.x = currentCenter.x + velocity/10 * cos(angle/180*M_PI);
    currentCenter.y = currentCenter.y - velocity/10 * sin(angle/180*M_PI);
    [self setFowardElementBoundsWithCenter:currentCenter];
    if (condition()) {
        NSLog(@"%lf",currentCenter.x);
        currentCenter = center;
        NSLog(@"%lf",currentCenter.x);
        movementState = NO;
        if ([self.delegate respondsToSelector:@selector(movementStateOfFowardElement:)]) {
            movementState = [self.delegate movementStateOfFowardElement:self];
        }
        if ([self.delegate respondsToSelector:@selector(fowardVelocityOfFowardElement:)]) {
            velocity = [self.delegate fowardVelocityOfFowardElement:self];
        }
        if ([self.delegate respondsToSelector:@selector(fowardAngleOfFowardElement:)]) {
            angle = [self.delegate fowardAngleOfFowardElement:self];
        }
        [self fowardWithAngle:angle velocity:velocity stopCondition:condition];
        return;
        
    }
    [UIView animateWithDuration:0.01 animations:^{
        self.center = currentCenter;
    }];
    
    NSDictionary *dic = @{@"velocity":@(velocity),@"angle":@(angle),@"condition":condition};
    [self performSelector:@selector(repeat:) withObject:dic afterDelay:0.01];
}

- (void)repeat:(NSDictionary *)sender{
    [self fowardWithAngle:[[sender objectForKey:@"angle"] doubleValue] velocity:[[sender objectForKey:@"velocity"] doubleValue] stopCondition:[sender objectForKey:@"condition"]];
}

- (void)setFowardElementCenter:(CGPoint)center{
    self.center = center;
    currentCenter = center;
}

- (void)setFowardElementBoundsWithCenter:(CGPoint)center{
    fowardElementBounds.leftBounds = center.x - self.frame.size.width/2;
    fowardElementBounds.rightBounds = center.x + self.frame.size.width/2;
    fowardElementBounds.upperBounds = center.y - self.frame.size.height/2;
    fowardElementBounds.lowerBounds = center.y + self.frame.size.height/2;
}

@end
