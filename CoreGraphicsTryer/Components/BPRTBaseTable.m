//
//  BPRTBaseTable.m
//  CoreGraphicsTryer
//
//  Created by Roman-yu on 7/20/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTBaseTable.h"

@implementation BPRTBaseTable

- (void)drawSeatWithOrigin:(CGPoint)origin seatDirection:(SeatDirection)seatDirection {
    
    UIRectCorner corner = UIRectCornerAllCorners;
    switch (seatDirection) {
        case SeatDirectionTop:
            corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case SeatDirectionLeft:
            corner = UIRectCornerTopRight | UIRectCornerBottomRight;
            break;
        case SeatDirectionBottom:
            corner = UIRectCornerTopLeft | UIRectCornerTopRight;
            break;
        case SeatDirectionRight:
            corner = UIRectCornerTopLeft | UIRectCornerBottomLeft;
            break;
            
        default:
            break;
    }
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(origin.x, origin.y, kSeatWidth, kSeatHeight)
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(5.0, 5.0)];
    [[UIColor colorWithRed:224.0 / 255.0 green:231.0 / 255.0 blue:239.0 / 255.0 alpha:1.0] setFill];
    [path fill];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
