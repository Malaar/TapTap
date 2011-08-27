//
//  MainMenu.m
//  TapTapRevolution
//
//  Created by Malaar on 13.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "GameScene.h"
#import "XSimpleSkinManager.h"
#import "XSettings.h"
#import "RateMenu.h"

#import "LevelMenu.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface MainMenu (Private)

- (void) playButtonPressed;
- (void) helpButtonPressed;
- (void) creditsButtonPressed;
- (void) optionsButtonPressed;
- (void) rateItButtonPressed;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MainMenu

//==============================================================================
+ (id) scene
{
	CCScene* scene = [CCScene node];
	XLayer* layer = [MainMenu node];
	[scene addChild:layer];
	return scene;
}

//==============================================================================
- (id) init
{
	{
		// do it only in FIRST APPEARED scene: switch to current skin
		NSString* currentSkinName = [XSettings sharedSettings].currentSkinName;
		XSimpleSkinManager* skinManager = [XSimpleSkinManager sharedSimpleSkinManager];
		[skinManager switchToSkin:currentSkinName];
	}
	
	if( (self = [super init]) )
	{
		// ...
	}
	
	return self;
}

//==============================================================================
- (void) loadResources
{
	XSimpleSkinManager* skinManager = [XSimpleSkinManager sharedSimpleSkinManager];
	NSString* resource = [skinManager pathToCurrentSkin:@"UI/MainMenuUI_0"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[resource stringByAppendingPathExtension:@"plist"]
															 textureFile:[resource stringByAppendingPathExtension:@"png"]];
}

//==============================================================================
- (void) configureChilds
{
	// bg
	CCSprite* bg = [CCSprite spriteWithSpriteFrameName:@"MainMenuBg.png"];
	[self addChild:bg z:0];
	bg.anchorPoint = ccp(0.0f,0.0f);

	/*
	UIView* view = [[CCDirector sharedDirector] openGLView];
	
	float scrollHeight = 200;
	UIScrollView* scrollView = [[UIScrollView alloc] init];
	scrollView.frame = CGRectMake(0, 0, 480, scrollHeight);
	scrollView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.5f];
//	scrollView.alpha = 0.1f;
	[view addSubview:scrollView];

	int pageCount = 10;
	CGSize size = CGSizeMake(200, 150);
	for(int i = 0; i < pageCount; ++i)
	{
		UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(480 * i, 0, 480, scrollHeight)];
		view1.backgroundColor = [UIColor clearColor];
		[scrollView addSubview:view1];
		
		UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[view1 addSubview:button];
		button.frame = CGRectMake(480/2 - size.width/2, scrollHeight/2 - size.height/2, size.width, size.height);
		NSString* strTitle = [NSString stringWithFormat:@"%i", i];
		[button setTitle:strTitle forState:UIControlStateNormal];
	}
	
	scrollView.contentSize = CGSizeMake(480*pageCount, scrollHeight);
	scrollView.pagingEnabled = YES;
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.canCancelContentTouches = NO;
	scrollView.userInteractionEnabled = YES;
	scrollView.exclusiveTouch = NO;
	//*/
}

//==============================================================================
- (void) configureMenu
{
	CCSprite* normalSprite;
	CCSprite* selectedSprite;
	CCLabelBMFont* lbCaption;

	// btPlay
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* btPlay = [XMenuButton itemFromNormalSprite:normalSprite
											 selectedSprite:selectedSprite
													 target:self
												   selector:@selector(playButtonPressed)];
	btPlay.position = ccp(0, 110);
	lbCaption = [CCLabelBMFont labelWithString:@"Play" fntFile:@"assets/Fonts/button_font.fnt"];
	[btPlay setCaption:lbCaption];

	// btOptions
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* btOptions = [XMenuButton itemFromNormalSprite:normalSprite
												selectedSprite:selectedSprite
												  	    target:self
													  selector:@selector(optionsButtonPressed)];
	btOptions.position = ccp(0, 50);
	lbCaption = [CCLabelBMFont labelWithString:@"Options" fntFile:@"assets/Fonts/button_font.fnt"];
	[btOptions setCaption:lbCaption];

	// btHelp
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* btHelp = [XMenuButton itemFromNormalSprite:normalSprite
											 selectedSprite:selectedSprite
											  	     target:self
												   selector:@selector(helpButtonPressed)];
	btHelp.position = ccp(0, -10);
	lbCaption = [CCLabelBMFont labelWithString:@"Help" fntFile:@"assets/Fonts/button_font.fnt"];
	[btHelp setCaption:lbCaption];

	// btCredits
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* btCredits = [XMenuButton itemFromNormalSprite:normalSprite
												selectedSprite:selectedSprite
												 	    target:self
												 	  selector:@selector(creditsButtonPressed)];
	btCredits.position = ccp(0, -70);
	lbCaption = [CCLabelBMFont labelWithString:@"Credits" fntFile:@"assets/Fonts/button_font.fnt"];
	[btCredits setCaption:lbCaption];
	
	// btRateIt
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* btRateIt = [XMenuButton itemFromNormalSprite:normalSprite
											   selectedSprite:selectedSprite
													   target:self
													 selector:@selector(rateItButtonPressed)];
	btRateIt.position = ccp(0, -130);
	lbCaption = [CCLabelBMFont labelWithString:@"RateIt!" fntFile:@"assets/Fonts/button_font.fnt"];
	[btRateIt setCaption:lbCaption];

	// menu
	CCMenu* menu = [CCMenu menuWithItems:btPlay, btOptions, btHelp, btCredits, btRateIt, nil];
	[self addChild:menu];
}

//==============================================================================
- (void) playButtonPressed
{
	// temporrary
	[[CCDirector sharedDirector] replaceScene:[GameScene scene]];
}

//==============================================================================
- (void) helpButtonPressed
{
	CCScene* scene = [CCTransitionFade transitionWithDuration:0.25 scene:[LevelMenu scene] withColor:ccc3(0, 0, 0)];
	[[CCDirector sharedDirector] replaceScene:scene];
}

//==============================================================================
- (void) creditsButtonPressed
{
}

//==============================================================================
- (void) optionsButtonPressed
{
}

//==============================================================================
- (void) rateItButtonPressed
{
    [[CCDirector sharedDirector] pushScene:[RateMenu scene]];
}

//==============================================================================
- (void) menuButtonPressed:(XMenuButton*) aButton
{
	// play sound for button pressed here !!!
	// as example, here we can play various sounds for various buttons
}

////==============================================================================
//- (void) menuButtonReleased:(XMenuButton*) aButton
//{
//}


//==============================================================================
//==============================================================================
//==============================================================================
@end
