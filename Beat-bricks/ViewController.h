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

@interface ViewController : UIViewController

@property (strong, nonatomic, readonly) SmallBall *smallBall;
@property (strong, nonatomic) Baffle *baffle;
@property (strong, nonatomic)  UIButton *startButton;
@end

