//
//  XLayer.h
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "XTouchReceiver.h"

/// Base Layer
@interface XLayer : CCLayer
{
	@protected
	NSMutableArray* touchReseivers;
}

- (void) loadResources;
- (void) configureChilds;
- (void) configureMenu;

@end
