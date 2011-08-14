//
//  XMenuButton.h
//  TapTapRevolution
//
//  Created by Malaar on 14.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class XMenuButton;

//==============================================================================
//==============================================================================
//==============================================================================
@protocol XMenuButtonDelegate <NSObject>
@optional
- (void) menuButtonPressed:(XMenuButton*) aButton;
- (void) menuButtonReleased:(XMenuButton*) aButton;
@end

//==============================================================================
//==============================================================================
//==============================================================================
///
@interface XMenuButton : CCMenuItemSprite
{
	CCNode* caption;
    id<XMenuButtonDelegate> delegate;
}

- (void) setDelegate:(id<XMenuButtonDelegate>) aDelegate;
- (void) setCaption:(CCNode*) aCaption;

@end
