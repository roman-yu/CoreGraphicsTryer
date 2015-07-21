//
//  BPRTTabBar.m
//  ChildVCPureLayoutTryer
//
//  Created by Chen YU on 26/6/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import "BPRTTabBar.h"

#import "BPScrollableIndicator.h"

CGFloat const tabWidth = 664.f / 3.f;
CGFloat const tabHeight = 40.f;

CGFloat const posIndicViewWidth = 40.f;

CGFloat const cornerRadius = 6.f;

int32_t const activeColor = 0x474747;
int32_t const normalColor = 0xFFFFFF;

@interface BPRTTabBar () <UIScrollViewDelegate> {
    BOOL goingToHideLeftIndic;      //default NO
    BOOL goingToHideRightIndic;     //default NO
    NSInteger activeIndex;
}

@property (nonatomic, assign) NSInteger insertIndex;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) NSMutableArray *constraints;

@property (nonatomic, strong) NSMutableArray *tabs;
@property (nonatomic, strong) UIScrollView *tabsContainer;

@property (nonatomic, strong) BPScrollableIndicator *leftScrollableIndic;
@property (nonatomic, strong) BPScrollableIndicator *rightScrollableIndic;

@end

@implementation BPRTTabBar

- (instancetype)initWithTabNames:(NSArray *)tabNames {
    if (self = [super initForAutoLayout]) {

        activeIndex = 0;
        goingToHideLeftIndic = YES;
        goingToHideRightIndic = YES;
        
        self.insertIndex = -1;
        self.didSetupConstraints = NO;
        
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.tabsContainer];
        self.tabsContainer.contentSize = CGSizeMake(tabWidth * tabNames.count, tabHeight);
        
        [self initTabViews:tabNames];
        
        self.leftScrollableIndic.hidden = YES;

        [self addSubview:self.leftScrollableIndic];
        [self addSubview:self.rightScrollableIndic];
        
        [self bringSubviewToFront:self.leftScrollableIndic];
        [self bringSubviewToFront:self.rightScrollableIndic];
        
    }
    return self;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers {
    
    __block NSMutableArray *tabNames = [NSMutableArray new];
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (((UIViewController *)obj).title) {
            [tabNames addObject:((UIViewController *)obj).title];
        }
    }];
    return [self initWithTabNames:tabNames];
}

- (void)insertTabWithName:(NSString *)tabName atIndex:(NSInteger)index {
    self.insertIndex = index;
    
    UIButton *newTab = [self createTabWithTitle:tabName atIndex:index];
    [self.tabs insertObject:newTab atIndex:index];
    [self updateTabsWithIndex:index];
    
    [self.tabsContainer addSubview:newTab];
    self.tabsContainer.contentSize = CGSizeMake(tabWidth * self.tabs.count, tabHeight);
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)insertViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    UIButton *newTab = [self createTabWithTitle:viewController.title atIndex:index];
    [self.tabs insertObject:newTab atIndex:index];
    [self.tabsContainer addSubview:newTab];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - Layout

- (void)initTabViews:(NSArray *)tabNames {
    
    typeof(self) __weak weakSelf = self;
    
    [tabNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIButton *tab = [self createTabWithTitle:obj atIndex:idx];
        [weakSelf.tabs addObject:tab];
        [weakSelf.tabsContainer addSubview:tab];
    }];
}

