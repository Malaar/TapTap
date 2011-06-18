//
//  XHighlightedButton.m
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XHighlightedButton.h"


@implementation XHighlightedButton

@synthesize highlighted;

//==============================================================================
+ (id) buttonWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame highlightedFrame:(CCSpriteFrame*)aHighlightedFrame
{
	return [[[XHighlightedButton alloc] initWithNormalFrame:aNormalFrame selectedFrame:aSelectedFrame highlightedFrame:aHighlightedFrame] autorelease];
}

//==============================================================================
- (id) initWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame highlightedFrame:(CCSpriteFrame*)aHighlightedFrame
{
	if( (self = [super initWithNormalFrame:aNormalFrame selectedFrame:aSelectedFrame]) )
	{
		if(aHighlightedFrame)
		{
			highlightSprite = [CCSprite spriteWithSpriteFrame:aHighlightedFrame];
			NSAssert(highlightSprite, @"highlightSprite is nil !!!");
			[self addChild:highlightSprite];
			highlightSprite.anchorPoint = ccp(0,0);
			highlightSprite.visible = NO;
		}
		
		highlighted = NO;
	}
	
	return self;
}

//==============================================================================
- (void) setEnable:(BOOL)isEnable
{
	enable = isEnable;
	selected = NO;
	
	if(enable)
	{
		normalSprite.visible = YES;
		selectedSprite.visible = NO;
		disabledSprite.visible = NO;
	}
	else if(disabledSprite)
	{
		normalSprite.visible = NO;
		selectedSprite.visible = NO;
		disabledSprite.visible = YES;
	}
}

//==============================================================================
- (void) select
{
	highlightSprite.visible = NO;
	[super select];
	highlighted = NO;
}

//==============================================================================
- (void) deselect
{
	highlightSprite.visible = NO;
	[super deselect];
	highlighted = NO;
}

//==============================================================================
- (void) highlight
{
	highlightSprite.visible = YES;
	normalSprite.visible = NO;
	selectedSprite.visible = NO;
	disabledSprite.visible = NO;
	selected = NO;
	highlighted = YES;
}

@end
