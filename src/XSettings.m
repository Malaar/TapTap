//
//  XSettings.m
//  TapTapRevolution
//
//  Created by Malaar on 21.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XSettings.h"
#import "PackInfo.h"

#define SFX_ON					@"sfxOn"
#define SOUND_ON				@"soundOn"
#define CURRENT_SKIN_NAME		@"currentSkinName"
#define IS_PACKS_BUY			@"isPacksBuy"
#define PACKS_INFO				@"packsInfo"

static XSettings* instance = nil;


//==============================================================================
//==============================================================================
//==============================================================================
@interface XSettings (Private)

- (void) load;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation XSettings

@synthesize sfxOn;
@synthesize soundOn;
@synthesize currentSkinName;
@synthesize isPacksBuy;

//==============================================================================
+ (XSettings*) sharedSettings
{
	if(!instance)
		instance = [XSettings new];
	return instance;
}

//==============================================================================
- (id) init
{
	if( (self = [super init]) )
	{
		sfxOn = YES;
		soundOn = YES;
		currentSkinName = @"default";
		isPacksBuy = NO;
		
		// packs info
		packsInfo = [[NSArray arrayWithObjects:
					 [PackInfo packInfoWithIndex:0],
					 [PackInfo packInfoWithIndex:1],
					 [PackInfo packInfoWithIndex:2],
					 [PackInfo packInfoWithIndex:3],
					 [PackInfo packInfoWithIndex:4],
					  nil
					 ] retain];
		
		// load
		[self load];
	}
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[packsInfo release];
	[super dealloc];
}

//==============================================================================
- (void) load
{
	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];

	// load first time?
	if( ![userDefaults objectForKey:CURRENT_SKIN_NAME] )
		return;
	
	// sounds
	sfxOn = [userDefaults boolForKey:SFX_ON];
	soundOn = [userDefaults boolForKey:SOUND_ON];
	
	// skins
	currentSkinName = [[userDefaults stringForKey:CURRENT_SKIN_NAME] retain];
	
	// purchase
	isPacksBuy = [userDefaults boolForKey:IS_PACKS_BUY];
	
	// packs info
	[packsInfo release];
	packsInfo = [[userDefaults valueForKey:PACKS_INFO] retain];
}

//==============================================================================
- (void) save
{
	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];

	// sounds
	[userDefaults setBool:sfxOn forKey:SFX_ON];
	[userDefaults setBool:soundOn forKey:SOUND_ON];
	
	// skins
	[userDefaults setObject:currentSkinName forKey:CURRENT_SKIN_NAME];
	
	// purchase
	[userDefaults setBool:isPacksBuy forKey:IS_PACKS_BUY];

	// packs info
	[userDefaults setObject:packsInfo forKey:PACKS_INFO];
	
	[userDefaults synchronize];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
