//
//  ViewController.h
//  Calcahol
//
//  Created by Jon Jungemann on 9/29/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@protocol ViewControllerDelegate <NSObject>

@optional

- (void)viewController:(ViewController *)controller didPressCalculate:(NSInteger)numberOfBeers;

@end

@interface ViewController : UIViewController

@property (weak, nonatomic) id<ViewControllerDelegate> delegate;

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *beersBaby;

- (void)buttonPressed:(UIButton *)sender;
@end

