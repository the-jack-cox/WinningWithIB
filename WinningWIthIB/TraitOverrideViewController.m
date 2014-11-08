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

- (void)setViewController:(UIViewController *)viewController
{
    if (_viewController != viewController) {
        if (_viewController) { // remove the old child and clear it's overridden traits
            [_viewController willMoveToParentViewController:nil];
            [self setOverrideTraitCollection:nil forChildViewController:_viewController];
            [_viewController.view removeFromSuperview];
            [_viewController removeFromParentViewController];
        }
        
        if (viewController) { // add the new controller as a child
            [self addChildViewController:viewController];
        }
        _viewController = viewController;
        
        if (_viewController) { // place the child into this view and make it fill it up all the way.
            UIView *view = _viewController.view;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:view];
            NSDictionary *views = NSDictionaryOfVariableBindings(view);
            // using Visual Format language for brevity sake. Don't do this in a real app
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views:views]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];
            [_viewController didMoveToParentViewController:self];
            
            // figure out what traits to make the child
            [self determineForcedTraitCollection:view.bounds.size];
            
            [self updateForcedTraitCollection];
        }
    }
}



- (void)determineForcedTraitCollection:(CGSize)size
{
    if (MAX(size.height, size.width) > 667) { //it's an iphone 6+ or iPad retina
        NSLog(@"larger device");
        if (size.width > size.height) { // landscape
            NSLog(@"landscape");
            self.forcedTraitCollection = [self makeRegularRegular];
        } else {
            NSLog(@"portrait");
            self.forcedTraitCollection = [self makeCompactRegular];
        }
    } else { // it's an iPhone 6 or smaller (iphone 6 or iPad non-retina)
        NSLog(@"Smaller device");
        if (size.width > size.height) { //landscape
            NSLog(@"landscape");
            self.forcedTraitCollection = [self makeRegularCompact];
           
        } else {
            NSLog(@"portrait");
            // Otherwise, don't override any traits
            self.forcedTraitCollection = [self makeCompactCompact];
        }
    }
}

- (UITraitCollection *) makeRegularRegular {
    return [UITraitCollection
            traitCollectionWithTraitsFromCollections:@[
               [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular],
               [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassRegular]
                                                       ]];
}

- (UITraitCollection *) makeCompactRegular {
    
    return [UITraitCollection
            traitCollectionWithTraitsFromCollections:@[
               [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact],
               [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassRegular]
                                                       ]];
}
- (UITraitCollection *) makeRegularCompact {
    return [UITraitCollection
            traitCollectionWithTraitsFromCollections:@[
               [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular],
               [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact]
                                                       ]];
}

- (UITraitCollection *) makeCompactCompact {
    return [UITraitCollection
            traitCollectionWithTraitsFromCollections:@[
               [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact],
               [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact]
                                                       ]];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    // do this because the traits may change when the size changes
    [self determineForcedTraitCollection:size];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)updateForcedTraitCollection
{
    // Use our forcedTraitCollection to override our child's traits
    [self setOverrideTraitCollection:self.forcedTraitCollection forChildViewController:self.viewController];
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
