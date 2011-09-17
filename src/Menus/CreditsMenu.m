//
//  CreditsMenu.m
//  TapTapRevolution
//
//  Created by KiT on 9/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreditsMenu.h"
#import "XSimpleSkinManager.h"
#import "cocos2d.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface CreditsMenu (Private)

- (void) backButtonPressed;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@implementation CreditsMenu

+ (id) scene
{
    CCScene* scene = [CCScene node];
	XLayer* layer = [CreditsMenu node];
	[scene addChild:layer];
	return scene;
}

//==============================================================================
- (id) init
{
	if((self = [super init]))
	{
		self.isTouchEnabled = YES;
	}
	
	return self;
}
//==============================================================================
- (void) loadResources
{
	XSimpleSkinManager* skinManager = [XSimpleSkinManager sharedSimpleSkinManager];
	NSString* resource = [skinManager pathToCurrentSkin:@"UI/CreditsMenuUI_0"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[resource stringByAppendingPathExtension:@"plist"]
															 textureFile:[resource stringByAppendingPathExtension:@"png"]];
}

//==============================================================================
- (void) configureChilds
{
	// bg
	CCSprite* bg = [CCSprite spriteWithSpriteFrameName:@"CreditsMenuBg.png"];
	[self addChild:bg z:0];
	bg.anchorPoint = ccp(0.0f,0.0f);
	
	// text
	webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 480, 250)];
	webView.opaque = NO;
	webView.backgroundColor = [UIColor clearColor];
	
	NSString *imagePath = [[NSBundle mainBundle] resourcePath];
	imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
	imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	
	NSString *HTMLData = @"<html style=\"background-color: transparent \" align = center> <img src=\"KiKSoftLogo.gif\"/> <H2>KiKSoft</h2><h3>Developers: </h3> Malaar <br/> Yuriy Bosov<br/> KiT<br/> <h3>Design:</h3> Grigory Petrus' <h3>Music:</h3>Anonimous</html>";
	
	imagePath = [imagePath stringByAppendingString:@"Credits.html"];
	
	//[webView loadHTMLString:HTMLData baseURL:[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//",imagePath]]];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Credits" ofType:@"html"]isDirectory:NO]]];
	[[[CCDirector sharedDirector] openGLView] addSubview:webView];  
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
	CCMenu* menu = [CCMenu menuWithItems: btBack, nil];
	[self addChild:menu];
}

//==============================================================================
- (void) backButtonPressed
{
	[webView removeFromSuperview];
	[webView release];
    [[CCDirector sharedDirector] popScene];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
