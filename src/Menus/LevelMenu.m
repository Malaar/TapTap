//
//  SelectLevelMenu.m
//  TapTapRevolution
//
//  Created by Malaar on 18.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelMenu.h"
#import "MainMenu.h"
#import "CocoaExtentions.h"
#import "XSimpleSkinManager.h"
#import "TapTapManager.h"

#import "XScrollPanel.h"

//==============================================================================
//==============================================================================
//==============================================================================
@implementation LevelSlot

@synthesize state;

#pragma mark - init/dealloc
//==============================================================================
- (id) init
{
	if( (self = [super init]) )
	{
		state = levelSlotUnlock;
	}
	
	return self;
}

//==============================================================================
- (void) configureChilds
{
	bgSprite = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"LevelSlotBG.png"]
									   selectedSprite:nil
									   disabledSprite:[CCSprite spriteWithSpriteFrameName:@"LevelSlotBGLocked.png"]
											   target:nil
											 selector:nil];
	CCMenu* menu = [CCMenu menuWithItems:bgSprite, nil];
	[self addChild:menu];
	
	lblevelNumber = [CCLabelBMFont labelWithString:@"" fntFile:@"assets/Fonts/button_font.fnt"];
	lbScore = [CCLabelBMFont labelWithString:@"" fntFile:@"assets/Fonts/button_font.fnt"];
	lbFastTime = [CCLabelBMFont labelWithString:@"" fntFile:@"assets/Fonts/button_font.fnt"];

	CGPoint center = ccpCompMult(ccpFromSize(bgSprite.contentSize), bgSprite.anchorPoint);
	lbScore.position = ccp(center.x, center.y + 55);
	[bgSprite addChild:lbScore];
	
	lblevelNumber.position = center;
	[bgSprite addChild:lblevelNumber];
	
	lbFastTime.position = ccp(center.x, center.y - 55);
	[bgSprite addChild:lbFastTime];
}

//==============================================================================
- (void) setTarget:(NSObject *)aTarget action:(SEL)aSelector
{
	[bgSprite setTarget:aTarget action:aSelector];
}

#pragma mark - properties
//==============================================================================
- (void) setState:(LevelSlotState)aState
{
	state = aState;
	
	if(state != levelSlotCompleted)
	{
		lbScore.visible = NO;
		//lblevelNumber.visible = NO;
		lbFastTime.visible = NO;
	}
	
	if(state == levelSlotLock)
		[bgSprite setIsEnabled:NO];
}

//==============================================================================
- (void) setLevelNumber:(int)aLevelNumber
{
	[lblevelNumber setText:[NSString stringWithFormat:@"%i", aLevelNumber]];
}

//==============================================================================
- (void) setScore:(int)aScore
{
	[lbScore setText:[NSString stringWithFormat:@"%i", aScore]];
}

//==============================================================================
- (void) setFastTime:(int)aFastTime
{
	[lbFastTime setText:[NSString stringWithFormat:@"%i", aFastTime]];
}

@end


//==============================================================================
//==============================================================================
//==============================================================================
@interface LevelMenu (Private)

- (void) backButtonPressed;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation LevelMenu

//==============================================================================
+ (id) scene
{
	CCScene* scene = [CCScene node];
	XLayer* layer = [LevelMenu node];
	[scene addChild:layer];
	return scene;
}

////==============================================================================
//- (id) init
//{
//	if( (self = [super init]) )
//	{
//		// ...
//	}
//	
//	return self;
//}

#pragma mark - scrollPanel delegate
//==============================================================================
- (void) scrollPanel:(XScrollPanel *)aScrollPanel slotPressed:(XScrollPanelSlot *)aSlot atPageIndex:(int)aPageIndex
{
	[TapTapManager sharedTapTapManager].currentLevelIndex = aPageIndex;
	
	// temporarily
	[[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
}

//==============================================================================
- (void) scrollPanel:(XScrollPanel*)aScrollPanel pageChangedFrom:(int)aPageFrom to:(int)aPageTo
{
	NSLog(@"paging %i -> %i", aPageFrom, aPageTo);
}

#pragma mark - cocos layer
//==============================================================================
- (void) loadResources
{
	XSimpleSkinManager* skinManager = [XSimpleSkinManager sharedSimpleSkinManager];
	NSString* resource = [skinManager pathToCurrentSkin:@"UI/LevelMenuUI_0"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[resource stringByAppendingPathExtension:@"plist"]
															 textureFile:[resource stringByAppendingPathExtension:@"png"]];
	resource = [skinManager pathToCurrentSkin:@"UI/MainMenuUI_0"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[resource stringByAppendingPathExtension:@"plist"]
															 textureFile:[resource stringByAppendingPathExtension:@"png"]];
}

//==============================================================================
- (void) configureChilds
{
	// BG
	CCSprite* bg = [CCSprite spriteWithSpriteFrameName:@"LevelMenuBG.png"];
	[self addChild:bg];
	bg.anchorPoint = ccp(0.0f, 0.0f);
	bg.position = ccp(0.0f, 0.0f);
	
	// scroll panel
	NSMutableArray* slots = [NSMutableArray array];
	for(int i = 0; i < 5; ++i)
	{
		LevelSlot* slot = [[LevelSlot new] autorelease];
		[slot setLevelNumber:i + 1];
		[slot setScore:3];
		[slot setFastTime:16];
		[slots addObject:slot];
		
		if(i == 2)
			slot.state = levelSlotUnlock;
		else if(i > 2)
			slot.state = levelSlotLock;
		else
			slot.state = levelSlotCompleted;

	}
	XScrollPanel* sc = [[XScrollPanel alloc] initWithSlots:slots widthOffset:200];
	sc.delegate = self;
	sc.showPagesIndicator = NO;
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
	
	// btBack
	normalSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonNormal.png"];
	selectedSprite = [CCSprite spriteWithSpriteFrameName:@"ButtonPressed.png"];
	XMenuButton* btBack = [XMenuButton itemFromNormalSprite:normalSprite
											   selectedSprite:selectedSprite
													   target:self
													 selector:@selector(backButtonPressed)];
	btBack.position = ccp(0, -120);
	lbCaption = [CCLabelBMFont labelWithString:@"Back" fntFile:@"assets/Fonts/button_font.fnt"];
	[btBack setCaption:lbCaption];
	
	// menu
	CCMenu* menu = [CCMenu menuWithItems:btBack, nil];
	[self addChild:menu];
}

//==============================================================================
- (void) backButtonPressed
{
	CCScene* scene = [CCTransitionFade transitionWithDuration:0.25 scene:[MainMenu scene] withColor:ccc3(0, 0, 0)];
	[[CCDirector sharedDirector] replaceScene:scene];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
