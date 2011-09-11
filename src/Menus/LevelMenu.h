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
typedef enum LevelSlotState
{
	levelSlotLock,
	levelSlotUnlock,
	levelSlotCompleted
	
} LevelSlotState;

//==============================================================================
//==============================================================================
//==============================================================================
///
@interface LevelSlot : XScrollPanelSlot
{
	CCMenuItemSprite* bgSprite;
	CCLabelBMFont* lblevelNumber;
	CCLabelBMFont* lbScore;
	CCLabelBMFont* lbFastTime;

	LevelSlotState state;
}

@property (nonatomic, readonly) LevelSlotState state;

- (void) setLevelNumber:(int)aLevelNumber;
- (void) setScore:(int)aScore;
- (void) setFastTime:(int)aFastTime;

@end


//==============================================================================
//==============================================================================
//==============================================================================
///
@interface LevelMenu : XLayer <XScrollPanelDelegate>
{

}

+ (id) scene;

@end
