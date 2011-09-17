//
//  OptionsMenu.m
//  TapTapRevolution
//
//  Created by KiT on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OptionsMenu.h"
#import "XSimpleSkinManager.h"
#import "XSettings.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface OptionsMenu (Private)

- (void) backButtonPressed;
- (void) soundOnOffButtonPressed;
- (void) SFXOnOffButtonPressed;
- (void) skinsButtonPressed;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation OptionsMenu

+ (id) scene
{
    CCScene* scene = [CCScene node];
	XLayer* layer = [OptionsMenu node];
	[scene addChild:layer];
	return scene;
}

//==============================================================================
- (id) init
{
	if((self = [super init]))
	{
		isMusicOn = YES;
		isSFXOn = YES;
	}
	
	return self;
}

//==============================================================================
- (void) loadResources
{
	XSimpleSkinManager* skinManager = [XSimpleSkinManager sharedSimpleSkinManager];
	NSString* resource = [skinManager pathToCurrentSkin:@"UI/OptionsMenuUI_0"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[resource stringByAppendingPathExtension:@"plist"]
															 textureFile:[resource stringByAppendingPathExtension:@"png"]];
}

//==============================================================================
- (void) configureChilds
{
	// bg
	CCSprite* bg = [CCSprite spriteWithSpriteFrameName:@"OptionsMenuBg.png"];
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
	btBack.position = ccp( 0, -70);
	lbCaption = [CCLabelBMFont labelWithString:@"Back" fntFile:@"assets/Fonts/button_font.fnt"];
	[btBack setCaption:lbCaption];
    
	
	// btSoundOnOff
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	btSoundOnOff = [XMenuButton itemFromNormalSprite:normalSprite
											 selectedSprite:selectedSprite
													 target:self
												   selector:@selector(soundOnOffButtonPressed)];
	btSoundOnOff.position = ccp(0, 110);
	lbCaption = [CCLabelBMFont labelWithString:@"Turn Music Off" fntFile:@"assets/Fonts/button_font.fnt"];
	[btSoundOnOff setCaption:lbCaption];
	
		
	// btSFXOnOff
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	btSFXOnOff = [XMenuButton itemFromNormalSprite:normalSprite
												selectedSprite:selectedSprite
												  	    target:self
													  selector:@selector(SFXOnOffButtonPressed)];
	btSFXOnOff.position = ccp(0, 50);
	lbCaption = [CCLabelBMFont labelWithString:@"Turn SFX off" fntFile:@"assets/Fonts/button_font.fnt"];
	[btSFXOnOff setCaption:lbCaption];
	
	// btSkins
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* btSkins = [XMenuButton itemFromNormalSprite:normalSprite
											 selectedSprite:selectedSprite
											  	     target:self
												   selector:@selector(skinsButtonPressed)];
	btSkins.position = ccp(0, -10);
	lbCaption = [CCLabelBMFont labelWithString:@"Skins" fntFile:@"assets/Fonts/button_font.fnt"];
	[btSkins setCaption:lbCaption];
	
	    
    // menu
	CCMenu* menu = [CCMenu menuWithItems: btBack, btSkins, btSoundOnOff, btSFXOnOff, nil];
	[self addChild:menu];
	
}

//==============================================================================
- (void) backButtonPressed
{
    [[CCDirector sharedDirector] popScene];
}

//==============================================================================
- (void) soundOnOffButtonPressed
{
    XSettings* settings = [XSettings sharedSettings];
	if (settings.soundOn == YES)
	{		
		[btSoundOnOff setCaption:[CCLabelBMFont labelWithString:@"Turn Music on" fntFile:@"assets/Fonts/button_font.fnt"]];
		settings.soundOn = NO;
	}
	
	else 
	{	
		[btSoundOnOff setCaption:[CCLabelBMFont labelWithString:@"Turn Music off" fntFile:@"assets/Fonts/button_font.fnt"]];		
		settings.soundOn = YES;
	}
}

//==============================================================================
- (void) SFXOnOffButtonPressed
{
	XSettings* settings = [XSettings sharedSettings];
	if (settings.sfxOn == YES)
	{		
		[btSFXOnOff setCaption:[CCLabelBMFont labelWithString:@"Turn SFX on" fntFile:@"assets/Fonts/button_font.fnt"]];
		settings.sfxOn = NO;
	}
	
	else 
	{	
		[btSFXOnOff setCaption:[CCLabelBMFont labelWithString:@"Turn SFX off" fntFile:@"assets/Fonts/button_font.fnt"]];		
		settings.sfxOn = YES;
	}

}

//==============================================================================
- (void) skinsButtonPressed
{
    
}



@end
