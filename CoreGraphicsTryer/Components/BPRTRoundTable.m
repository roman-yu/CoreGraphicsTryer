//
//  BPRTRoundTable.m
//  CoreGraphicsTryer
//
//  Created by Roman-yu on 7/20/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTRoundTable.h"

@interface BPRTRoundTable ()

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger numberOfSeats;

@property (nonatomic, strong) UIImageView *seatImageView;

@end

@implementation BPRTRoundTable

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.numberOfSeats = 8;
        
        _seatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_seatImageView];
    }
    return self;
}

#pragma mark - Getter

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)updateConstraints {
    [self.seatImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [super updateConstraints];
}

- (void)drawSeats {
    for (int i = 0; i < self.numberOfSeats; i++) {
        UIColor *color = [@[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor]] objectAtIndex:(arc4random() % 4)];
        [self drawSeatImageView:(360 / self.numberOfSeats * i) withColor:color];
    }
    
    UIGraphicsBeginImageContext(self.seatImageView.frame.size);
    [self.seatImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.seatImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.seatImageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)drawSeatImageView:(CGFloat)degreeToRotate withColor:(UIColor *)color {
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    UIGraphicsBeginImageContext(tempImageView.frame.size);
    
    [tempImageView.image drawInRect:tempImageView.frame blendMode:kCGBlendModeNormal alpha:1.0];
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.bounds.size.width / 2 - kSeatWidth / 2, 0, kSeatWidth, kSeatHeight)
                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake(5.0, 5.0)];
    
    [color setFill];
    [path fill];
    
    // 5
    tempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat angle = M_PI * degreeToRotate / 180;
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    tempImageView.transform = transform;
    
    [self.seatImageView addSubview:tempImageView];
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
    }
}


@end
