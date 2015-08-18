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
    NSMutableArray *whiteBricks;
    NSMutableArray *oringeBricks;
    NSMutableArray *greenBricks;
}

@end

@implementation ViewController
CGFloat const ballRadius = 60.0f;
CGSize const baffleSize = (CGSize){100.0f,8.0f};
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
//    whiteBricks = [NSMutableArray array];
//    oringeBricks = [NSMutableArray array];
//    greenBricks = [NSMutableArray array];
//    CGFloat brickWidth = self.view.frame.size.width/numberOfBricksAtRow;
//    // 白色砖块
//    for (int i = 0; i < 11; i++) {
//        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/11) + self.view.center.x-brickWidth/2*1, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleWhite];
//        brick.Brickdelegate = self;
//        [self.view addSubview:brick];
//        [whiteBricks addObject:brick];
//    }
//    // 绿色砖块
//    for (int i = 0; i < 9; i++) {
//        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/9) + self.view.center.x-brickWidth/2*3, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleGreen];
//        brick.Brickdelegate = self;
//        [self.view addSubview:brick];
//        [greenBricks addObject:brick];
//    }
//    for (int i = 0; i < 9; i++) {
//        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/9) + self.view.center.x+brickWidth/2*1, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleGreen];
//        brick.Brickdelegate = self;
//        [self.view addSubview:brick];
//        [greenBricks addObject:brick];
//    }
//    // 橘红砖块
//    for (int i = 0; i < 7; i++) {
//        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/7) + self.view.center.x-brickWidth/2*5, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleOringe];
//        brick.Brickdelegate = self;
//        [self.view addSubview:brick];
//        [oringeBricks addObject:brick];
//    }
//    for (int i = 0; i < 7; i++) {
//        Brick *brick = [Brick brickWithFrame:CGRectMake(brickWidth * (i/7) + self.view.center.x+brickWidth/2*3, brickHight * (i/1 + 1), brickWidth, brickHight) style:BrickStyleOringe];
//        brick.Brickdelegate = self;
//        [self.view addSubview:brick];
//        [oringeBricks addObject:brick];
//    }
//    isHitWithBricks = NO;
//    [remainingBricks addObjectsFromArray:whiteBricks];
//    [remainingBricks addObjectsFromArray:greenBricks];
//    [remainingBricks addObjectsFromArray:oringeBricks];
    Brick *brick = [Brick brickWithFrame:CGRectMake(130, 130, 100, 100) style:BrickStyleBlue];
    brick.Brickdelegate = self;
    [self.view addSubview:brick];
    [remainingBricks addObject:brick];
    _bricksOfAll = [NSArray arrayWithArray:remainingBricks];
    
}

- (void)initBall{
//    start = NO;
//    initailBallCenter = CGPointMake(self.view.center.x, self.view.frame.size.height-distanceOfLine-baffleSize.height-ballSize.height/2);
    initailBallCenter = CGPointMake(360-ballRadius, 360-ballRadius-100);
    _smallBall = [SmallBall smallBallWithCenter:initailBallCenter size:CGSizeMake(ballRadius, ballRadius)];
    _smallBall.delegate = self;
    [self.view addSubview:_smallBall];
    stateOfBallDidHit = [NSDictionary dictionary];
}

- (void)initBaffle{
    initailBaffleCenter = (CGPoint){400, self.view.frame.size.height-distanceOfLine-baffleSize.height/2};
    _baffle = [Baffle baffleWithCenter:initailBaffleCenter size:baffleSize superView:self.view];
    [self.view addSubview:_baffle];
}

- (void)initButton{
    _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _startButton.frame = CGRectMake(self.view.frame.origin.x+35, 35, 40, 20);
    [_startButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_startButton setTitle:@"start" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(begin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];
}

- (void)begin:(id)sender {
    if (!_smallBall.movementState) {
        NSLog(@"START");
        // reset smallBall
         _smallBall.movementState = YES;
        [_smallBall moveWithAngle:160 velocity:10.0];
        // reset baffle
        _baffle.moveEnabled = YES;
        // reset startButton
        [_startButton setTitle:@"stop" forState:UIControlStateNormal];
        // reset bricks
        for (Brick *brick in remainingBricks) {
            brick.hitEnabled = YES;
        }
        
    }else{
        NSLog(@"STOP");
        // reset smallBall
        _smallBall.movementState = NO;
        [_smallBall setSportsSpiritCenter:initailBallCenter];
        // reset baffle
        _baffle.moveEnabled = NO;
        [_baffle setBaffleCenter:initailBaffleCenter];
        // reset startButton
        [_startButton setTitle:@"start" forState:UIControlStateNormal];
        // reset bricks
        
        [remainingBricks addObjectsFromArray:bricksBeHit];
        for (Brick *brick in bricksBeHit) {
            [self.view addSubview:brick];
            brick.hitEnabled = NO;
        }
        bricksBeHit = [NSMutableArray array];
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
                isHitWithBricks = NO;
                return [NSDictionary dictionaryWithDictionary:stateOfBallDidHit];
            }
            return @{};
        };
    }
    return nil;
}
// Baffle 与 SmallBall 碰撞检测
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
//    if (_smallBall.aroundPoint.rightPoint.x >= self.view.frame.size.width) {
//        smallBallHitBound = HitRightBound;
//        return YES;
//    }
    
    ///////////////////
    if (_smallBall.aroundPoint.rightPoint.x >= 360) {
        smallBallHitBound = HitRightBound;
        return YES;
    }
    ////////////////////
    
    if (_smallBall.aroundPoint.leftPoint.x <= 0) {
        smallBallHitBound = HitLeftBound;
        return YES;
    }
//    if (_smallBall.aroundPoint.bottomPoint.y >= self.view.frame.size.height) {
//        [self begin:nil];
//    }
    
    ///////////////
    if (_smallBall.aroundPoint.bottomPoint.y >= 360) {
        smallBallHitBound = HitBottomBound;
        return YES;
    }
    //////////////
    return NO;
}
// Bricks 与 SmallBall 碰撞检测
#pragma mark - BrickDelegate
- (BOOL)birck:(Brick *)brick didHitAngle:(double)angle velocity:(double)velocity{
    isHitWithBricks = YES;
    stateOfBallDidHit = @{@"movementState":@YES,@"angle":@(angle)};
//    [brick removeFromSuperview];
//    [remainingBricks removeObject:brick];
//    [bricksBeHit addObject:brick];
//    brick.hitEnabled = NO;
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
