//
//  CoolTableViewController.m
//  CoreGraphicsTryer
//
//  Created by Chen YU on 15/7/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "CoolTableViewController.h"

#import "BPRTPolygonView.h"

@interface CoolTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (copy) NSMutableArray *thingsToLearn;
@property (copy) NSMutableArray *thingsLearned;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) BPRTPolygonView *polygon;

@end

@implementation CoolTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Core Graphics 101";
    self.thingsToLearn = [@[@"Drawing Rects", @"Drawing Gradients", @"Drawing Arcs"] mutableCopy];
    self.thingsLearned = [@[@"Table Views", @"UIKit", @"Objective-C"] mutableCopy];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.polygon];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    
//    [self.tableView autoPinEdgesToSuperviewMargins];
    
    [self.polygon autoCenterInSuperview];
    [self.polygon autoSetDimensionsToSize:CGSizeMake(200.f, 200.f)];
    
    [super updateViewConstraints];
}

#pragma mark - Getter

- (BPRTPolygonView *)polygon {
    if (!_polygon) {
        _polygon = [[BPRTPolygonView alloc] init];
        _polygon.backgroundColor = [UIColor clearColor];
    }
    return _polygon;
}

#pragma mark - Private

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.thingsToLearn.count;
    } else {
        return self.thingsLearned.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString * entry;
    
    if (indexPath.section == 0) {
        entry = self.thingsToLearn[indexPath.row];
    } else {
        entry = self.thingsLearned[indexPath.row];
    }
    cell.textLabel.text = entry;
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Things We'll Learn";
    } else {
        return @"Things Already Covered";
    }
}

#pragma mark - 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.f;
}

@end
