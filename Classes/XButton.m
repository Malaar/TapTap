//
//  Button.m
//  ZombieMenu
//
//  Created by yo on 25.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XButton.h"
#import "CocosExtensions.h"


@implementation XButton

@synthesize enable;
@synthesize selected;

//==============================================================================
+ (id) buttonWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame
{
	return [[[XButton alloc] initWithNormalFrame:aNormalFrame selectedFrame:aSelectedFrame] autorelease];
}

//==============================================================================
+ (id) buttonWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame disabledFrame:(CCSpriteFrame*)aDisabledFrame
{
	return [[[XButton alloc] initWithNormalFrame:aNormalFrame selectedFrame:aSelectedFrame disabledFrame:aDisabledFrame] autorelease];
}

//==============================================================================
- (id) initWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame
{
	return [self initWithNormalFrame:aNormalFrame selectedFrame:aSelectedFrame disabledFrame:nil];
}

//==============================================================================
- (id) initWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame disabledFrame:(CCSpriteFrame*)aDisabledFrame
{
	if( (self = [super init]) )
	{
		if(aNormalFrame)
		{
			normalSprite = [CCSprite spriteWithSpriteFrame:aNormalFrame];
			NSAssert(normalSprite, @"normalSprite is nil !!!");
			[self addChild:normalSprite];
			normalSprite.anchorPoint = ccp(0,0);
			normalSprite.visible = YES;
		}

		if(aSelectedFrame)
		{
			selectedSprite = [CCSprite spriteWithSpriteFrame:aSelectedFrame];
			NSAssert(selectedSprite, @"normalSprite is nil !!!");
			[self addChild:selectedSprite];
			selectedSprite.anchorPoint = ccp(0,0);
			selectedSprite.visible = NO;
		}
		
		if(aDisabledFrame)
		{
			disabledSprite = [CCSprite spriteWithSpriteFrame:aDisabledFrame];
			NSAssert(disabledSprite, @"normalSprite is nil !!!");
			[self addChild:disabledSprite];
			disabledSprite.anchorPoint = ccp(0,0);
			disabledSprite.visible = NO;
		}
		
		[self setContentSize:normalSprite.contentSize];
		
		enable = YES;
		selected = NO;
	}
	
	return self;
}

//==============================================================================
- (void) setDelegate:(id<ButtonDelegate>) aDelegate
{
	if(delegate != aDelegate)
	{
		[delegate release];
		delegate = [aDelegate retain];
	}
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
- (void) touchBegin:(CGPoint) aGlobalPos
{
	if( enable && !selected && [self hitTest:aGlobalPos])
	{
		[self select];
		[delegate buttonPressed:self];
	}
}

//==============================================================================
- (void) touchMove:(CGPoint) aGlobalPos
{
	if( selected && ![self hitTest:aGlobalPos])
	{
		[self deselect];
		[delegate buttonReleased:self];
	}
}

//==============================================================================
- (void) touchEnd:(CGPoint) aGlobalPos
{
	if(selected)
	{
		[self deselect];
		[delegate buttonReleased:self];
	}
}

//==============================================================================
- (void) select
{
	normalSprite.visible = NO;
	selectedSprite.visible = YES;
	disabledSprite.visible = NO;
	selected = YES;
}

//==============================================================================
- (void) deselect
{
	normalSprite.visible = YES;
	selectedSprite.visible = NO;
	disabledSprite.visible = NO;
	selected = NO;
}

@end


//==============================================================================
//==============================================================================
//==============================================================================
