//
//  CreditsMenu.m
//  TapTapRevolution
//
//  Created by KiT on 9/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreditsMenu.h"
#import "XSimpleSkinManager.h"
//#import ".h"
#import "cocos2d.h"


	


enum
{
	kTagTileMap = 1,
};

@interface CreditsMenu (Private)

- (void) backButtonPressed;

@end

//===========================================
//===========================================
//===========================================

@implementation CreditsMenu

+ (id) scene
{
    CCScene* scene = [CCScene node];
	XLayer* layer = [CreditsMenu node];
	[scene addChild:layer];
	return scene;
}


- (id) init
{
	if((self = [super init]))
	{
		self.isTouchEnabled = YES;
	}
	
	return self;
}
//===========================================
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

	// rich text
	//CGRect cgRect = [[UIScreen mainScreen] applicationFrame];
	//CGSize cgSize =  cgRect.size;
	//webView = [[UIWebView alloc] initWithFrame:CGRectMake(cgRect.origin.x, cgRect.origin.y, cgRect.size.width, cgRect.size.height)];
	webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	webView.opaque = NO;
	webView.backgroundColor = [UIColor clearColor];
	
	NSString *imagePath = [[NSBundle mainBundle] resourcePath];
	imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
	imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	
	NSString *HTMLData = @"<html style=\"background-color: transparent \" align = center> <img src=\"KiKSoftLogo.gif\"/> <H2>KiKSoft</h2><h3>Developers: </h3> Malaar <br/> Yuriy Bosov<br/> KiT<br/> <h3>Design:</h3> Grigory Petrus' <h3>Music:</h3>Anonimous</html>";
	
	[webView loadHTMLString:HTMLData baseURL:[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//",imagePath]]]; //[NSString stringWithFormat:@"%@%@%@", ];
	//webView.scalesPageToFit = YES;
	webView.transform = CGAffineTransformMakeRotation(M_PI*(90.0/180.0));
	webView.frame = CGRectMake(70, 0, 250, 480);

	[[[[CCDirector sharedDirector] openGLView] window]addSubview:webView];
	//webView.bounds = CGRectMake(0, 0, cgSize.width, 200);
	
} 

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
//
////====
//
//-(void) registerWithTouchDispatcher
//{
//	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
//}
//
//-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent*)event
//{
//	return YES;
//}
//
//-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent*)event
//{
//	
//}
//
//-(void) ccTouchCancelled:(UITouch*)touch withEvent:(UIEvent*)event
//{
//}
//
//-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent*)event
//{
//	CGPoint touchLocation = [touch locationInView: [touch view]];
//	CGPoint prevLocation = [touch previousLocationInView: [touch view]];
//	
//	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
//	prevLocation = [[CCDirector sharedDirector] convertToGL: prevLocation];
//	prevLocation.x = touchLocation.x;
//	
//	CGPoint diff = ccpSub(touchLocation,prevLocation);
//	
//	CCNode* node = [self getChildByTag:kTagTileMap];
//	CGPoint currentPos = [node position];
//	[node setPosition: ccpAdd(currentPos, diff)];
//}
@end
