//
//  UIView+Inspectables.m
//  WinningWIthIB
//
//  Created by Jack Cox on 11/8/14.
//  Copyright (c) 2014 CapTech Consulting. All rights reserved.
//

#import "UIView+Inspectables.h"

@implementation UIView (Inspectables)

- (void) setTestingID:(NSString *)testingID {
    self.accessibilityIdentifier = testingID;
}

- (NSString *) testingID {
    return self.accessibilityIdentifier;
}


@end
