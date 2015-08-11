//
//  Baffle.h
//  Beat-bricks
//
//  Created by 马遥 on 15/8/11.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchView.h"

@interface Baffle : UIImageView<TouchViewDelegate>

@property (strong, nonatomic) TouchView *touchView;

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)view;
+ (instancetype)baffleWithFrame:(CGRect)frame superView:(UIView *)view;
@end
