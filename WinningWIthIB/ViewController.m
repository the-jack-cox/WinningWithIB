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
