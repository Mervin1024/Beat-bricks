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
    CGPoint initailBallCenter;
    CGPoint initailBaffleCenter;
    StrikeBoundState smallBallStrikeBound;
}

@end

@implementation ViewController
CGSize const ballSize = (CGSize){18.0f,18.0f};
CGSize const baffleSize = (CGSize){100.0f,6.0f};
CGFloat const distanceOfLine = 35.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBall];
    [self initBaffle];
    [self initButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBall{
//    start = NO;
    initailBallCenter = CGPointMake(self.view.center.x, self.view.frame.size.height-distanceOfLine-baffleSize.height-ballSize.height/2);
    _smallBall = [SmallBall smallBallWithCenter:initailBallCenter size:ballSize];
    _smallBall.smallBallDelegate = self;
    [self.view addSubview:_smallBall];
}

- (void)initBaffle{
    initailBaffleCenter = (CGPoint){self.view.center.x, self.view.frame.size.height-distanceOfLine-baffleSize.height/2};
    _baffle = [Baffle baffleWithCenter:initailBaffleCenter size:baffleSize superView:self.view];
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
        [_smallBall setSportsSpiritCenter:initailBallCenter];
        [_baffle setBaffleCenter:initailBaffleCenter];
        _smallBall.movementState = YES;
        _baffle.moveEnabled = YES;
        [_startButton setTitle:@"stop" forState:UIControlStateNormal];
        [_smallBall fowardWithAngle:120 velocity:20.0];
    }else{
        _smallBall.movementState = NO;
        _baffle.moveEnabled = NO;
        [_startButton setTitle:@"start" forState:UIControlStateNormal];
        [_smallBall setSportsSpiritCenter:initailBallCenter];
        [_baffle setBaffleCenter:initailBaffleCenter];
    }
}

- (NSDictionary *(^)(void))terminationConditionOfSmallBall:(SportsSpirit *)sender{
    NSDictionary *(^changeAngle)(void) = ^(){
        
        if ((NSInteger)_smallBall.aroundPoint.bottomPoint.y == (NSInteger)_baffle.currentCenter.y &&
            _smallBall.aroundPoint.bottomPoint.x >= _baffle.currentCenter.x-baffleSize.width/2 &&
            _smallBall.aroundPoint.bottomPoint.x <= _baffle.currentCenter.x+baffleSize.width/2) {
            smallBallStrikeBound = StrikeBottomBound;
            return @{@"movementState":@YES,@"angle":@([self fowardAngleOfSmallBall])};
        }
        if (_smallBall.aroundPoint.topPoint.y <= 0) {
            smallBallStrikeBound = StrikeTopBound;
            return @{@"movementState":@YES,@"angle":@([self fowardAngleOfSmallBall])};
        }
        if (_smallBall.aroundPoint.rightPoint.x >= self.view.frame.size.width) {
            smallBallStrikeBound = StrikeRightBound;
            return @{@"movementState":@YES,@"angle":@([self fowardAngleOfSmallBall])};
        }
        if (_smallBall.aroundPoint.leftPoint.x <= 0) {
            smallBallStrikeBound = StrikeLeftBound;
            return @{@"movementState":@YES,@"angle":@([self fowardAngleOfSmallBall])};
        }
        if (_smallBall.aroundPoint.bottomPoint.y >= self.view.frame.size.height) {
            [self begin:nil];
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
