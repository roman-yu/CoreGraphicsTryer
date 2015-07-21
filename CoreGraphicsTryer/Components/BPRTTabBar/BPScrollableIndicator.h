//
//  BPScrollableIndicator.h
//  ChildVCPureLayoutTryer
//
//  Created by Roman-yu on 6/28/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

typedef enum {
    BPScrollableIndicatorDirectionLeft = 0,
    BPScrollableIndicatorDirectionRight
} BPScrollableIndicatorDirection;

#import <UIKit/UIKit.h>

@interface BPScrollableIndicator : UIView

- (instancetype)initWithDirection:(BPScrollableIndicatorDirection)direction;

@end
