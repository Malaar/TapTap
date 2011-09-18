//
//  HelpMenu.m
//  TapTapRevolution
//
//  Created by KiT on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelpMenu.h"

//==============================================================================
//==============================================================================
//==============================================================================

@implementation HelpSlot

- (id)initWithDataFrame:(NSString*)frameName
{
	if( (self = [super init]) )
	{
		bgSprite = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:frameName]
										   selectedSprite:nil];
		
		CCMenu* menu = [CCMenu menuWithItems:bgSprite, nil];
		[self addChild:menu];
	}
	
	return self;

}

@end
//==============================================================================
//==============================================================================
//==============================================================================
@interface HelpMenu (Private)

- (void) backButtonPressed;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation HelpMenu


+ (id) scene
{
    CCScene* scene = [CCScene node];
	XLayer* layer = [HelpMenu node];
	[scene addChild:layer];
	return scene;
}

//==============================================================================
- (void) loadResources
{
	XSimpleSkinManager* skinManager = [XSimpleSkinManager sharedSimpleSkinManager];
	NSString* resource = [skinManager pathToCurrentSkin:@"UI/HelpMenuUI_0"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[resource stringByAppendingPathExtension:@"plist"]
															 textureFile:[resource stringByAppendingPathExtension:@"png"]];
	resource = [skinManager pathToCurrentSkin:@"UI/MainMenuUI_0"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[resource stringByAppendingPathExtension:@"plist"]
															 textureFile:[resource stringByAppendingPathExtension:@"png"]];
	
}

//==============================================================================
- (void) configureChilds
{
	// bg
	CCSprite* bg = [CCSprite spriteWithSpriteFrameName:@"HelpMenuBG.png"];
	[self addChild:bg z:0];
	bg.anchorPoint = ccp(0.0f,0.0f); 
	
	bg.anchorPoint = ccp(0.0f, 0.0f);
	bg.position = ccp(0.0f, 0.0f);
	
	// scroll panel
	NSMutableArray* slots = [NSMutableArray array];
	for(int i = 0; i < 5; ++i)
	{
		HelpSlot* slot = [[[HelpSlot alloc ]initWithDataFrame:@"HelpSlotBG.png"] autorelease];
		[slots addObject:slot];
	}
	XScrollPanel* sc = [[XScrollPanel alloc] initWithSlots:slots widthOffset:200];
	sc.delegate = self;
	sc.showPagesIndicator = YES;
	sc.minimumTouchLengthToSlide = 1;
	sc.minimumTouchLengthToChangePage = 20;
	[self addChild:sc];
	
}

//==============================================================================
- (void) configureMenu
{
    CCSprite* normalSprite;
	CCSprite* selectedSprite;
	CCLabelBMFont* lbCaption;
    
	// back
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* btBack = [XMenuButton itemFromNormalSprite:normalSprite
											 selectedSprite:selectedSprite
													 target:self
												   selector:@selector(backButtonPressed)];
	btBack.position = ccp(0, -130);
	lbCaption = [CCLabelBMFont labelWithString:@"Back" fntFile:@"assets/Fonts/button_font.fnt"];
	[btBack setCaption:lbCaption];
	
	
	// menu
	CCMenu* menu = [CCMenu menuWithItems: btBack,nil];
	[self addChild:menu];
}

//==============================================================================
- (void) backButtonPressed
{
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
}

//==============================================================================
//==============================================================================
//==============================================================================

@end
