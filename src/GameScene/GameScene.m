//
//  GameScene.m
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "XHighlightedButton.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface GameScene (Private)
- (void) updateButtonHighlighting:(ccTime)aTime;
- (void) highlightButtons;
- (void) dehighlightButtons;

- (void) prepareToRound;
- (void) processRoundResult;
- (void) roundEnd;
@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation GameScene

//==============================================================================
+ (id) scene
{
	CCScene* scene = [CCScene node];
	GameScene* layer = [GameScene node];
	[scene addChild: layer];
	return scene;
}

//==============================================================================
- (id) init
{
	buttons = [NSMutableArray new];
	if( (self = [super init]) )
	{
		srand(time(0));
		self.isTouchEnabled = YES;
		levels = [NSMutableArray new];
		highlightedButtons = [NSMutableArray new];
		pressedButtons = [NSMutableArray new];
		
		currentLevelIndex = 0;
		correctTapCount = 0;
		
		currentTime = 0.0f;
		
		gameMode = modeRelax;
		pressedCount = 0;
		
		// load levels
		NSString* fileName = [CCFileUtils fullPathFromRelativePath:@"assets/configs/levels.plist"];
		NSArray* arrLevels = [NSArray arrayWithContentsOfFile:fileName];
		NSAssert(arrLevels, @"dictionary of levels is nil !!!");
		for(NSDictionary* dict in arrLevels)
		{
			TapLevel* level = [TapLevel levelFromDictionary:dict];
			[levels addObject:level];
		}
		currentLevel = [levels objectAtIndex:currentLevelIndex];
		[self prepareToRound];
		
		[self schedule:@selector(updateButtonHighlighting:) interval:0.016];
	}
	return self;
}

//==============================================================================
- (void) dealloc
{
	[buttons release];
	[levels release];
	[highlightedButtons release];
	[pressedButtons release];
	
	[super dealloc];
}

//==============================================================================
- (void) loadResources
{
	// empty by default
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"assets/graphics/buttons.plist" textureFile:@"assets/graphics/buttons.png"];
}

//==============================================================================
- (void) configureChilds
{

	CCNode* buttonsContainer = [CCNode node];
	
	// buttons
	XHighlightedButton* bt;
	
	CCSpriteFrame* normalFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"button_normal.png"];
	CCSpriteFrame* selectedFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"button_selected.png"];
	CCSpriteFrame* highlightedFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"button_highlighted.png"];
	
	for(int i = 0; i < 3; ++i)
	for(int j = 0; j < 5; ++j)
	{
		bt = [XHighlightedButton buttonWithNormalFrame:normalFrame selectedFrame:selectedFrame highlightedFrame:highlightedFrame];
		[bt setDelegate:self];
		
		bt.position = ccp(j * 90, i * 90);
		[buttons addObject:bt];
		[buttonsContainer addChild:bt];
		[touchReseivers addObject:bt];
	}
	
	[self addChild:buttonsContainer];
	buttonsContainer.position = ccp(35, 35);
}

//==============================================================================
- (void) configureMenu
{
}

//==============================================================================
- (void) buttonPressed:(XHighlightedButton*) aButton
{
	[pressedButtons addObject:aButton];
	++pressedCount;
}

//==============================================================================
- (void) buttonReleased:(XButton*) aButton
{
	--pressedCount;
	
	if(pressedCount == 0)
	{
		CCLOG(@"RELEASE ALL PRESSED BUTTONS.");
		gameMode = modeNone;
		[self roundEnd];
	}
}

//==============================================================================
- (void) updateButtonHighlighting:(ccTime)aTime
{
	if(gameMode == modeNone)
		return;
	
	currentTime += aTime;
	
	if(gameMode == modeRelax)
	{
		if(currentTime >= relaxTime)
		{
			currentTime = 0.0f;
			[self highlightButtons];
			gameMode = modeHighlighting;
		}
	}
	else if(gameMode == modeHighlighting)
	{
		if(currentTime >= currentLevel.highlightingTime)
		{
			[self roundEnd];
		}
	}
}

//==============================================================================
- (void) highlightButtons
{
	CCLOG(@"NEED HIGHLIGHTED BUTTTONS: %i", [highlightedButtons count]);
	for(XHighlightedButton* bt in highlightedButtons)
	{
		[bt highlight];
	}
}

//==============================================================================
- (void) dehighlightButtons
{
	// de-highlight prev buttons
	for(XHighlightedButton* bt in highlightedButtons)
	{
		[bt deselect];
	}
	[highlightedButtons removeAllObjects];
}

//==============================================================================
- (void) prepareToRound
{
	relaxTime = [currentLevel getRelaxTime];
	
	CCLOG(@"Relax time: %0.2f", relaxTime);

	// prepare buttons to highlight
	int count = rand() % (currentLevel.maxHighlightedButton);
	++count;
	
	int index;
	XHighlightedButton* bt;
	while([highlightedButtons count] < count)
	{
		do
		{
			index = rand() % [buttons count];
			bt = [buttons objectAtIndex:index];
		} while( [highlightedButtons containsObject:bt] );
		[highlightedButtons addObject:bt];
	}
	
	gameMode = modeRelax;

}

//==============================================================================
- (void) processRoundResult
{
	// ...
	BOOL isTapCorrect = YES;

	if([pressedButtons count] != 0 && [pressedButtons count] == [highlightedButtons count])
	{
		for(id button in pressedButtons)
		{
			if( ![highlightedButtons containsObject:button] )
			{
				isTapCorrect = NO;
				break;
			}
		}
	}
	else
	{
		isTapCorrect = NO;
	}

	
	if(isTapCorrect)
	{
		++correctTapCount;
		CCLOG(@"INCREASE TAP-CORRECT.");
	}
	else
	{
		correctTapCount = 0;
		CCLOG(@"WRONG TAP.");
	}

	if(correctTapCount == currentLevel.countToNextLevel)
	{
		// switch to next level
		CCLOG(@"SWITCH TO NEXT LEVEL.");
		++currentLevelIndex;
		if(currentLevelIndex < [levels count])
		{
			currentLevel = [levels objectAtIndex:currentLevelIndex];
			correctTapCount = 0;
		}
	}
	
}

//==============================================================================
- (void) roundEnd
{
	CCLOG(@"ROUND END.");
	currentTime = 0.0f;
	[self processRoundResult];
	[self dehighlightButtons];
	[pressedButtons removeAllObjects];

	[self prepareToRound];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
