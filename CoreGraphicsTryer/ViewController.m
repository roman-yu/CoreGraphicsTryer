//
//  ViewController.m
//  CoreGraphicsTryer
//
//  Created by Chen YU on 15/7/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "ViewController.h"

#import "BPRTRectTable.h"

@interface ViewController ()

@property (nonatomic, strong) BPRTRectTable *rectTable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:241.0 / 255.0 green:243.0 / 255.0 blue:246.0 / 255.0 alpha:1.0];
    
    self.rectTable = [[BPRTRectTable alloc] initWithNumberOfSeats:1 tableSided:TableSidedOne];
    [self.view addSubview:self.rectTable];
}

- (void)updateViewConstraints {
    
    [self.rectTable autoCenterInSuperview];
    [self.rectTable autoSetDimensionsToSize:CGSizeMake(66.f, 86.f)];
    
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
