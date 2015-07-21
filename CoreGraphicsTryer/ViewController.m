//
//  ViewController.m
//  CoreGraphicsTryer
//
//  Created by Chen YU on 15/7/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "ViewController.h"

#import "BPRTRectTable.h"
#import "BPRTRoundTable.h"
#import "BPRTSearchBar.h"
#import "BPRTTableControlPanel.h"
#import "BPRTTabBar.h"

#import "CommonHelpers.h"

@interface ViewController ()

@property (nonatomic, strong) BPRTRectTable *rectTable;
@property (nonatomic, strong) BPRTRoundTable *roundTable;

@property (nonatomic, assign) BOOL showSearchBar;
@property (nonatomic, strong) UIView *searchBarContainer;
@property (nonatomic, strong) BPRTSearchBar *searchBar;
@property (nonatomic, strong) BPRTSearchBar *searchBar2;
@property (nonatomic, strong) BPRTTableControlPanel *controlPanel;

@property (nonatomic, assign) BOOL shouldTabBar;
@property (nonatomic, strong) BPRTTabBar *tabBar;
@property (nonatomic, strong) UIButton *addTabButton;

@property (nonatomic, assign) CGFloat scaleFactor;

@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, assign) CGPoint prevPoint;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:241.0 / 255.0 green:243.0 / 255.0 blue:246.0 / 255.0 alpha:1.0];
    
    self.rectTable = [[BPRTRectTable alloc] initWithNumberOfSeats:1 tableSided:TableSidedOne];
    self.rectTable.frame = CGRectMake(200.f, 200.f, 66.f, 86.f);
    [self.view addSubview:self.rectTable];
    
    self.controlPanel = [[BPRTTableControlPanel alloc] initWithFrame:CGRectMake(400.f, 400.f, 200.f, 200.f)];
    [self.view addSubview:self.controlPanel];
    
//    self.roundTable = [[BPRTRoundTable alloc] initWithFrame:CGRectMake(200.f, 400.f, 130.f + 16.f, 130.f + 16.f)];
//    [self.view addSubview:self.roundTable];
    self.roundTable = [[BPRTRoundTable alloc] initWithFrame:CGRectMake(0, 0, 130.f + 16.f, 130.f + 16.f)];
    self.roundTable.center = CGPointMake(200.f, 200.f);
    [self.controlPanel addSubview:self.roundTable];
//    self.controlPanel
    
    self.showSearchBar = NO;
    if (self.showSearchBar) {
        self.searchBarContainer = [UIView new];
        self.searchBarContainer.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.searchBarContainer];
        
        self.searchBar = [BPRTSearchBar new];
        self.searchBar.barTintColor = [UIColor colorWithRed:241.f / 255.f green:243.f / 255.f blue:246.f / 255.f alpha:1.f];
        [self.searchBarContainer addSubview:self.searchBar];
        
        self.searchBar2 = [BPRTSearchBar new];
        [self.searchBarContainer addSubview:self.searchBar2];
    }
    
    self.shouldTabBar = NO;
    if (self.shouldTabBar) {
        self.addTabButton = [UIButton new];
        self.addTabButton.backgroundColor = [UIColor cyanColor];
        [self.addTabButton setTitle:@"Add new tab" forState:UIControlStateNormal];
        [self.addTabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.addTabButton addTarget:self action:@selector(newTab) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.addTabButton];
        
        self.tabBar = [[BPRTTabBar alloc] initWithTabNames:@[@"Beverage", @"Drinks", @"Starter"]];
        [self.view addSubview:self.tabBar];
    }
    
    self.centerPoint = CGPointMake(500.f, 500.f);
}

- (void)updateViewConstraints
{
//    [self.rectTable autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view withOffset:-200.f + 66.f / 2];
//    [self.rectTable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view withOffset:-(768.f / 2 - 200.f - 86.f / 2)];
//    [self.rectTable autoSetDimensionsToSize:CGSizeMake(66.f, 86.f)];
    
    if (self.showSearchBar) {
        self.searchBarContainer.layoutMargins = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
        [self.searchBarContainer autoCenterInSuperview];
        [self.searchBarContainer autoSetDimensionsToSize:CGSizeMake(340.f, 80.f * 2)];
        
        [self.searchBar autoPinEdgesToSuperviewMarginsExcludingEdge:ALEdgeBottom];
        [self.searchBar autoSetDimensionsToSize:CGSizeMake(320.f, 60.f)];
        
        [self.searchBar2 autoPinEdgesToSuperviewMarginsExcludingEdge:ALEdgeTop];
        [self.searchBar2 autoSetDimensionsToSize:CGSizeMake(320.f, 60.f)];
    }
    
    if (self.shouldTabBar) {
        [self.addTabButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
        [self.addTabButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view withOffset:-100.f];
        [self.addTabButton autoSetDimensionsToSize:CGSizeMake(100.f, 40.f)];
        
        [self.tabBar autoCenterInSuperview];
        [self.tabBar autoSetDimensionsToSize:CGSizeMake(664.f, 40.f)];
        
    }
    
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self isValidTouch]) {
     
        UITouch *touch = [touches anyObject];
        self.prevPoint = [touch locationInView:self.view];
        
        if (self.controlPanel.controlEvent == BPRTTableControlEventMove) {
            
            self.controlPanel.center = self.prevPoint;
            
        } else if (self.controlPanel.controlEvent == BPRTTableControlEventResize) {
            
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self isValidTouch]) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        
        if (self.controlPanel.controlEvent == BPRTTableControlEventMove) {
            
            self.controlPanel.center = point;
            self.scaleFactor = 1.0;
            self.controlPanel.scaleFactor = self.scaleFactor;
            
            self.centerPoint = point;
            
        } else if (self.controlPanel.controlEvent == BPRTTableControlEventResize) {
            [self calScaleFactorFromPoint:self.prevPoint toPoint:point];
            
            //    self.rectTable.transform = CGAffineTransformMakeScale(self.scaleFactor, self.scaleFactor);
            CGRect frame = self.controlPanel.frame;
            if ([CommonHelpers numberIsFraction:[NSNumber numberWithFloat:frame.size.width * self.scaleFactor]] && [CommonHelpers numberIsFraction:[NSNumber numberWithFloat:frame.size.height * self.scaleFactor]]) {
                frame.size.width *= self.scaleFactor;
                frame.size.height *= self.scaleFactor;
                self.controlPanel.frame = frame;
                self.controlPanel.center = self.centerPoint;
                self.controlPanel.scaleFactor = self.scaleFactor;
                
                self.prevPoint = point;
            }
        }
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self isValidTouch]) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
    }
}

- (void)newTab {
    [self.tabBar insertTabWithName:@"Hello world 0" atIndex:0];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tabBar insertTabWithName:@"Hello world 2" atIndex:2];
    });
    
}

#pragma mark - Internal Helper

- (BOOL)isValidTouch {
    if (self.controlPanel.isMovable || self.controlPanel.isReziable) {
        return YES;
    } else {
        return NO;
    }
}

- (CGFloat)distanceToCenter:(CGPoint)point {
    return sqrtf( powf(self.centerPoint.x - point.x, 2) + powf(self.centerPoint.y - point.y, 2) );
}

- (void)calScaleFactorFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    
    CGFloat prevDistance = [self distanceToCenter:fromPoint];
    CGFloat currDistance = [self distanceToCenter:toPoint];
    
    self.scaleFactor = currDistance / prevDistance;
    NSLog(@"scaleFactor: %f", self.scaleFactor);
}


@end
