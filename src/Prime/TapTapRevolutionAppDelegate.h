//
//  TapTapRevolutionAppDelegate.h
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface TapTapRevolutionAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
