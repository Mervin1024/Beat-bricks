//
//  ViewController.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/6.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<FowardElementDelegate>{
//    BOOL start;
    CGPoint initailCenter;
    SmallBallStrikeBound smallBallStrikeBound;
}

@end

@implementation ViewController
//@synthesize movementState,initialAngle,initialCenter,sizeOfBall;
@synthesize smallBall;
//static double step = 5.00;
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initValue];
    [self initBall];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)initValue{
//    movementState = NO;
//    initialAngle = M_PI_4;
//    sizeOfBall = (CGSize){32,32};
//    initialCenter = CGPointMake(self.view.center.x, self.view.frame.size.height-35-6-sizeOfBall.height/2);
//    
//}

- (void)initBall{
//    start = NO;
    CGSize size = (CGSize){18,18};
    initailCenter = CGPointMake(self.view.center.x, self.view.frame.size.height-35-5-size.height/2);
    smallBall = [[SmallBall alloc]initWithCenter:initailCenter size:size];
    smallBall.delegate = self;
//    NSLog(@"%ld",[self.view subviews].count);
    [self.view addSubview:smallBall];
//    NSLog(@"%ld",[self.view subviews].count);
}

- (IBAction)begin:(id)sender {
    if (!smallBall.movementState) {
        [smallBall setFowardElementCenter:initailCenter];
        smallBall.movementState = YES;
        [self.startButton setTitle:@"stop" forState:UIControlStateNormal];
        [smallBall fowardWithAngle:60 velocity:20.0 stopCondition:^{
            return [self changingMotionState];
        }];
    }else{
        smallBall.movementState = NO;
        [self.startButton setTitle:@"start" forState:UIControlStateNormal];
        [smallBall setFowardElementCenter:initailCenter];
    }
}

- (BOOL)changingMotionState{
    if (smallBall.fowardElementBounds.lowerBounds >= self.line.center.y) {
        smallBallStrikeBound = SmallBallStrikeBottomBound;
        return YES;
    }
    if (smallBall.fowardElementBounds.upperBounds <= 0) {
        smallBallStrikeBound = SmallBallStrikeTopBound;
        return YES;
    }
    if (smallBall.fowardElementBounds.rightBounds >= self.view.frame.size.width) {
        smallBallStrikeBound = SmallBallStrikeRightBound;
        return YES;
    }
    if (smallBall.fowardElementBounds.leftBounds <= 0) {
        smallBallStrikeBound = SmallBallStrikeLeftBound;
        return YES;
    }
    return NO;
    
}


- (double)fowardAngleOfFowardElement:(FowardElement *)sender{
    double angle = sender.currentAngle;
    double newAngle = 0;
    switch (smallBallStrikeBound) {
        case SmallBallStrikeLeftBound:
            newAngle = 180-angle;
            break;
        case SmallBallStrikeRightBound:
            newAngle = 180-angle;
            break;
        case SmallBallStrikeTopBound:
            newAngle = 360-angle;
            break;
        case SmallBallStrikeBottomBound:
            newAngle = 360-angle;
            break;
        default:
            break;
    }
    return newAngle;
}

- (BOOL)movementStateOfFowardElement:(FowardElement *)sender{
    return YES;
}

@end
