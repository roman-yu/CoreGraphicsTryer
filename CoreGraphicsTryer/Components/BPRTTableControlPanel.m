//
//  BPRTTableControlPanel.m
//  CoreGraphicsTryer
//
//  Created by Roman-yu on 7/18/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTTableControlPanel.h"

const CGFloat kButtonSize = 40.f;

@interface BPRTTableControlPanel ()

@property (nonatomic, strong) UIButton *moveButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *resizeButton;
@property (nonatomic, strong) UIButton *rotateButton;

@end

@implementation BPRTTableControlPanel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self _setupLayout];
    }
    return self;
}

- (void)_setupLayout {
    _moveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    _moveButton.tag = 0;
    _moveButton.backgroundColor = [UIColor blackColor];
    [_moveButton setImage:[UIImage imageNamed:@"move"] forState:UIControlStateNormal];
    [self addSubview:_moveButton];
    
    _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    _deleteButton.tag = 1;
    _deleteButton.backgroundColor = [UIColor redColor];
    [_deleteButton setImage:[UIImage imageNamed:@"close-or-delete"] forState:UIControlStateNormal];
    [self addSubview:_deleteButton];
    
    _editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    _editButton.tag = 2;
    _editButton.backgroundColor = [UIColor blackColor];
    [_editButton setImage:[UIImage imageNamed:@"edit-filled"] forState:UIControlStateNormal];
    [self addSubview:_editButton];
    
    _resizeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    _resizeButton.tag = 3;
    _resizeButton.backgroundColor = [UIColor blackColor];
    [_resizeButton setImage:[UIImage imageNamed:@"resize"] forState:UIControlStateNormal];
    [self addSubview:_resizeButton];
    
    _rotateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonSize, kButtonSize)];
    _rotateButton.tag = 4;
    _rotateButton.backgroundColor = [UIColor blackColor];
    [_rotateButton setImage:[UIImage imageNamed:@"rotate"] forState:UIControlStateNormal];
    [self addSubview:_rotateButton];
    
    for (UIView *view in self.subviews) {
        view.userInteractionEnabled = NO;
        view.clipsToBounds = YES;
        view.layer.cornerRadius = kButtonSize / 2;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat radius = width / 2;
    CGFloat margin = radius - sqrtf( powf(radius, 2) / 2 );
 
    for (UIButton *view in self.subviews) {
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
        [[UIColor blackColor] setStroke];
        [path stroke];
    }
}

@end
