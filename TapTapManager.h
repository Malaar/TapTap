//
//  TapTapManager.h
//  TapTapRevolution
//
//  Created by Malaar on 09.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TapTapManager : NSObject
{
	int currentPackIndex;								///< index of current pack (begins from 0)
	int currentLevelIndex;								///<
}

@property (nonatomic, assign) int currentPackIndex;
@property (nonatomic, assign) int currentLevelIndex;

+ (TapTapManager*) sharedTapTapManager;
- (int) maxHighlightedButtons;							///< get count of max highlighted buttons for current pack
@end
