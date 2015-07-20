//
//  BPRTSearchBar.m
//  CoreGraphicsTryer
//
//  Created by Roman-yu on 7/18/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTSearchBar.h"

@interface BPRTSearchBar ()

@property (nonatomic, strong) UIView *upView;
@property (nonatomic, strong) UIView *downView;

@end

@implementation BPRTSearchBar

- (instancetype)init {
    if (self = [super init]) {
        _upView = [UIView new];
        [self addSubview:_upView];
        
        _downView = [UIView new];
        [self addSubview:_downView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.upView.backgroundColor = self.barTintColor;
    self.downView.backgroundColor = self.barTintColor;
}

- (void)updateConstraints {
    
    [self.upView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.upView autoSetDimension:ALDimensionHeight toSize:1.0f];
    
    [self.downView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.downView autoSetDimension:ALDimensionHeight toSize:1.0f];
    
    [super updateConstraints];
}

@end
