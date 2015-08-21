//
//  ViewController.h
//  Beat-bricks
//
//  Created by 马遥 on 15/8/6.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallBall.h"
#import "TouchView.h"
#import "Baffle.h"
#import "Brick.h"
#import "StartButton.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) SmallBall *smallBall;
@property (strong, nonatomic) Baffle *baffle;
@property (strong, nonatomic)  StartButton *startButton;
@property (copy, nonatomic) NSArray *bricksOfAll;
@property (assign, nonatomic, readonly) NSInteger life;
@end

