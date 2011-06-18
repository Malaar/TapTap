//
//  Button.h
//  ZombieMenu
//
//  Created by yo on 25.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TouchReceiver.h"

@class XButton;

//==============================================================================
//==============================================================================
//==============================================================================
@protocol ButtonDelegate <NSObject>
@optional
- (void) buttonPressed:(XButton*) aButton;
- (void) buttonReleased:(XButton*) aButton;
@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface XButton : CCNode <TouchReceiver>
{
    id<ButtonDelegate> delegate;
	BOOL enable;
	BOOL selected;
	
	CCSprite* normalSprite;
	CCSprite* selectedSprite;
	CCSprite* disabledSprite;
}

@property (nonatomic, assign) BOOL enable;
@property (nonatomic, readonly) BOOL selected;

+ (id) buttonWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame;
+ (id) buttonWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame disabledFrame:(CCSpriteFrame*)aDisabledFrame;

- (id) initWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame;
- (id) initWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame disabledFrame:(CCSpriteFrame*)aDisabledFrame;
- (void) setDelegate:(id<ButtonDelegate>) aDelegate;

- (void) select;
- (void) deselect;

@end

//==============================================================================
//==============================================================================
//==============================================================================
