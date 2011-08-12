//
//  Button.h
//  ZombieMenu
//
//  Created by yo on 25.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "XTouchReceiver.h"
#import "XTargetedAction.h"

@class XButton;

//==============================================================================
//==============================================================================
//==============================================================================
@protocol XButtonDelegate <NSObject>
@optional
- (void) buttonPressed:(XButton*) aButton;
- (void) buttonReleased:(XButton*) aButton;
@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface XButton : CCNode <XTouchReceiver, XTargetedActionProtocol>
{
    id<XButtonDelegate> delegate;
	BOOL enable;
	BOOL selected;
	
	CCSprite* normalSprite;
	CCSprite* selectedSprite;
	CCSprite* disabledSprite;
	
	XTargetedAction* targetedAction;
}

@property (nonatomic, assign) BOOL enable;
@property (nonatomic, readonly) BOOL selected;

+ (id) buttonWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame;
+ (id) buttonWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame disabledFrame:(CCSpriteFrame*)aDisabledFrame;

- (id) initWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame;
- (id) initWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame disabledFrame:(CCSpriteFrame*)aDisabledFrame;
- (void) setDelegate:(id<XButtonDelegate>) aDelegate;

- (void) select;
- (void) deselect;

@end

//==============================================================================
//==============================================================================
//==============================================================================
