//
//  ViewController.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/6.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<SportsSpiritDelegate,BrickDelegate>{
//    BOOL start;
    CGPoint initailBallCenter;
    CGPoint initailBaffleCenter;
    HitState smallBallHitBound;
    NSMutableArray *remainingBricks;
    NSMutableArray *bricksBeHit;
    BOOL isHitWithBricks;
    NSDictionary *stateOfBallDidHit;
}

@end

@implementation ViewController
CGSize const ballSize = (CGSize){18.0f,18.0f};
CGSize const baffleSize = (CGSize){100.0f,6.0f};
CGFloat const distanceOfLine = 35.0f;
CGFloat const brickHight = 15.0f;
NSInteger const numberOfBricksAtRow = 17;

- (void)viewDidLoad {
    [super viewDidLoad];
    _life = 3;
    [self initBricks];
    [self initBall];
    [self initBaffle];
    [self initButton];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBricks{
    remainingBricks = [NSMutableArray array];
    bricksBeHit = [NSMutableArray array];
    CGFloat brickWidth = self.view.frame.size.width/numberOfBricksAtRow;
    for (int i = 0; i < 11; i++) {
        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * i, brickHight * (i/11 + 1), brickWidth, brickHight) style:BrickStyleWhite];
        brick.tag = i + 10;
        brick.Brickdelegate = self;
        [self.view addSubview:brick];
        [remainingBricks addObject:brick];
    }
    isHitWithBricks = NO;
    _bricksOfAll = [NSArray arrayWithArray:remainingBricks];
}

- (void)initBall{
//    start = NO;
    initailBallCenter = CGPointMake(self.view.center.x, self.view.frame.size.height-distanceOfLine-baffleSize.height-ballSize.height/2);
    _smallBall = [SmallBall smallBallWithCenter:initailBallCenter size:ballSize];
    _smallBall.delegate = self;
    [self.view addSubview:_smallBall];
    stateOfBallDidHit = [NSDictionary dictionary];
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
        // reset smallBall
         _smallBall.movementState = YES;
        [_smallBall moveWithAngle:120 velocity:20.0];
        // reset baffle
        _baffle.moveEnabled = YES;
        // reset startButton
        [_startButton setTitle:@"stop" forState:UIControlStateNormal];
        // reset bricks
        
        
    }else{
        // reset smallBall
        [_smallBall setSportsSpiritCenter:initailBallCenter];
        _smallBall.movementState = NO;
        // reset baffle
        [_baffle setBaffleCenter:initailBaffleCenter];
        _baffle.moveEnabled = NO;
        // reset startButton
        [_startButton setTitle:@"start" forState:UIControlStateNormal];
        // reset bricks
        for (Brick *brick in remainingBricks) {
            [brick removeFromSuperview];
        }
        for (Brick *brick in _bricksOfAll) {
            [self.view addSubview:brick];
        }
        
    }
}

#pragma mark - Small Ball Delegate

- (NSDictionary *(^)(void))terminationConditionOfSportsSpirit:(SportsSpirit *)sender{
    if (_smallBall == sender) {
        return ^(){
            if ([self isHitWithBaffle] || [self isHitWithViewBounds]) {
                stateOfBallDidHit = @{@"movementState":@YES,@"angle":@([self angleOfSmallBallChanges])};
                return [NSDictionary dictionaryWithDictionary:stateOfBallDidHit];
            }
            if (isHitWithBricks) {
                return [NSDictionary dictionaryWithDictionary:stateOfBallDidHit];
            }
            return @{};
        };
    }
    return nil;
}
// Baffle 与 SmallBall 碰撞检测
- (BOOL)isHitWithBaffle{
    if ((NSInteger)_smallBall.aroundPoint.bottomPoint.y == (NSInteger)_baffle.currentCenter.y &&
                   _smallBall.aroundPoint.bottomPoint.x >= _baffle.frame.origin.x &&
                   _smallBall.aroundPoint.bottomPoint.x <= _baffle.frame.origin.x+baffleSize.width) {
        smallBallHitBound = HitBottomBound;
        return YES;
    }
    return NO;
}
// ViewBounds 与 SmallBall 碰撞检测
- (BOOL)isHitWithViewBounds{
    if (_smallBall.aroundPoint.topPoint.y <= 0) {
        smallBallHitBound = HitTopBound;
        return YES;
    }
    if (_smallBall.aroundPoint.rightPoint.x >= self.view.frame.size.width) {
        smallBallHitBound = HitRightBound;
        return YES;
    }
    if (_smallBall.aroundPoint.leftPoint.x <= 0) {
        smallBallHitBound = HitLeftBound;
        return YES;
    }
    if (_smallBall.aroundPoint.bottomPoint.y >= self.view.frame.size.height) {
        [self begin:nil];
    }
    return NO;
}
// Bricks 与 SmallBall 碰撞检测
#pragma mark - BrickDelegate
- (BOOL)birck:(Brick *)brick didHitAngle:(double)angle velocity:(double)velocity{
    isHitWithBricks = YES;
    stateOfBallDidHit = @{@"movementState":@YES,@"angle":@(angle)};
    [brick removeFromSuperview];
    [remainingBricks removeObject:brick];
    [bricksBeHit addObject:brick];
    return YES;
}

- (double)angleOfSmallBallChanges{
    double angle = _smallBall.currentAngle;
    double newAngle = 0;
    switch (smallBallHitBound) {
        case HitLeftBound:
            newAngle = 180-angle;
            break;
        case HitRightBound:
            newAngle = 180-angle;
            break;
        case HitTopBound:
            newAngle = 360-angle;
            break;
        case HitBottomBound:
            newAngle = 360-angle;
            break;
        default:
            break;
    }
    smallBallHitBound = HitNone;
    return newAngle;
}

@end