- (void)reloadTabs {
    [self.tabs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *tab = obj;
        if (activeIndex == idx) {
            [tab setBackgroundColor:[UIColor colorWithRed:71.f/255.f green:71.f/255.f blue:71.f/255.f alpha:1.0]];
        } else {
            [tab setBackgroundColor:[UIColor whiteColor]];
        }
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.rightScrollableIndic.hidden = (self.tabsContainer.contentSize.width > self.frame.size.width);
}

- (void)updateConstraints {
    
    if (!self.didSetupConstraints) {
        [self.tabsContainer autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        [self.leftScrollableIndic autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
        [self.leftScrollableIndic autoSetDimension:ALDimensionWidth toSize:posIndicViewWidth];
        
        [self.rightScrollableIndic autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
        [self.rightScrollableIndic autoSetDimension:ALDimensionWidth toSize:posIndicViewWidth];

    }
    
    typeof(self) __weak weakSelf = self;
    
    [self.tabs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIButton *tab = obj, *prevTab;
        
        if (!self.didSetupConstraints) {
            if (idx == 0) {
                [weakSelf.constraints addObject:[tab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.tabsContainer]];
            } else {
                prevTab = [weakSelf.tabs objectAtIndex:(idx - 1)];
                [weakSelf.constraints addObject:[tab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:prevTab]];
            }
            [tab autoAlignAxis:ALAxisHorizontal toSameAxisOfView:weakSelf.tabsContainer];
            [tab autoSetDimensionsToSize:CGSizeMake(tabWidth, tabHeight)];
        } else {
            
            if (self.insertIndex == idx) {
                if (idx < weakSelf.constraints.count) { //insert
                    [weakSelf.constraints[idx] autoRemove];
                    
                    if (idx == 0) {
                        [weakSelf.constraints replaceObjectAtIndex:idx withObject:[tab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:weakSelf.tabsContainer]];
                    } else {
                        prevTab = [weakSelf.tabs objectAtIndex:(idx - 1)];
                        [weakSelf.constraints replaceObjectAtIndex:idx withObject:[tab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:prevTab]];
                    }
                    
                    UIButton *nextTab = weakSelf.tabs[idx + 1];
                    if (idx + 1 < weakSelf.constraints.count) {
                        [weakSelf.constraints insertObject:[nextTab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tab] atIndex:idx + 1];
                    } else {
                        [weakSelf.constraints addObject:[nextTab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tab]];
                    }
                } else {    //add
                    
                    if (idx == 0) {
                        [weakSelf.constraints addObject:[tab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:weakSelf.tabsContainer]];
                    } else {
                        prevTab = [weakSelf.tabs objectAtIndex:(idx - 1)];
                        [weakSelf.constraints addObject:[tab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:prevTab]];
                    }
                }
                
                [tab autoAlignAxis:ALAxisHorizontal toSameAxisOfView:weakSelf.tabsContainer];
                [tab autoSetDimensionsToSize:CGSizeMake(tabWidth, tabHeight)];
                
            }
            
        }
        
    }];
    
    if (!self.didSetupConstraints) {
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - Getters

- (NSMutableArray *)constraints {
    if (!_constraints) {
        _constraints = [NSMutableArray new];
    }
    return _constraints;
}

- (UIScrollView *)tabsContainer {
    if (!_tabsContainer) {
        _tabsContainer = [UIScrollView newAutoLayoutView];
        _tabsContainer.delegate = self;
        _tabsContainer.delaysContentTouches = YES;
        [_tabsContainer setShowsHorizontalScrollIndicator:NO];
    }
    return _tabsContainer;
}

- (NSMutableArray *)tabs {
    if (!_tabs) {
        _tabs = [NSMutableArray new];
    }
    return _tabs;
}

- (BPScrollableIndicator *)leftScrollableIndic {
    if (!_leftScrollableIndic) {
        _leftScrollableIndic = [[BPScrollableIndicator alloc] initWithDirection:BPScrollableIndicatorDirectionLeft];
    }
    return _leftScrollableIndic;
}

- (BPScrollableIndicator *)rightScrollableIndic {
    if (!_rightScrollableIndic) {
        _rightScrollableIndic = [[BPScrollableIndicator alloc] initWithDirection:BPScrollableIndicatorDirectionRight];
    }
    return _rightScrollableIndic;
}

#pragma mark - Internal Helper 

- (UIButton *)createTabWithTitle:(NSString *)title atIndex:(NSInteger)idx {
    UIButton *tab = [UIButton newAutoLayoutView];
    tab.tag = idx;
    [tab addTarget:self action:@selector(didSelectTabWithTag:) forControlEvents:UIControlEventTouchUpInside];
    [tab setTitle:title forState:UIControlStateNormal];
    if (activeIndex == idx) {
        [tab setSelected:YES];
        [tab setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0f]];
    } else {
        [tab setSelected:NO];
        [tab setBackgroundColor:[UIColor whiteColor]];
    }
    [tab setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [tab setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    return tab;
}

- (void)updateTabsWithIndex:(NSInteger)index {
    typeof(self) __weak weakSelf = self;
    [self.tabs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIButton *tab = (UIButton *)obj;
        
        if (idx > index) {
            ((UIButton *)weakSelf.tabs[idx]).tag = idx;
        }
        
        if (activeIndex == idx) {
            [tab setSelected:YES];
            [tab setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0f]];
        } else {
            [tab setSelected:NO];
            [tab setBackgroundColor:[UIColor whiteColor]];
        }
        
    }];
}

#pragma mark - Button

- (void)didSelectTabWithTag:(id)sender {
    
    [((UIButton *)[self.tabs objectAtIndex:activeIndex]) setSelected:NO];
    activeIndex = ((UIButton *)sender).tag;
    [((UIButton *)[self.tabs objectAtIndex:activeIndex]) setSelected:YES];
    [self reloadTabs];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectTabAtIndex:)]) {
        [self.delegate tabBar:self didSelectTabAtIndex:((UIButton *)sender).tag];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.tabsContainer.contentOffset.x <= 0 && !self.leftScrollableIndic.hidden) {
        self.leftScrollableIndic.hidden = YES;
    } else if (self.tabsContainer.contentOffset.x > 0 && self.leftScrollableIndic.hidden) {
        self.leftScrollableIndic.hidden = NO;
    }
    
    if (self.tabsContainer.contentOffset.x >= self.tabsContainer.contentSize.width - self.frame.size.width && !self.rightScrollableIndic.hidden) {
        self.rightScrollableIndic.hidden = YES;
    } else if (self.tabsContainer.contentOffset.x < self.tabsContainer.contentSize.width - self.frame.size.width && self.rightScrollableIndic.hidden) {
        self.rightScrollableIndic.hidden = NO;
    }
}

@end
