//
//  BricksOfAll.h
//  Beat-bricks
//
//  Created by sh219 on 15/8/21.
//  Copyright (c) 2015年 Mervin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Brick.h"

@interface BricksOfAll : NSObject

+ (NSArray *)bricksOfAll;

@property (copy, nonatomic) NSMutableArray *allBricks;
@property (copy, nonatomic) NSMutableArray *whiteBricks;
@property (copy, nonatomic) NSMutableArray *oringeBricks;
@property (copy, nonatomic) NSMutableArray *greenBricks;
@property (copy, nonatomic) NSMutableArray *pinkBricks;

@property (copy, nonatomic) NSArray *animateItems;
@end
