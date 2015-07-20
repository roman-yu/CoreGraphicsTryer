//
//  BPRTCircleTable.m
//  CoreGraphicsTryer
//
//  Created by Roman-yu on 7/20/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTCircleTable.h"

//const CGFloat kSeatWidth                = 20.f;
//const CGFloat kSeatHeight               = 5.f;
//
//const CGFloat tableHorizontalSpacing    = 10.f;

@interface BPRTCircleTable ()

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger numberOfSeats;

@end

@implementation BPRTCircleTable

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)drawSeats {
    
//    for (int i = 0; i < self.numberOfSeats; i++) {
//        if (self.numberOfSeats == 1) {
//            [self drawSeatWithOrigin:CGPointMake(8.f + kTableBaseWidth / 2 - kSeatWidth / 2, 0) seatDirection:SeatDirectionBottom];
//        } else {
//            [self drawSeatWithOrigin:CGPointMake(8.f + tableHorizontalSpacing * (i + 1) + kTableBaseWidth * i, 0) seatDirection:SeatDirectionBottom];
//        }
//    }
}

- (void)drawSeatWithOrigin:(CGPoint)origin seatDirection:(SeatDirection)seatDirection {
    
//    UIRectCorner corner = UIRectCornerAllCorners;
//    switch (seatDirection) {
//        case SeatDirectionTop:
//            corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
//            break;
//        case SeatDirectionLeft:
//            corner = UIRectCornerTopRight | UIRectCornerBottomRight;
//            break;
//        case SeatDirectionBottom:
//            corner = UIRectCornerTopLeft | UIRectCornerTopRight;
//            break;
//        case SeatDirectionRight:
//            corner = UIRectCornerTopLeft | UIRectCornerBottomLeft;
//            break;
//            
//        default:
//            break;
//    }
    
//    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(origin.x, origin.y, kSeatWidth, kSeatHeight)
//                                               byRoundingCorners:corner
//                                                     cornerRadii:CGSizeMake(5.0, 5.0)];
//    [[UIColor colorWithRed:224.0 / 255.0 green:231.0 / 255.0 blue:239.0 / 255.0 alpha:1.0] setFill];
//    [path fill];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    if (!CGRectIsEmpty(self.bounds)) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
                        radius:self.bounds.size.width / 2
                    startAngle:0
                      endAngle:2 * M_PI
                     clockwise:YES];
        [[UIColor cyanColor] setFill];
        [path fill];
    }
}


@end
