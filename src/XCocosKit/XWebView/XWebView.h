//
//  MyClass.h
//  TapTapRevolution
//
//  Created by Yuriy Bosov on 8/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUToolbar.h"

@interface XWebView : UIView <UIWebViewDelegate>
{
    MUToolbar* bottomToolbar;
    UIWebView* webView;
    UIActivityIndicatorView* activityIndicator;
    
    UIBarButtonItem *toGameBarButton, *backBarButton, *forwardBarButton, *refreshStopBarButton, *flexSpace, *fixedSpace;
    
    NSString* urlString;
    
    BOOL stoppedLoading;
    BOOL firstLoad;
}

- (id)initWithURLString:(NSString*)aUrlString;

- (MUToolbar*) createBottomToolbar;
- (NSArray*) bottomToolbarElements;
- (void) loadUrlByString:(NSString*)aUrlString;

@end
