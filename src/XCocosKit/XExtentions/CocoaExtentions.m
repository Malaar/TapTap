//
//  CocoaExtentions.m
//  ROM
//
//  Created by Malaar on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CocoaExtentions.h"


//==============================================================================
//==============================================================================
//==============================================================================
@implementation UINavigationBar (Extention)

- (void) drawRect:(CGRect)rect
{
    UIImage* imageBG = [UIImage imageNamed:@"nav_bar_bg.png"];
    [imageBG drawInRect:self.bounds];
    NSLog(@"%@", self);
}

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation UIColor (Extention)

+ (UIColor *)colorWithRedI:(NSInteger)red greenI:(NSInteger)green blueI:(NSInteger)blue alphaI:(NSInteger)alpha
{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation UIView (Extention)

- (UIViewController *) firstAvailableUIViewController
{
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController
{
    id result = nil;
    
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([nextResponder isKindOfClass:[UIView class]])
        result = [nextResponder traverseResponderChainForUIViewController];
    
    return result;
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
