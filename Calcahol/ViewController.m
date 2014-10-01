//
//  ViewController.m
//  Calcahol
//
//  Created by Jon Jungemann on 9/29/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;
@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UILabel *alcoholPercent;

@end

@implementation ViewController

- (void)viewDidLoad {
    {
        // Calls the superclass's implementation
        [super viewDidLoad];
        
        self.title = NSLocalizedString(@"Wine", @"wine");
        
        // Set our primary view's background color to lightGrayColor
        self.view.backgroundColor = [UIColor whiteColor];
        
        // Tells the text field that `self`, this instance of `BLCViewController` should be treated as the text field's delegate.
        self.beerPercentTextField.delegate = self;
        self.beerPercentTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
        self.beerPercentTextField.textAlignment = NSTextAlignmentCenter;
        self.beersBaby.textAlignment = NSTextAlignmentCenter;
        
        self.alcoholPercent.textAlignment = NSTextAlignmentCenter;
        self.alcoholPercent.text = @"% Alcohol Content Per Beer";
        
        // Tells `self.beerCountSlider` that when its value changes, it should call `[self -sliderValueDidChange:]`.
        // This is equivalent to connecting the IBAction in our previous checkpoint
        [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
        
        // Set the minimum and maximum number of beers
        self.beerCountSlider.minimumValue = 1;
        self.beerCountSlider.maximumValue = 10;
        
        // Tells `self.calculateButton` that when a finger is lifted from the button while still inside its bounds, to call `[self -buttonPressed:]`
        [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        // Set the naming of the beer count label
        [self.beersBaby setText:NSLocalizedString(@"1 Beer", @"starting position")];
        
        // Set the title of the button
        [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
        
        // Tells the tap gesture recognizer to call `[self -tapGestureDidFire:]` when it detects a tap.
        [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
        
        // Gets rid of the maximum number of lines on the label
        self.resultLabel.numberOfLines = 0;

    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillLayoutSubviews {
   
    [super viewWillLayoutSubviews];
  
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat viewWidth;
    CGFloat padding;
    CGFloat verticalPadding;
    CGFloat topPadding;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (orientation == 0 || orientation == UIInterfaceOrientationPortrait) {
            
            topPadding = 80;
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
            
            topPadding = 70;
            viewWidth = 320;
            padding = 20;
            verticalPadding = 20;
            
        } else if (orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft) {
            
            topPadding = 35;
            viewWidth = 568;
            padding = 20;
            verticalPadding = 0;
            
        }
    }
    
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.alcoholPercent.frame = CGRectMake(padding, topPadding, itemWidth, itemHeight);
    
    CGFloat bottomOfPercentLabel = CGRectGetMaxY(self.alcoholPercent.frame);
    self.beerPercentTextField.frame = CGRectMake(padding, bottomOfPercentLabel, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + verticalPadding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.beersBaby.frame = CGRectMake(padding, bottomOfSlider + verticalPadding, itemWidth, itemHeight);
    
    CGFloat bottomOfBeers = CGRectGetMaxY(self.beersBaby.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfBeers + verticalPadding, itemWidth, itemHeight);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + verticalPadding, itemWidth, itemHeight);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {

    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // Allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    [textField setFont:[UIFont fontWithName:@"Georgia" size:18]];
    
    UISlider *slider = [[UISlider alloc] init];
    
    UILabel *percentAlcohol = [[UILabel alloc] init];
    [percentAlcohol setFont:[UIFont fontWithName:@"Georgia" size:18]];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont fontWithName:@"Georgia" size:18]];
    
    UILabel *beerLabel = [[UILabel alloc] init];
    [beerLabel setFont:[UIFont fontWithName:@"Georgia" size:18]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.titleLabel.font = [UIFont fontWithName:@"Georgia" size:18];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // Add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:percentAlcohol];
    [self.view addSubview:beerLabel];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.beersBaby = beerLabel;
    self.calculateButton = button;
    self.alcoholPercent = percentAlcohol;
    self.hideKeyboardTapGestureRecognizer = tap;
    
}

- (void)textFieldDidChange:(UITextField *)sender {
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    int beerCount = self.beerCountSlider.value;
    
    NSString *beerCounter;
    
    if (beerCount == 1) {
        beerCounter = NSLocalizedString(@"Beer", @"singular beer");
    } else {
        beerCounter = NSLocalizedString(@"Beers", @"plural of beer");
    }
    
    NSString *resultBeers = [NSString stringWithFormat:NSLocalizedString(@"%d %@", nil), beerCount, beerCounter];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    self.title = [NSString stringWithFormat:NSLocalizedString(@"%.1f Glasses of Wine", nil), numberOfWineGlassesForEquivalentAlcoholAmount];
    
    self.beersBaby.text = resultBeers;
}

- (void)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    // first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    NSString *beerText;
    NSString *containText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
        containText = NSLocalizedString(@"contains", @"plural of contains");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
        containText = NSLocalizedString(@"contain", @"singular contain");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ %@ as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, containText,  numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
        
   

}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end