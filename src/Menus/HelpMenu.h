//
//  HelpMenu.h
//  TapTapRevolution
//
//  Created by KiT on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "XLayer.h"
#import "XMenuButton.h"
#import "XSimpleSkinManager.h"
#import "MainMenu.h"
#import "XScrollPanel.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface HelpSlot : XScrollPanelSlot
{
	CCMenuItemSprite* bgSprite;
}
@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface HelpMenu : XLayer <XMenuButtonDelegate>
{		
}

+ (id) scene;

@end
