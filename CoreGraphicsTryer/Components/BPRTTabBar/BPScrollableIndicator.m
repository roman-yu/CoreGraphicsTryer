//
//  BPScrollableIndicator.m
//  ChildVCPureLayoutTryer
//
//  Created by Roman-yu on 6/28/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPScrollableIndicator.h"

@interface BPScrollableIndicator ()

@property (nonatomic, assign) BPScrollableIndicatorDirection direction;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) UIImageView *indicatorView;

@end

@implementation BPScrollableIndicator

- (instancetype)initWithDirection:(BPScrollableIndicatorDirection)direction {
    if (self = [super init]) {
        self.direction = direction;
        [self setUserInteractionEnabled:NO];
        
        [self _setupLayout];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.gradientLayer.frame = self.direction == BPScrollableIndicatorDirectionLeft ?
        CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height) :
        CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height);
    
    self.indicatorView.frame = self.direction == BPScrollableIndicatorDirectionLeft ?
        CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height) :
        CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height);
}

#pragma mark - Layout

- (void)_setupLayout {
    [self addSubview: self.indicatorView];
    [self.layer addSublayer:self.gradientLayer];
}

#pragma mark - Getter

- (UIImageView *)indicatorView {
    if (!_indicatorView) {
        UIImage *indicImage;
        if (self.direction == BPScrollableIndicatorDirectionLeft) {
            indicImage = [[UIImage alloc] initWithCGImage:[UIImage imageNamed:@"list-chevron"].CGImage
                                                    scale:1.0
                                              orientation:UIImageOrientationUpMirrored];
        } else {
            indicImage = [UIImage imageNamed:@"list-chevron"];
        }

        _indicatorView = [[UIImageView alloc] initWithImage:indicImage];
        _indicatorView.backgroundColor = [UIColor whiteColor];
    }
    return _indicatorView;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        
        CGColorRef beginColor = [[UIColor colorWithWhite:1.0 alpha:0.0] CGColor];
        CGColorRef endColor = [[UIColor colorWithWhite:1.0 alpha:1.0] CGColor];
        
        if (self.direction == BPScrollableIndicatorDirectionLeft) {
            _gradientLayer.colors = [NSArray arrayWithObjects:
                                     (__bridge id)endColor,
                                     (__bridge id)beginColor, nil];
        } else {
            _gradientLayer.colors = [NSArray arrayWithObjects:
                                     (__bridge id)beginColor,
                                     (__bridge id)endColor, nil];
        }
        
        _gradientLayer.locations = [NSArray arrayWithObjects:
                                    [NSNumber numberWithFloat:0.0],
                                    [NSNumber numberWithFloat:1.0], nil];
        
        [_gradientLayer setStartPoint:CGPointMake(0, 0.5)];
        [_gradientLayer setEndPoint:CGPointMake(1, 0.5)];
        
        _gradientLayer.anchorPoint = CGPointZero;
    }
    return _gradientLayer;
}

@end
