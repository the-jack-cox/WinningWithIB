//
//  ViewController.m
//  WinningWIthIB
//
//  Created by Jack Cox on 8/2/14.
//  Copyright (c) 2014 CapTech Consulting. All rights reserved.
//

#import "ViewController.h"

#import "WinningWIthIB-Swift.h"


@interface ViewController () {
    UIViewController *childKeypad;
}
@property (weak, nonatomic) IBOutlet UIView *keypadArea;
@property (weak, nonatomic) IBOutlet UIView *tapeArea;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    KeypadViewController *keypad = [[KeypadViewController alloc] init];
    keypad.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.keypadArea addSubview:keypad.view];
    
    [self addChildViewController:keypad];
    
    UIView *keypadView = keypad.view;
    NSDictionary *views = NSDictionaryOfVariableBindings(keypadView);
    // using Visual Format language for brevity sake. Don't do this in a real app
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[keypadView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[keypadView]|" options:0 metrics:nil views:views]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}


@end
