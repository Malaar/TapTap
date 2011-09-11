//
//  PackInfo.h
//  TapTapRevolution
//
//  Created by Malaar on 10.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelResults.h"


@interface PackInfo : NSObject
{
	int packIndex;
	int lastPlayedLevel;
	NSMutableArray* levelsResults;
}

@property (nonatomic, readonly) int packIndex;

+ (id) packInfoWithIndex:(int)aPackIndex;
- (id) initWithIndex:(int)aPackIndex;

- (void) increaseLastPlayedLevelWithResults:(LevelResults*)aLevelResults;
- (int) lastPlayedLevel;

- (void) setLevelResults:(LevelResults*)aLevelResults atIndex:(int)aLevelIndex;
- (LevelResults*) levelResultsByIndex:(int)aLevelIndex;

//- (NSDictionary*) toDictionary;
//- (void) fromDictionary:(NSDictionary*)aDictionary;

@end
