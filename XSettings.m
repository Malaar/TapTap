//
//  XSettings.m
//  TapTapRevolution
//
//  Created by Malaar on 21.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XSettings.h"

#define SFX_ON					@"sfxOn"
#define SOUND_ON				@"soundOn"
#define CURRENT_SKIN_NAME		@"currentSkinName"

static XSettings* instance = nil;

@implementation XSettings

@synthesize sfxOn;
@synthesize soundOn;
@synthesize currentSkinName;

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
		
		[self load];
	}
	
	return self;
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
	currentSkinName = [userDefaults stringForKey:CURRENT_SKIN_NAME];
	// ...
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
	
	// ...
	
	[userDefaults synchronize];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
