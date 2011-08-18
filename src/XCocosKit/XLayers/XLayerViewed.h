//
//  XLayerViewed.h
//  TapTapRevolution
//
//  Created by Malaar on 18.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLayer.h"

/**
 * You should switch into this layer without any cocos2d transitions.
 * Any your views must be added as subview in 'primeView'.
 * primeView show/hide automatical during onEnter/onExit.
 */

/// Layer with views (UIViews)
@interface XLayerViewed : XLayer
{
	UIView* primeView;
}

@end
