//
//  BPRTTabBar.h
//  ChildVCPureLayoutTryer
//
//  Created by Chen YU on 26/6/15.
//  Copyright (c) 2015 Chen YU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BPTabBarDelegate;

@interface BPRTTabBar : UIView

@property (nonatomic, weak) id <BPTabBarDelegate> delegate;

- (instancetype)initWithTabNames:(NSArray *)tabNames;
- (instancetype)initWithViewControllers:(NSArray *)viewControllers;

- (void)insertTabWithName:(NSString *)tabName atIndex:(NSInteger)index;
- (void)insertViewController:(UIViewController *)viewController atIndex:(NSInteger)index;

@end

@protocol BPTabBarDelegate  <NSObject>

- (void)tabBar:(BPRTTabBar *)tabBar didSelectTabAtIndex:(NSInteger)index;

@end