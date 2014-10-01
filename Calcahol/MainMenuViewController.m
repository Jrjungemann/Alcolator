//
//  MainMenuViewController.m
//  Calcahol
//
//  Created by Jon Jungemann on 10/1/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"
#import "WhiskeyViewController.h"

@interface MainMenuViewController ()

@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTap;
@property (weak, nonatomic) UIButton *wineButton;
@property (weak, nonatomic) UIButton *whiskeyButton;

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Wine Navigation Button") forState:UIControlStateNormal];
    
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Whiskey Navigation Button") forState:UIControlStateNormal];
    
    self.title = NSLocalizedString(@"Calcahol Menu", @"main menu");
}

- (void) viewDidLayoutSubviews {
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat viewWidth;
    CGFloat padding;
    CGFloat verticalPadding;
    CGFloat topPadding;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (orientation == 0 || orientation == UIInterfaceOrientationPortrait) {
            
            topPadding = 200;
            viewWidth = 768;
            padding = 40;
            verticalPadding = 40;
            
        } else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
            
            topPadding = 100;
            viewWidth = 1024;
            padding = 40;
            verticalPadding = 40;
            
        }
        
    } else {
        
        if (orientation == 0 || orientation == UIInterfaceOrientationPortrait) {
            
            topPadding = 200;
            viewWidth = 320;
            verticalPadding = 20;
            padding = 20;
            
        } else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
            
            topPadding = 100;
            viewWidth = 568;
            verticalPadding = 0;
            padding = 20;
            
        }
        
        
    }
    
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.whiskeyButton.frame = CGRectMake(padding, topPadding, itemWidth, itemHeight);
    
    CGFloat bottomOfWhiskeyButton = CGRectGetMaxY(self.whiskeyButton.frame);
    self.wineButton.frame = CGRectMake(padding, bottomOfWhiskeyButton + padding + padding, itemWidth, itemHeight);
}

- (void) loadView {
    
    self.view = [[UIView alloc] init];
    
    UIButton *whiskeyButtons = [UIButton buttonWithType:UIButtonTypeSystem];
    whiskeyButtons.titleLabel.font = [UIFont fontWithName:@"Georgia" size:25];
    
    UIButton *wineButtons = [UIButton buttonWithType:UIButtonTypeSystem];
    wineButtons.titleLabel.font = [UIFont fontWithName:@"Georgia" size:25];
    
    UITapGestureRecognizer *tapTap = [[UITapGestureRecognizer alloc] init];
    
    [self.view addSubview:whiskeyButtons];
    [self.view addSubview:wineButtons];
    [self.view addGestureRecognizer:tapTap];
    
    self.whiskeyButton = whiskeyButtons;
    self.wineButton = wineButtons;
    self.hideKeyboardTap = tapTap;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) winePressed:(UIButton *) sender {
    ViewController *wineVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
}

- (void) whiskeyPressed:(UIButton *) sender {
    WhiskeyViewController *whiskeyVC = [[WhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
