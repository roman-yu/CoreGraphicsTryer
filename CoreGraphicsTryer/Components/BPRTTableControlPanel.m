//
//  BPRTTableControlPanel.m
//  CoreGraphicsTryer
//
//  Created by Roman-yu on 7/18/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTTableControlPanel.h"
#import "BPRTBaseTable.h"
#import "BPRTBaseButton.h"

const CGFloat kButtonSize = 40.f;

@interface BPRTTableControlPanel ()

@property (nonatomic, strong) BPRTBaseButton *moveButton;
@property (nonatomic, strong) BPRTBaseButton *deleteButton;
@property (nonatomic, strong) BPRTBaseButton *editButton;
@property (nonatomic, strong) BPRTBaseButton *resizeButton;
@property (nonatomic, strong) BPRTBaseButton *rotateButton;

@end

@implementation BPRTTableControlPanel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _scaleFactor = 1.0f;
        _isMovable = NO;
        _isReziable = NO;
        _controlEvent = BPRTTableControlEventNone;
        [self _setupLayout];
    }
    return self;
}

#pragma mark - Layout

- (void)_setupLayout {
    _moveButton = [[BPRTBaseButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    _moveButton.tag = 0;
    _moveButton.backgroundColor = [UIColor blackColor];
    [_moveButton setImage:[UIImage imageNamed:@"move"] forState:UIControlStateNormal];
    [self addSubview:_moveButton];
    
    _deleteButton = [[BPRTBaseButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    _deleteButton.tag = 1;
    _deleteButton.backgroundColor = [UIColor redColor];
    [_deleteButton setImage:[UIImage imageNamed:@"close-or-delete"] forState:UIControlStateNormal];
    [self addSubview:_deleteButton];
    
    _editButton = [[BPRTBaseButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    _editButton.tag = 2;
    _editButton.backgroundColor = [UIColor blackColor];
    [_editButton setImage:[UIImage imageNamed:@"edit-filled"] forState:UIControlStateNormal];
    [self addSubview:_editButton];
    
    _resizeButton = [[BPRTBaseButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    _resizeButton.tag = 3;
    _resizeButton.backgroundColor = [UIColor blackColor];
    [_resizeButton setImage:[UIImage imageNamed:@"resize"] forState:UIControlStateNormal];
    [self addSubview:_resizeButton];
    
    _rotateButton = [[BPRTBaseButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    _rotateButton.tag = 4;
    _rotateButton.backgroundColor = [UIColor blackColor];
    [_rotateButton setImage:[UIImage imageNamed:@"rotate"] forState:UIControlStateNormal];
    [self addSubview:_rotateButton];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[BPRTBaseButton class]]) {
            view.userInteractionEnabled = NO;
            view.clipsToBounds = YES;
            view.layer.cornerRadius = kButtonSize / 2;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat radius = width / 2;
    CGFloat margin = radius - sqrtf( powf(radius, 2) / 2 );
 
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[BPRTBaseButton class]]) {
            if (view.tag == 0) {
                view.center = CGPointMake(radius, radius);
            } else if (view.tag == 1) {
                view.center = CGPointMake(margin, margin);
            } else if (view.tag == 2) {
                view.center = CGPointMake(width - margin, margin);
            } else if (view.tag == 3) {
                view.center = CGPointMake(width - margin, width - margin);
            } else {
                view.center = CGPointMake(margin, width - margin);
            }
            [self bringSubviewToFront:view];
        }
        if ([view isKindOfClass:[BPRTBaseTable class]]) {

            CGRect frame = view.frame;
            frame.size.width *= self.scaleFactor;
            frame.size.height *= self.scaleFactor;
            view.frame = frame;
            
            view.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    }
}

- (void)updateConstraints {
    
//    self.layoutMargins = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
//    
//    [self.moveButton autoCenterInSuperview];
//    
//    [self.deleteButton autoPinEdgeToSuperviewMargin:ALEdgeLeft];
//    [self.deleteButton autoPinEdgeToSuperviewMargin:ALEdgeTop];
//    
//    [self.editButton autoPinEdgeToSuperviewMargin:ALEdgeRight];
//    [self.editButton autoPinEdgeToSuperviewMargin:ALEdgeTop];
//    
//    [self.resizeButton autoPinEdgeToSuperviewMargin:ALEdgeRight];
//    [self.resizeButton autoPinEdgeToSuperviewMargin:ALEdgeBottom];
//    
//    [self.rotateButton autoPinEdgeToSuperviewMargin:ALEdgeLeft];
//    [self.rotateButton autoPinEdgeToSuperviewMargin:ALEdgeBottom];
    
//    for (UIView *view in self.subviews) {
//        view.userInteractionEnabled = NO;
//        view.clipsToBounds = YES;        
//        view.layer.cornerRadius = kButtonSize / 2;
//        [view autoSetDimensionsToSize:CGSizeMake(kButtonSize, kButtonSize)];
//    }
    
    [super updateConstraints];
}

#pragma mark - User Interaction

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    
    [self checkPointArea:point];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
}

#pragma mark - Internal Helper

- (void)checkPointArea:(CGPoint)point {
    if ([self isMoveArea:point]) {
        self.isMovable = YES;
        self.controlEvent = BPRTTableControlEventMove;
    } else {
        self.isMovable = NO;
    }
    
    if ([self isResizeArea:point]) {
        self.isReziable = YES;
        self.controlEvent = BPRTTableControlEventResize;
    } else {
        self.isReziable = NO;
    }
    
    if (!self.isMovable && !self.isReziable) {
        self.controlEvent = BPRTTableControlEventNone;
    }
}

- (BOOL)isMoveArea:(CGPoint)point {
    if ([self distanceFromPoint:point toPoint:self.moveButton.center] <= self.moveButton.frame.size.width / 2) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isResizeArea:(CGPoint)point {
    if ([self distanceFromPoint:point toPoint:self.resizeButton.center] <= self.resizeButton.frame.size.width / 2) {
        return YES;
    } else {
        return NO;
    }
}

- (CGFloat)distanceFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    return sqrtf( powf(fromPoint.x - toPoint.x, 2) + powf(fromPoint.y - toPoint.y, 2) );
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (!CGRectIsNull(self.bounds)) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 + 0.5)
                        radius:self.bounds.size.width / 2 - 1.5
                    startAngle:0
                      endAngle:2 * M_PI
                     clockwise:YES];
        path.lineWidth = 2.0f;
        [[UIColor blackColor] setStroke];
        [path stroke];
    }
}

@end
