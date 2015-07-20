//
//  BPRTRectTable.h
//  MonkeyPinch
//
//  Created by Chen YU on 17/7/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTBaseTable.h"

@interface BPRTRectTable : BPRTBaseTable

- (instancetype)initWithNumberOfSeats:(NSInteger)numberOfSeats tableSided:(TableSided)tableSided;

- (void)setNumberOfSeats:(NSInteger)numberOfSeats tableSided:(TableSided)tableSided;

- (void)rotateClockWise;

@end
