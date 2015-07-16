//
//  BPRTPolygonView.m
//  CoreGraphicsTryer
//
//  Created by Chen YU on 15/7/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTPolygonView.h"

@interface BPRTPolygonView ()

@property (nonatomic, ) CGGradientRef gradient;

@end

@implementation BPRTPolygonView

#pragma mark - Getter

- (CGGradientRef)gradient {
    if(NULL == _gradient) {
        CGFloat colors[6] = {138.0f/255.0f, 1.0f,
            162.0f/255.0f, 1.0f,
            206.0f/255.0f, 1.0f};
        CGFloat locations[3] = {0.05f, 0.45f, 0.95f};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        _gradient = CGGradientCreateWithColorComponents(colorSpace, colors,
                                                        locations, 3);
        CGColorSpaceRelease(colorSpace);
    }
    return _gradient;
}

- (void)drawGradient {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = [self gradient];
    CGPoint startPoint =
    CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endPoint =
    CGPointMake(CGRectGetMidX(self.bounds),
                CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(ctx, gradient,
                                startPoint, endPoint, 0);
}

- (void)drawOctagon {
    
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    CGContextSaveGState(ctx);
    //    CGFloat shadowHeight = 2.0;
    //    CGContextSetShadowWithColor(ctx, CGSizeMake(1.0, -shadowHeight), 0.0, [[UIColor orangeColor] CGColor]);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(16.72, 7.22)];
    [path addLineToPoint:CGPointMake(3.29, 20.83)];
    [path addLineToPoint:CGPointMake(0.4, 18.05)];
    [path addLineToPoint:CGPointMake(18.8, -0.47)];
    [path addLineToPoint:CGPointMake(37.21, 18.05)];
    [path addLineToPoint:CGPointMake(34.31, 20.83)];
    [path addLineToPoint:CGPointMake(20.88, 7.22)];
    [path addLineToPoint:CGPointMake(20.88, 42.18)];
    [path addLineToPoint:CGPointMake(16.72, 42.18)];
    [path addLineToPoint:CGPointMake(16.72, 7.22)];
    [path closePath];
    path.lineWidth = 1;
    [[UIColor redColor] setStroke];
    [path stroke];
    
    //    CGContextRestoreGState(ctx);
}

- (void)drawCircle {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //    UIColor *yellowColor = [UIColor yellowColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0)
                    radius:50.0
                startAngle:0.0
                  endAngle:2.0 * M_PI
                 clockwise:NO];
    
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20.0, 20.0, 20.0, 20.0)];
    
    //    [yellowColor setFill];
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    [path fill];
    
    //    CGContextAddRect(ctx, CGRectMake(100.0, 100.0, 40.0, 40.0));
    //    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    //    CGContextFillPath(ctx);
}

- (void)fillPath {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGFloat shadowHeight = 2.0;
    CGContextSetShadowWithColor(ctx, CGSizeMake(1.0, -shadowHeight), 0.0, [[UIColor orangeColor] CGColor]);
    
    CGContextAddRect(ctx, CGRectMake(40.0, 40.0, 20.f, 20.f));
    CGContextSetFillColorWithColor(ctx, [UIColor cyanColor].CGColor);
    CGContextFillPath(ctx);
    
    CGContextRestoreGState(ctx);
}

- (void)drawShadow {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    CGFloat shadowHeight = 2.0;
    CGContextSetShadowWithColor(ctx, CGSizeMake(1.0, -shadowHeight), 0.0, [[UIColor orangeColor] CGColor]);
    CGContextRestoreGState(ctx);
}

- (void)drawRoundedRect {
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 20, 5)
                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake(5.0, 5.0)];
    [UIColor.blackColor setFill];
    [path fill];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(16.0, 16.0)];
    [path addClip];
    
    [[UIColor blueColor] setFill];
    UIRectFill(self.bounds);
    
    [self drawOctagon];
    
    [self fillPath];
    
    [self drawCircle];
    
    [self drawGradient];
    
    [self drawRoundedRect];
    
}

@end
