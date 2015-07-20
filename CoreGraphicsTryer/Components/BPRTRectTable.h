//
//  BPRTRectTable.h
//  MonkeyPinch
//
//  Created by Chen YU on 17/7/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@interface BPRTRectTable : UIView

- (instancetype)initWithNumberOfSeats:(NSInteger)numberOfSeats tableSided:(TableSided)tableSided;

- (void)setNumberOfSeats:(NSInteger)numberOfSeats tableSided:(TableSided)tableSided;

- (void)rotateClockWise;

@end
