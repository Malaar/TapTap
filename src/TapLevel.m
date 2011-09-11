//
//  Level.m
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TapLevel.h"


@implementation TapLevel

@synthesize highlightingTime;
@synthesize countToNextLevel;

//==============================================================================
+ (id) levelFromDictionary:(NSDictionary*)aDictionary
{
	return [[[TapLevel alloc] initFromDictionary:aDictionary] autorelease];
}

//==============================================================================
- (id) initFromDictionary:(NSDictionary*)aDictionary
{
	if( (self = [super init]) )
	{
		NSNumber* value;
		value = [aDictionary objectForKey:@"highlightingTime"];
		highlightingTime = [value floatValue];
		value = [aDictionary objectForKey:@"countToNextLevel"];
		countToNextLevel = [value intValue];
		NSString* strRange = [aDictionary objectForKey:@"relaxTime"];
		relaxTime = NSRangeFromString(strRange);
	}
	
	return self;
}

//==============================================================================
- (float) getRelaxTime
{
	int result = rand() % ((relaxTime.location + relaxTime.length) - relaxTime.location) + relaxTime.location;
	return result / 1000.0f;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
