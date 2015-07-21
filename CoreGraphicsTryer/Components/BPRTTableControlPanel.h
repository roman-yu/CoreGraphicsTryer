//
//  BPRTTableControlPanel.h
//  CoreGraphicsTryer
//
//  Created by Roman-yu on 7/18/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BPRTTableControlEventNone = 0,
    BPRTTableControlEventMove,
    BPRTTableControlEventDelete,
    BPRTTableControlEventEdit,
    BPRTTableControlEventResize,
    BPRTTableControlEventRotate
} BPRTTableControlEvent;

@interface BPRTTableControlPanel : UIView

@property (nonatomic, assign) CGFloat scaleFactor;
@property (nonatomic, assign) BOOL isReziable;
@property (nonatomic, assign) BOOL isMovable;

@property (nonatomic, assign) BPRTTableControlEvent controlEvent;

@end
