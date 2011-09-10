//
//  LevelResults.h
//  TapTapRevolution
//
//  Created by Malaar on 10.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LevelResults : NSObject
{
	int levelNumber;
	int fasteredTapTime;
	int totalScore;
}

@property (nonatomic, assign) int levelNumber;
@property (nonatomic, assign) int fasteredTapTime;
@property (nonatomic, assign) int totalScore;

@end
