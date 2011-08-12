//
//  XLayer.m
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XLayer.h"
#import "XTouchReceiver.h"


@implementation XLayer

//==============================================================================
- (id) init
{
	if( (self = [super init]) )
	{
		touchReseivers = [NSMutableArray new];

		[self loadResources];
		[self configureChilds];
		[self configureMenu];
	}
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[touchReseivers release];
	
	[super dealloc];
}

//==============================================================================
- (void) onExit
{
	[super onExit];
	
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
}

//==============================================================================
- (void) loadResources
{
	// empty by default
}

//==============================================================================
- (void) configureChilds
{
	// empty by default
}

//==============================================================================
- (void) configureMenu
{
	// empty by default
}

//==============================================================================
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	for(UITouch* touch in touches)
	{
		CGPoint globalPos = [touch locationInView: touch.view];
		globalPos = [[CCDirector sharedDirector] convertToGL:globalPos];
		for(id<XTouchReceiver> tr in touchReseivers)
		{
			[tr touchBegin:globalPos];
		}
	}
}

//==============================================================================
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	for(UITouch* touch in touches)
	{
		CGPoint globalPos = [touch locationInView: touch.view];
		globalPos = [[CCDirector sharedDirector] convertToGL:globalPos];
		for(id<XTouchReceiver> tr in touchReseivers)
		{
			[tr touchMove:globalPos];
		}
	}
}

//==============================================================================
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for(UITouch* touch in touches)
	{
		CGPoint globalPos = [touch locationInView: touch.view];
		globalPos = [[CCDirector sharedDirector] convertToGL:globalPos];
		for(id<XTouchReceiver> tr in touchReseivers)
		{
			[tr touchEnd:globalPos];
		}
	}
}

//==============================================================================
- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self ccTouchesEnded:touches withEvent:event];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
