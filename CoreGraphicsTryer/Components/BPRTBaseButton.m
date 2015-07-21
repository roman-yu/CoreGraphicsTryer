//
//  BPRTBaseButton.m
//  CoreGraphicsTryer
//
//  Created by Chen YU on 21/7/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTBaseButton.h"

@implementation BPRTBaseButton

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
//    [[self superview] touchesBegan:touches withEvent:event];
//    [super touchesBegan:touches withEvent:event];
    
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}

@end
