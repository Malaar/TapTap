//
//  PackInfo.m
//  TapTapRevolution
//
//  Created by Malaar on 10.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PackInfo.h"
#import "XDefines.h"


@implementation PackInfo

@synthesize packIndex;

//==============================================================================
+ (id) packInfoWithIndex:(int)aPackIndex
{
	return [[[PackInfo alloc] initWithIndex:aPackIndex] autorelease];
}

//==============================================================================
- (id) init
{
	XInClassAssert(nil, @"You can't use this method !");
	[self release];
	return nil;
}

//==============================================================================
- (id) initWithIndex:(int)aPackIndex
{
	if( (self = [super init]) )
	{
		packIndex = aPackIndex;
		lastPlayedLevel = 0;
		levelsResults = [NSMutableArray new];
	}
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[levelsResults release];
	
	[super dealloc];
}

//==============================================================================
- (void) increaseLastPlayedLevelWithResults:(LevelResults*)aLevelResults
{
	++lastPlayedLevel;
	[levelsResults addObject:aLevelResults];
}

//==============================================================================
- (int) lastPlayedLevel
{
	return lastPlayedLevel;
}

//==============================================================================
- (void) setLevelResults:(LevelResults*)aLevelResults atIndex:(int)aLevelIndex
{
	XInClassAssert(aLevelIndex >= 0 && aLevelIndex < [levelsResults count], @"Wrong index!");
	[levelsResults replaceObjectAtIndex:aLevelIndex withObject:aLevelResults];
}

//==============================================================================
- (LevelResults*) levelResultsByIndex:(int)aLevelIndex
{
	XInClassAssert(aLevelIndex >= 0 && aLevelIndex < [levelsResults count], @"Wrong index!");
	return [levelsResults objectAtIndex:aLevelIndex];
}

////==============================================================================
//- (NSDictionary*) toDictionary
//{
//	NSDictionary* dict = [NSDictionary dictionary];
//	
//	[dict setValue:[NSNumber numberWithInt:packIndex] forKey:@"packIndex"];
//	[dict setValue:[NSNumber numberWithInt:lastPlayedLevel] forKey:@"lastPlayedLevel"];
//	[dict setValue:levelsResults forKey:@"levelsResults"];	// ????
//	
//	return dict;
//}
//
////==============================================================================
//- (void) fromDictionary:(NSDictionary*)aDictionary
//{
//	packIndex = [[aDictionary valueForKey:@"packIndex"] intValue];
//	lastPlayedLevel = [[aDictionary valueForKey:@"lastPlayedLevel"] intValue];
//	[levelsResults release];
//	levelsResults = [[aDictionary valueForKey:@"levelsResults"] retain];
//}

//==============================================================================
//==============================================================================
//==============================================================================
@end
