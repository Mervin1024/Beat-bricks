//
//  ViewController.m
//  Beat-bricks
//
//  Created by 马遥 on 15/8/6.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<SportsSpiritDelegate,BrickDelegate,BaffleDelegate>{
//    BOOL start;
    CGPoint initailBallCenter;
    CGPoint initailBaffleCenter;
    HitState smallBallHitBound;
    NSMutableArray *remainingBricks;
    NSMutableArray *bricksBeHit;
    BOOL isHitWithBricks;
    BOOL isHitWithBaffle;
    NSDictionary *stateOfBallDidHit;
//    NSMutableArray *whiteBricks;
//    NSMutableArray *oringeBricks;
//    NSMutableArray *greenBricks;
//    NSMutableArray *pinkBricks;
}

@end

@implementation ViewController
CGFloat const ballRadius = 15.0f;
CGSize const baffleSize = (CGSize){100.0f,8.0f};
CGFloat const distanceOfLine = 35.0f;


- (void)viewDidLoad {
    [super viewDidLoad];
    _life = 3;
    [self initBricks];
    [self initBall];
    [self initBaffle];
    [self initButton];
//    NSLog(@"%f",atan(-1)/M_PI*180);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBricks{
    remainingBricks = [NSMutableArray array];
    bricksBeHit = [NSMutableArray array];
    _bricksOfAll = [BricksOfAll bricksOfAll];
    for (Brick *brick in _bricksOfAll) {
        brick.Brickdelegate = self;
        [self.view addSubview:brick];
    }
    isHitWithBricks = NO;
    [remainingBricks addObjectsFromArray:_bricksOfAll];
    
}

- (void)initBall{
//    start = NO;
    initailBallCenter = CGPointMake(self.view.center.x, self.view.frame.size.height-distanceOfLine-baffleSize.height-ballRadius);
//    initailBallCenter = CGPointMake(360-ballRadius, 360-ballRadius-100);
    _smallBall = [SmallBall smallBallWithCenter:initailBallCenter size:CGSizeMake(ballRadius*2, ballRadius*2)];
    _smallBall.delegate = self;
    [self.view addSubview:_smallBall];
    stateOfBallDidHit = [NSDictionary dictionary];
}

- (void)initBaffle{
    initailBaffleCenter = (CGPoint){self.view.center.x, self.view.frame.size.height-distanceOfLine-baffleSize.height/2};
    _baffle = [Baffle baffleWithCenter:initailBaffleCenter size:baffleSize superView:self.view];
    _baffle.delegate = self;
    [self.view addSubview:_baffle];
    isHitWithBaffle = NO;
}

- (void)initButton{
    _startButton = [StartButton buttonWithCenter:self.view.center];
    [_startButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_startButton showWithTitle:@"开始"];
//    [_startButton setTitle:@"start" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(begin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];
}

- (void)begin:(id)sender {
    if (!_smallBall.movementState) {
        // reset startButton
        [_startButton dismiss];
        // reset smallBall
         _smallBall.movementState = YES;
        [_smallBall moveWithAngle:55 velocity:30.0];
        // reset baffle
        _baffle.moveEnabled = YES;
        // reset bricks
        for (Brick *brick in remainingBricks) {
            brick.hitEnabled = YES;
        }
        
    }else{
        // reset smallBall
        _smallBall.movementState = NO;
        [_smallBall setSportsSpiritCenter:initailBallCenter];
        // reset baffle
        _baffle.moveEnabled = NO;
        [_baffle setBaffleCenter:initailBaffleCenter];
        // reset bricks
        
        [remainingBricks addObjectsFromArray:bricksBeHit];
        for (Brick *brick in bricksBeHit) {
            [self.view addSubview:brick];
            brick.hitEnabled = NO;
        }
        bricksBeHit = [NSMutableArray array];
        // reset startButton
        [_startButton removeFromSuperview];
        [self.view addSubview:_startButton];
        [_startButton showWithTitle:@"重新开始"];
    }
    
}

#pragma mark - Small Ball Delegate

- (NSDictionary *(^)(void))terminationConditionOfSportsSpirit:(SportsSpirit *)sender{
    if (_smallBall == sender) {
        return ^(){
            if ([self isHitWithViewBounds]) {
                
                stateOfBallDidHit = @{@"movementState":@YES,@"angle":@([self angleOfSmallBallChanges])};
                return [NSDictionary dictionaryWithDictionary:stateOfBallDidHit];
            }
            if (isHitWithBricks) {
                isHitWithBricks = NO;
                return [NSDictionary dictionaryWithDictionary:stateOfBallDidHit];
            }
            if (isHitWithBaffle) {
                isHitWithBaffle = NO;
                return [NSDictionary dictionaryWithDictionary:stateOfBallDidHit];
            }
            return @{};
        };
    }
    return nil;
}
// Baffle 与 SmallBall 碰撞检测
#pragma mark - BrickDelegate
- (BOOL)baffle:(Baffle *)baffle didHitAngle:(double)angle velocity:(double)velocity{
    baffle.moveEnabled = NO;
    isHitWithBaffle = YES;
    stateOfBallDidHit = @{@"movementState":@YES,@"angle":@(angle)};
    return YES;
}

- (BOOL)isHitWithBaffle{
    CGFloat distance = _baffle.currentCenter.y - _smallBall.currentCenter.y;
    if (distance < 0) {
        return NO;
    }
    if (distance < _smallBall.radius){
        if (_smallBall.aroundPoint.bottomPoint.x >= _baffle.frame.origin.x &&
            _smallBall.aroundPoint.bottomPoint.x <= _baffle.frame.origin.x+baffleSize.width) {
            smallBallHitBound = HitBottomBound;
            return YES;
        }
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
    brick.hitEnabled = NO;
    if (remainingBricks.count == 0) {
        [self begin:nil];
        stateOfBallDidHit = @{};
    }
    
    
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
