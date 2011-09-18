//
//  PackMenu.m
//  TapTapRevolution
//
//  Created by KiT on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PackMenu.h"
#import "LevelMenu.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface PackMenu (Private)

- (void) backButtonPressed;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation PackMenu

+ (id) scene
{
    CCScene* scene = [CCScene node];
	XLayer* layer = [PackMenu node];
	[scene addChild:layer];
	return scene;
}

//==============================================================================
- (void) loadResources
{
	XSimpleSkinManager* skinManager = [XSimpleSkinManager sharedSimpleSkinManager];
	NSString* resource = [skinManager pathToCurrentSkin:@"UI/PackMenuUI_0"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[resource stringByAppendingPathExtension:@"plist"]
															 textureFile:[resource stringByAppendingPathExtension:@"png"]];
}

//==============================================================================
- (void) configureChilds
{
	// bg
	CCSprite* bg = [CCSprite spriteWithSpriteFrameName:@"PackMenuBg.png"];
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
	btBack.position = ccp(0, -130);
	lbCaption = [CCLabelBMFont labelWithString:@"Back" fntFile:@"assets/Fonts/button_font.fnt"];
	[btBack setCaption:lbCaption];
	
	
	// bt1tap
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* bt1tap = [XMenuButton itemFromNormalSprite:normalSprite
											 selectedSprite:selectedSprite
													 target:self
												   selector:@selector(tap1ButtonPressed)];
	bt1tap.position = ccp(-100, 110);
	lbCaption = [CCLabelBMFont labelWithString:@"1 tap" fntFile:@"assets/Fonts/button_font.fnt"];
	[bt1tap setCaption:lbCaption];
	
	
	// bt2tap
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* bt2tap = [XMenuButton itemFromNormalSprite:normalSprite
											 selectedSprite:selectedSprite
													 target:self
												   selector:@selector(tap2ButtonPressed)];
	bt2tap.position = ccp(100, 110);
	lbCaption = [CCLabelBMFont labelWithString:@"2 tap" fntFile:@"assets/Fonts/button_font.fnt"];
	[bt2tap setCaption:lbCaption];
	
	
	// bt3tap
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* bt3tap = [XMenuButton itemFromNormalSprite:normalSprite
											 selectedSprite:selectedSprite
													 target:self
												   selector:@selector(tap3ButtonPressed)];
	bt3tap.position = ccp(-100, 50);
	lbCaption = [CCLabelBMFont labelWithString:@"3 tap" fntFile:@"assets/Fonts/button_font.fnt"];
	[bt3tap setCaption:lbCaption];
	
	
	// bt4tap
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* bt4tap = [XMenuButton itemFromNormalSprite:normalSprite
											 selectedSprite:selectedSprite
													 target:self
												   selector:@selector(tap4ButtonPressed)];
	bt4tap.position = ccp(100, 50);
	lbCaption = [CCLabelBMFont labelWithString:@"4 tap" fntFile:@"assets/Fonts/button_font.fnt"];
	[bt4tap setCaption:lbCaption];
	
	
	// bt5tap
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* bt5tap = [XMenuButton itemFromNormalSprite:normalSprite
											 selectedSprite:selectedSprite
													 target:self
												   selector:@selector(tap5ButtonPressed)];
	bt5tap.position = ccp(0, -10);
	lbCaption = [CCLabelBMFont labelWithString:@"5 tap" fntFile:@"assets/Fonts/button_font.fnt"];
	[bt5tap setCaption:lbCaption];
	
	
	// menu
	CCMenu* menu = [CCMenu menuWithItems: btBack, bt1tap,bt2tap,bt3tap,bt4tap,bt5tap,nil];
	[self addChild:menu];
}

//==============================================================================
- (void) backButtonPressed
{
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
}

//==============================================================================
- (void) tap1ButtonPressed
{
	CCScene* scene = [CCTransitionFade transitionWithDuration:0.25 scene:[LevelMenu scene] withColor:ccc3(0, 0, 0)];
	[[CCDirector sharedDirector] replaceScene:scene];
}

//==============================================================================
-(void) tap2ButtonPressed
{
	CCScene* scene = [CCTransitionFade transitionWithDuration:0.25 scene:[LevelMenu scene] withColor:ccc3(0, 0, 0)];
	[[CCDirector sharedDirector] replaceScene:scene];
}

//==============================================================================
- (void) tap3ButtonPressed
{
	CCScene* scene = [CCTransitionFade transitionWithDuration:0.25 scene:[LevelMenu scene] withColor:ccc3(0, 0, 0)];
	[[CCDirector sharedDirector] replaceScene:scene];
}

//==============================================================================
- (void) tap4ButtonPressed
{
	CCScene* scene = [CCTransitionFade transitionWithDuration:0.25 scene:[LevelMenu scene] withColor:ccc3(0, 0, 0)];
	[[CCDirector sharedDirector] replaceScene:scene];
}

//==============================================================================
- (void) tap5ButtonPressed
{
	CCScene* scene = [CCTransitionFade transitionWithDuration:0.25 scene:[LevelMenu scene] withColor:ccc3(0, 0, 0)];
	[[CCDirector sharedDirector] replaceScene:scene];
}
//==============================================================================
//==============================================================================
//==============================================================================

@end
