//
//  Level.h
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TapLevel : NSObject
{
	int maxHighlightedButton;		///< 
	float highlightingTime;			///< in seconds
	NSRange relaxTime;				///< in ms
	int countToNextLevel;			///< количество правильных тапов, необходимое для перехода на следующий уровень

}

@property (nonatomic, readonly) int maxHighlightedButton;
@property (nonatomic, readonly) float highlightingTime;
@property (nonatomic, readonly) int countToNextLevel;

+ (id) levelFromDictionary:(NSDictionary*)aDictionary;

- (id) initFromDictionary:(NSDictionary*)aDictionary;
- (float) getRelaxTime;

@end
