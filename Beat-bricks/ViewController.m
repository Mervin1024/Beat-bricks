//
//  ViewController.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/6.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<SmallBallDelegate>{
//    BOOL start;
    CGPoint initailCenter;
    StrikeBoundState smallBallStrikeBound;
}

@end

@implementation ViewController
CGFloat const ballSize = 18.0f;
CGFloat const lineHeight = 6.0f;
CGFloat const lineWidth = 100.0f;
CGFloat const distanceOfLine = 35.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBall];
    NSLog(@"%ld",self.view.subviews.count);
    [self initBaffle];
    NSLog(@"%ld",self.view.subviews.count);
    [self initButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBall{
//    start = NO;
    CGSize size = (CGSize){ballSize,ballSize};
    initailCenter = CGPointMake(self.view.center.x, self.view.frame.size.height-distanceOfLine-lineHeight-size.height/2);
    _smallBall = [SmallBall smallBallWithCenter:initailCenter size:size];
    _smallBall.smallBallDelegate = self;
    [self.view addSubview:_smallBall];
}

- (void)initBaffle{
    _baffle = [Baffle baffleWithFrame:CGRectMake(self.view.center.x-lineWidth/2, self.view.frame.size.height-distanceOfLine-lineHeight, lineWidth, lineHeight) superView:self.view];
    [self.view addSubview:_baffle];
}

- (void)initButton{
    _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _startButton.frame = CGRectMake(self.view.center.x-20, 35, 40, 20);
    [_startButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_startButton setTitle:@"start" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(begin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];
}

- (void)begin:(id)sender {
    if (!_smallBall.movementState) {
        _baffle.touchView.alpha = 1;
        [_smallBall setSportsSpiritCenter:initailCenter];
        _smallBall.movementState = YES;
        [_startButton setTitle:@"stop" forState:UIControlStateNormal];
        [_smallBall fowardWithAngle:60 velocity:20.0];
    }else{
        _baffle.touchView.alpha = 0;
        _smallBall.movementState = NO;
        [_startButton setTitle:@"start" forState:UIControlStateNormal];
        [_smallBall setSportsSpiritCenter:initailCenter];
    }
}

- (NSDictionary *(^)(void))terminationConditionOfSmallBall:(SportsSpirit *)sender{
    NSDictionary *(^changeAngle)(void) = ^(){
        if (_smallBall.currentBounds.bottomBounds >= self.baffle.center.y) {
            smallBallStrikeBound = StrikeBottomBound;
            return @{@"movementState":@YES,@"angle":@([self fowardAngleOfSmallBall])};
        }
        if (_smallBall.currentBounds.topBounds <= 0) {
            smallBallStrikeBound = StrikeTopBound;
            return @{@"movementState":@YES,@"angle":@([self fowardAngleOfSmallBall])};
        }
        if (_smallBall.currentBounds.rightBounds >= self.view.frame.size.width) {
            smallBallStrikeBound = StrikeRightBound;
            return @{@"movementState":@YES,@"angle":@([self fowardAngleOfSmallBall])};
        }
        if (_smallBall.currentBounds.leftBounds <= 0) {
            smallBallStrikeBound = StrikeLeftBound;
            return @{@"movementState":@YES,@"angle":@([self fowardAngleOfSmallBall])};
        }
        if (_smallBall.currentBounds.bottomBounds >= self.view.frame.size.height) {
            return @{@"movementState":@NO};
        }
        return @{};
    };
    return changeAngle;
    
}


- (double)fowardAngleOfSmallBall{
    double angle = _smallBall.currentAngle;
    double newAngle = 0;
    switch (smallBallStrikeBound) {
        case StrikeLeftBound:
            newAngle = 180-angle;
            break;
        case StrikeRightBound:
            newAngle = 180-angle;
            break;
        case StrikeTopBound:
            newAngle = 360-angle;
            break;
        case StrikeBottomBound:
            newAngle = 360-angle;
            break;
        default:
            break;
    }
    smallBallStrikeBound = StrikeLeftNone;
    return newAngle;
}

@end
