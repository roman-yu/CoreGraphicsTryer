//
//  BPRTRectTable.m
//  MonkeyPinch
//
//  Created by Chen YU on 17/7/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTRectTable.h"

@interface BPRTRectTable ()

@property (nonatomic, assign) NSInteger numberOfSeats;
@property (nonatomic, assign) TableSided tableSided;

@end

@implementation BPRTRectTable

- (instancetype)initWithNumberOfSeats:(NSInteger)numberOfSeats tableSided:(TableSided)tableSided {
    if (self = [super init]) {
        _numberOfSeats = numberOfSeats;
        _tableSided = tableSided;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setNumberOfSeats:(NSInteger)numberOfSeats tableSided:(TableSided)tableSided {
    
    self.numberOfSeats = numberOfSeats;
    self.tableSided = tableSided;

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)drawRect:(CGRect)rect {
    
    [self drawTable];
    [self drawSeats];
}

- (void)drawTable {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(8.f, 8.f)];
    [path addLineToPoint:CGPointMake(8.f + kTableBaseWidth, 8.0)];
    [path addLineToPoint:CGPointMake(8.f + kTableBaseWidth, 8.f + kTableBaseHeight)];
    [path addLineToPoint:CGPointMake(8.f, 8.f + kTableBaseHeight)];
    [path closePath];
//    path.lineWidth = 1;
    [[UIColor colorWithRed:187.0 / 255.0 green:204.0 / 255.0 blue:226.0 / 255.0 alpha:1.0] setFill];
    [path fill];
}

- (void)drawSeats {
    
    for (int i = 0; i < self.numberOfSeats; i++) {
        if (self.tableSided == TableSidedOne) {
            if (self.numberOfSeats == 1) {
                [self drawSeatWithOrigin:CGPointMake(8.f + kTableBaseWidth / 2 - kSeatWidth / 2, 0) seatDirection:SeatDirectionBottom];
            } else {
               [self drawSeatWithOrigin:CGPointMake(8.f + tableHorizontalSpacing * (i + 1) + kTableBaseWidth * i, 0) seatDirection:SeatDirectionBottom];
            }
        } else if (self.tableSided == TableSidedTwo) {
            
        } else {
            
        }
    }
}

@end
