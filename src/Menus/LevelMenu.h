//
//  SelectLevelMenu.h
//  TapTapRevolution
//
//  Created by Malaar on 18.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLayerViewed.h"
#import "XScrollPanel.h"


//==============================================================================
//==============================================================================
//==============================================================================
///
@interface LevelSlot : XScrollPanelSlot
{
	UIView* lockView;
	UILabel* lbLevelNumber;
	UILabel* lbScore;
	UILabel* lbFastTime;
	
	BOOL lock;										///< is slot locked
}

@property (nonatomic, readonly) BOOL lock;

- (void) setLevelNumber:(int)aLevelNumber;
- (void) setScore:(int)aScore;
- (void) setFastTime:(int)aFastTime;

@end


//==============================================================================
//==============================================================================
//==============================================================================
///
@interface LevelMenu : XLayerViewed <XScrollPanelDelegate>
{

}

+ (id) scene;

@end
