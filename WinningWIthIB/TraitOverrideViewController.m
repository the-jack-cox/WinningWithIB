/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
 A view controller container that forces its child to have different traits.
 
 */

#import "TraitOverrideViewController.h"

@interface TraitOverrideViewController ()
@property (copy, nonatomic) UITraitCollection *forcedTraitCollection;
@end

@implementation TraitOverrideViewController


- (void)determineForcedTraitCollection:(CGSize)size
{
    if (MAX(size.height, size.width) > 667) { //it's an iphone 6+ or iPad retina
        NSLog(@"larger device");
        if (size.width > size.height) { // landscape
            NSLog(@"landscape");
            self.forcedTraitCollection = [UITraitCollection
                                          traitCollectionWithTraitsFromCollections:@[
                                                                                     [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular],
                                                                                     [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassRegular]
                                                                                     ]];
        } else {
            NSLog(@"portrait");
            self.forcedTraitCollection = [UITraitCollection
                                          traitCollectionWithTraitsFromCollections:@[
                                                                                     [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact],
                                                                                     [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassRegular]
                                                                                     ]];
        }
    } else { // it's an iPhone 6 or smaller (iphone 6 or iPad non-retina)
        NSLog(@"Smaller device");
        if (size.width > size.height) { //landscape
            NSLog(@"landscape");
            self.forcedTraitCollection = [UITraitCollection
                                          traitCollectionWithTraitsFromCollections:@[
                                                                                     [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular],
                                                                                     [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact]
                                                                                     ]];
           
        } else {
            NSLog(@"portrait");
            // Otherwise, don't override any traits
            self.forcedTraitCollection = [UITraitCollection
                                          traitCollectionWithTraitsFromCollections:@[
                                                                                     [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact],
                                                                                     [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact]
                                                                                     ]];
            self.forcedTraitCollection = [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact];
        }
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [self determineForcedTraitCollection:size];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)updateForcedTraitCollection
{
    // Use our forcedTraitCollection to override our child's traits
    [self setOverrideTraitCollection:self.forcedTraitCollection forChildViewController:self.viewController];
}



- (void)setViewController:(UIViewController *)viewController
{
    if (_viewController != viewController) {
        if (_viewController) {
            [_viewController willMoveToParentViewController:nil];
            [self setOverrideTraitCollection:nil forChildViewController:_viewController];
            [_viewController.view removeFromSuperview];
            [_viewController removeFromParentViewController];
        }
        
        if (viewController) {
            [self addChildViewController:viewController];
        }
        _viewController = viewController;
        
        if (_viewController) {
            UIView *view = _viewController.view;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:view];
            NSDictionary *views = NSDictionaryOfVariableBindings(view);
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views:views]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];
            [_viewController didMoveToParentViewController:self];
            
            [self determineForcedTraitCollection:view.bounds.size];
            
            [self updateForcedTraitCollection];
        }
    }
}

- (void)setForcedTraitCollection:(UITraitCollection *)forcedTraitCollection
{
    if (_forcedTraitCollection != forcedTraitCollection) {
        _forcedTraitCollection = [forcedTraitCollection copy];
        [self updateForcedTraitCollection];
    }
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return YES;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods
{
    return YES;
}

@end
