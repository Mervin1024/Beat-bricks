//
//  BricksView.h
//  Beat-bricks
//
//  Created by sh219 on 15/8/21.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BricksOfAll.h"

@interface BricksView : UIView

@property (copy, nonatomic) NSArray *allBricks;

- (void)show;
- (void)dismiss;
@end
