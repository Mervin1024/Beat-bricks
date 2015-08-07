//
//  ViewController.h
//  Beat-bricks
//
//  Created by 马遥 on 15/8/6.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallBall.h"

@interface ViewController : UIViewController

- (IBAction)begin:(id)sender;
@property (strong, nonatomic, readonly) SmallBall *smallBall;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@end

