//
//  BPRTCircleTable.m
//  CoreGraphicsTryer
//
//  Created by Roman-yu on 7/20/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTCircleTable.h"

@interface BPRTCircleTable ()

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger numberOfSeats;

@property (nonatomic, strong) UIImageView *seatImageView;
@property (nonatomic, strong) NSMutableArray *seats;

@end

@implementation BPRTCircleTable

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.numberOfSeats = 8;
        
        _seatImageView = [[UIImageView alloc] initWithFrame:frame];
//        [self addSubview:_seatImageView];
    }
    return self;
}

#pragma mark - Getter

- (NSMutableArray *)seats {
    if (!_seats) {
        _seats = [NSMutableArray new];
    }
    return _seats;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)drawSeats {
    for (int i = 0; i < self.numberOfSeats; i++) {
        [self drawSeatImageView:(360 / self.numberOfSeats * i)];
    }
}

- (void)drawSeatWithDegree:(CGFloat)degreeToRotate {
    
    for (int i = 0; i < 2; i++) {
        UIRectCorner corner = UIRectCornerAllCorners;
        CGPoint origin = CGPointZero;
        if (i == 0) {
            corner = UIRectCornerTopLeft | UIRectCornerTopRight;
            origin = CGPointMake(self.bounds.size.width / 2 - kSeatWidth / 2, 0);
        } else {
            corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            origin = CGPointMake(self.bounds.size.width / 2 - kSeatWidth / 2, self.bounds.size.height - kSeatHeight);
        }
        
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(origin.x, origin.y, kSeatWidth, kSeatHeight)
                                                   byRoundingCorners:corner
                                                         cornerRadii:CGSizeMake(5.0, 5.0)];
        
        degreeToRotate = M_PI * degreeToRotate / 180;
        CGAffineTransform transform = CGAffineTransformMakeRotation(degreeToRotate);
        [path applyTransform: transform];
        
        [[UIColor colorWithRed:224.0 / 255.0 green:231.0 / 255.0 blue:239.0 / 255.0 alpha:1.0] setFill];
        [path fill];
    }
}

- (void)drawSeatImageView:(CGFloat)degreeToRotate {
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - kSeatWidth / 2, 0, kSeatWidth, self.bounds.size.height)];
    
    UIGraphicsBeginImageContext(tempImageView.frame.size);
    
//    [self.seatImageView.image drawInRect:self.seatImageView.frame blendMode:kCGBlendModeNormal alpha:1.0];
    [tempImageView.image drawInRect:tempImageView.frame blendMode:kCGBlendModeNormal alpha:1.0];
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kSeatWidth, kSeatHeight)
                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake(5.0, 5.0)];
    
    [[UIColor blackColor] setFill];
    [path fill];
    
    // 5
    tempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat angle = M_PI * degreeToRotate / 180;
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    tempImageView.transform = transform;
    
    [self addSubview:tempImageView];
    [self.seats addObject:tempImageView];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    if (!CGRectIsEmpty(self.bounds)) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
                        radius:kCircleTableBaseRadius / 2
                    startAngle:0
                      endAngle:2 * M_PI
                     clockwise:YES];
        [[UIColor colorWithRed:187.0 / 255.0 green:204.0 / 255.0 blue:226.0 / 255.0 alpha:1.0] setFill];
        [path fill];
        
        [self drawSeats];
        
//        [self drawSeatImageView: 0];
//        [self drawSeatImageView: 90];
    }
}


@end
