//
//  TouchView.h
//  Beat-bricks
//
//  Created by 马遥 on 15/8/11.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TouchView;
@protocol TouchViewDelegate <NSObject>

@optional
- (void)touchView:(TouchView *)view movePoint:(CGPoint)point;

@end

@interface TouchView : UIView
@property (nonatomic, weak) id<TouchViewDelegate> delegate;
@end
