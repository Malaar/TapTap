//
//  XSimpleSkinManager.m
//  TapTapRevolution
//
//  Created by Malaar on 14.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XSimpleSkinManager.h"
#import "XDefines.h"
#import "CCFileUtils.h"


XSimpleSkinManager* instance = nil;

//==============================================================================
//==============================================================================
//==============================================================================
@interface XSimpleSkinManager (Private)

- (BOOL) loadConfig;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation XSimpleSkinManager

@synthesize baseSkinPath;

#pragma mark - init/dealloc
//==============================================================================
+ (XSimpleSkinManager*) sharedSimpleSkinManager
{
	if(!instance)
		instance = [XSimpleSkinManager new];
	
	return instance;
}

//==============================================================================
- (id) init
{
	if( (self = [super init]) )
	{
		baseSkinPath = nil;
		skins = nil;
		currentSkinName = nil;
		currentSkinPath = nil;
		currentSkinPathLocal = nil;
		
		// load skins config
		if( ![self loadConfig] )
		{
			[self release];
			self = nil;
		}
	}
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[skins release];
	[baseSkinPath release];
	[currentSkinName release];
	[currentSkinPath release];
	[currentSkinPathLocal release];
	
	[super dealloc];
}

//==============================================================================
- (BOOL) loadConfig
{
	BOOL result = NO;
	NSString* path = @"skins";
//	path = [[NSBundle mainBundle] pathForResource:@"skins" ofType:@"plist" inDirectory:@"assets/Configs/"];
	path = [[NSBundle mainBundle] pathForResource:@"assets/Configs/skins" ofType:@"plist"];
	NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
	if(dictionary)
	{
		baseSkinPath = [(NSString*)[dictionary objectForKey:@"baseSkinPath"] retain];
		skins = [dictionary objectForKey:@"skins"];
		[skins retain];
		// ...
		result = YES;
	}
	
	return result;
}

//==============================================================================
- (void) switchToSkin:(NSString*) aSkinName
{
	if(currentSkinName != aSkinName)
	{
		[currentSkinName release];
		currentSkinName = [aSkinName copy];
		NSString* path = [skins objectForKey:currentSkinName];
		XInClassAssert(path, @"Wrong skin name !!!");
		path = [baseSkinPath stringByAppendingPathComponent:path];
		[currentSkinPathLocal release];
		currentSkinPathLocal = [path retain];
		path = [[NSBundle mainBundle] pathForResource:path ofType:nil];
		[currentSkinPath release];
		currentSkinPath = [path retain];
	}
}

//==============================================================================
- (NSString*) pathToCurrentSkin:(NSString*) aPathToConvert
{
	XInClassAssert(currentSkinPath, @"Try to convert path with nil skin path !!!");

	return [currentSkinPath stringByAppendingPathComponent:aPathToConvert];
}

//==============================================================================
- (NSString*) localPathToCurrentSkin:(NSString*) aPathToConvert
{
	XInClassAssert(currentSkinPathLocal, @"Try to convert path with nil local skin path !!!");
	
	return [currentSkinPathLocal stringByAppendingPathComponent:aPathToConvert];
}

//==============================================================================
//==============================================================================
//==============================================================================

@end
