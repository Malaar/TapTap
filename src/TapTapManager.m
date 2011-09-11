//
//  TapTapManager.m
//  TapTapRevolution
//
//  Created by Malaar on 09.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TapTapManager.h"


static TapTapManager* sharedInstance = nil;

@implementation TapTapManager

@synthesize currentPackIndex;
@synthesize currentLevelIndex;

//==============================================================================
+ (TapTapManager*) sharedTapTapManager
{
	if(!sharedInstance)
		sharedInstance = [TapTapManager new];
	
	return sharedInstance;
}

//==============================================================================
- (int) maxHighlightedButtons
{
	return currentPackIndex + 1;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
