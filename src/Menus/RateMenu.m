//
//  RateScreen.m
//  TapTapRevolution
//
//  Created by Yuriy Bosov on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RateMenu.h"
#import "XSimpleSkinManager.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface RateMenu (Private)

- (void) backButtonPressed;
- (void) rateButtonPressed;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation RateMenu

+ (id) scene
{
    CCScene* scene = [CCScene node];
	XLayer* layer = [RateMenu node];
	[scene addChild:layer];
	return scene;
}

//==============================================================================
- (void) loadResources
{
	XSimpleSkinManager* skinManager = [XSimpleSkinManager sharedSimpleSkinManager];
	NSString* resource = [skinManager pathToCurrentSkin:@"UI/RateMenuUI_0"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[resource stringByAppendingPathExtension:@"plist"]
															 textureFile:[resource stringByAppendingPathExtension:@"png"]];
}

//==============================================================================
- (void) configureChilds
{
	// bg
	CCSprite* bg = [CCSprite spriteWithSpriteFrameName:@"RateMenuBg.png"];
	[self addChild:bg z:0];
	bg.anchorPoint = ccp(0.0f,0.0f);
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
	btBack.position = ccp(0, 50);
	lbCaption = [CCLabelBMFont labelWithString:@"Back" fntFile:@"assets/Fonts/button_font.fnt"];
	[btBack setCaption:lbCaption];
    
	// btOptions
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* btRate = [XMenuButton itemFromNormalSprite:normalSprite
												selectedSprite:selectedSprite
												  	    target:self
													  selector:@selector(rateButtonPressed)];
	btRate.position = ccp(0, -50);
	lbCaption = [CCLabelBMFont labelWithString:@"Rate" fntFile:@"assets/Fonts/button_font.fnt"];
	[btRate setCaption:lbCaption];
    
    // menu
	CCMenu* menu = [CCMenu menuWithItems:btBack, btRate, nil];
	[self addChild:menu];

}

//==============================================================================
- (void) backButtonPressed
{
    [[CCDirector sharedDirector] popScene];
}

//==============================================================================
- (void) rateButtonPressed
{
}

//==============================================================================
//==============================================================================
//==============================================================================
@end