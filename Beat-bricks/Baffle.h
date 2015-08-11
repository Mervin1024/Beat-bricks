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
@property (assign, nonatomic) BOOL moveEnabled;

@property (assign, nonatomic, readonly) CGPoint currentCenter;
- (void)setBaffleCenter:(CGPoint)center;

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)view;
- (instancetype)initWithCenter:(CGPoint)center size:(CGSize)size superView:(UIView *)view;
+ (instancetype)baffleWithCenter:(CGPoint)center size:(CGSize)size superView:(UIView *)view;
@end
