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
@property (nonatomic, strong) UIButton *editButton;

@property (nonatomic, strong) NSMutableArray *dataModel;

@end

@implementation CoolTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Core Graphics 101";
    self.thingsToLearn = [@[@"Drawing Rects", @"Drawing Gradients", @"Drawing Arcs"] mutableCopy];
    self.thingsLearned = [@[@"Table Views", @"UIKit", @"Objective-C"] mutableCopy];
    
    for (int i = 0; i < 10; i++) {
        [self.dataModel addObject:[NSNumber numberWithInt:i+1]];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
//    [self.view addSubview:self.polygon];
    
    self.editButton = [UIButton new];
    self.editButton.backgroundColor = [UIColor lightGrayColor];
    [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editButton];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    
    [self.editButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.editButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100.f];
    [self.editButton autoSetDimensionsToSize:CGSizeMake(100.f, 40.f)];
    
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.editButton withOffset:10.f];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    
//    [self.polygon autoCenterInSuperview];
//    [self.polygon autoSetDimensionsToSize:CGSizeMake(200.f, 200.f)];
    
    [super updateViewConstraints];
}

#pragma mark - Getter

- (NSMutableArray *)dataModel {
    if (!_dataModel) {
        _dataModel = [NSMutableArray new];
    }
    return _dataModel;
}

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
//    return 2;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        return self.thingsToLearn.count;
//    } else {
//        return self.thingsLearned.count;
//    }
    return self.dataModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString * entry;
    
//    if (indexPath.section == 0) {
//        entry = self.thingsToLearn[indexPath.row];
//    } else {
//        entry = self.thingsLearned[indexPath.row];
//    }
    cell.textLabel.text = [[self.dataModel objectAtIndex:indexPath.row] stringValue];
    
    return cell;
}

//-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return @"Things We'll Learn";
//    } else {
//        return @"Things Already Covered";
//    }
//}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [self moveItemFrom:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.f;
}

#pragma mark - User Interaction

- (void)editButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.tableView setEditing:sender.selected];
}

#pragma makr - Internal Helper

- (void)moveItemFrom:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    id tempItem = [self.dataModel objectAtIndex:fromIndex];
    [self.dataModel removeObjectAtIndex:fromIndex];
    [self.dataModel insertObject:tempItem atIndex:toIndex];
    
}

@end
