//
//  BPRTBaseTable.h
//  CoreGraphicsTryer
//
//  Created by Roman-yu on 7/20/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

typedef enum  {
    SeatDirectionTop = 0,
    SeatDirectionLeft,
    SeatDirectionBottom,
    SeatDirectionRight
} SeatDirection;

typedef enum  {
    TableSidedOne = 0,
    TableSidedTwo,
    TableSidedFour
} TableSided;

@interface BPRTBaseTable : UIView

- (void)drawSeatWithOrigin:(CGPoint)origin seatDirection:(SeatDirection)seatDirection;

@end
