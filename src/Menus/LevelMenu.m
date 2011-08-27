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

#import "CCScrollLayer.h"

//==============================================================================
//==============================================================================
//==============================================================================
@implementation LevelSlot

@synthesize lock;

#pragma mark - init/dealloc
//==============================================================================
- (id) init
{
	if( (self = [super init]) )
	{
		baseView.frame = CGRectMake(0.0f, 0.0f, 200.0f, 150.0f);
		
		lock = NO;
		lockView = nil;
		
		// level number view
		CGRect frame = baseView.bounds;
		lbLevelNumber = [[UILabel alloc] initWithFrame:frame];
		[baseView addSubview:lbLevelNumber];
		[lbLevelNumber release];
		lbLevelNumber.backgroundColor = [UIColor clearColor];
		lbLevelNumber.font = [UIFont fontWithName:@"Helvetica" size:64];
		lbLevelNumber.textColor = [UIColor colorWithRedI:200 greenI:200 blueI:200 alphaI:255];
		lbLevelNumber.textAlignment = UITextAlignmentCenter;
		
		// score
		frame = CGRectMake(0, 0, baseView.bounds.size.width, 40);
		lbScore = [[UILabel alloc] initWithFrame:frame];
		[baseView addSubview:lbScore];
		[lbScore release];
		lbScore.backgroundColor = [UIColor clearColor];
		lbScore.font = [UIFont fontWithName:@"Helvetica" size:34];
		lbScore.textColor = [UIColor colorWithRedI:200 greenI:200 blueI:200 alphaI:255];
		lbScore.textAlignment = UITextAlignmentCenter;

		// fast time
		frame = CGRectMake(0, baseView.bounds.size.height - 40, baseView.bounds.size.width, 40);
		lbFastTime = [[UILabel alloc] initWithFrame:frame];
		[baseView addSubview:lbFastTime];
		[lbFastTime release];
		lbFastTime.backgroundColor = [UIColor clearColor];
		lbFastTime.font = [UIFont fontWithName:@"Helvetica" size:34];
		lbFastTime.textColor = [UIColor colorWithRedI:200 greenI:200 blueI:200 alphaI:255];
		lbFastTime.textAlignment = UITextAlignmentCenter;
	}
	
	return self;
}

#pragma mark - properties
//==============================================================================
- (void) setLock:(BOOL)aLock
{
	lock = aLock;
	
	if(lock)
	{
		UIImage* lockImage = [UIImage imageNamed:@""];
		lockView = [[UIImageView alloc] initWithImage:lockImage];
		[baseView addSubview:lockView];
		[lockView release];
		lockView.bounds = baseView.bounds;
	}
}

//==============================================================================
- (void) setLevelNumber:(int)aLevelNumber
{
	lbLevelNumber.text = [NSString stringWithFormat:@"%i", aLevelNumber];
}

//==============================================================================
- (void) setScore:(int)aScore
{
	lbScore.text = [NSString stringWithFormat:@"%i", aScore];
}

//==============================================================================
- (void) setFastTime:(int)aFastTime
{
	lbFastTime.text = [NSString stringWithFormat:@"%i", aFastTime];
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

//==============================================================================
- (id) init
{
	if( (self = [super init]) )
	{
		/*
		CGSize screenSize = [UIScreen mainScreen].bounds.size;
		
		//
		CGRect frame = CGRectMake(0, 0, screenSize.height, 290);
		XScrollPanel* scrollPanel = [[XScrollPanel alloc] initWithFrame:frame];
		scrollPanel.delegate = self;
		[primeView addSubview:scrollPanel.scrollView];
		scrollPanel.scrollView.pagingEnabled = YES;
//		[scrollPanel release];
		[scrollPanel setSlotsPerPageRows:1 cols:2];
		
		// slot bg
		XSimpleSkinManager* skinManager = [XSimpleSkinManager sharedSimpleSkinManager];
		NSString* resource = [skinManager localPathToCurrentSkin:@"UI/LevelSlotBG.png"];
		NSLog(@"resource: %@", resource);
		UIImage* slotBGImage = [UIImage imageNamed:resource];

		NSMutableArray* slots = [NSMutableArray array];
		for(int i = 0; i < 20; ++i)
		{
			LevelSlot* slot = [[LevelSlot new] autorelease];
			[slots addObject:slot];
			[slot setLevelNumber:i + 1];
			[slot setScore:1000];
			[slot setFastTime:20];
			[slot.baseView setBackgroundImage:slotBGImage forState:UIControlStateNormal];
			
		}
		[scrollPanel setSlots:slots];

		frame = primeView.frame;
		frame.size.height -= 60;
		primeView.frame = frame;
		//*/
		
		/*
		// back button
		UIButton* btBack = [UIButton buttonWithType:UIButtonTypeCustom];
		[primeView addSubview:btBack];
		UIImage* imgNormal = [UIImage imageNamed:[skinManager localPathToCurrentSkin:@"UI/ButtonNormal.png"]];
		UIImage* imgSelected = [UIImage imageNamed:[skinManager localPathToCurrentSkin:@"UI/ButtonPressed.png"]];

		[btBack setBackgroundImage:imgNormal forState:UIControlStateNormal];
		//[btBack setBackgroundImage:imgSelected forState:UIControlStateSelected];
		[btBack setBackgroundImage:imgSelected forState:UIControlStateHighlighted];

		frame = btBack.frame;
		frame.size = imgNormal.size;
		frame.origin = CGPointMake(screenSize.height / 2.0f - imgNormal.size.width / 2, screenSize.width - imgNormal.size.height - 10);
		btBack.frame = frame;
		
		[btBack setTitle:@"Back" forState:UIControlStateNormal];
		UIColor* color = [UIColor colorWithRedI:255 greenI:10 blueI:0 alphaI:255];
		[btBack setTitleColor:color forState:UIControlStateNormal];
		btBack.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:28];
		//*/
	}
	
	return self;
}

#pragma mark - scrollPanel delegate
//==============================================================================
- (void) scrollPanel:(XScrollPanel *)aScrollPanel slotPressed:(XScrollPanelSlot *)aSlot
{
	aSlot.baseView.backgroundColor = [UIColor redColor];
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
	CCSprite* bg = [CCSprite spriteWithSpriteFrameName:@"LevelMenuBG.png"];
	[self addChild:bg];
	bg.anchorPoint = ccp(0.0f, 0.0f);
	bg.position = ccp(0.0f, 0.0f);
	
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	
	// page
	CCLayer* pg1 = [CCLayer node];
	CCLabelTTF* lb1 = [CCLabelTTF labelWithString:@"Page 1" fontName:@"Helvetica" fontSize:36];
	[pg1 addChild:lb1];
	lb1.position = ccp(screenSize.width / 2, screenSize.height / 2);
	
	// page
	CCLayer* pg2 = [CCLayer node];
	CCLabelTTF* lb2 = [CCLabelTTF labelWithString:@"Page 2" fontName:@"Helvetica" fontSize:36];
	[pg2 addChild:lb2];
	lb2.position = ccp(screenSize.width / 2, screenSize.height / 2);
	
	// page
	CCLayer* pg3 = [CCLayer node];
	CCLabelTTF* lb3 = [CCLabelTTF labelWithString:@"Page 3" fontName:@"Helvetica" fontSize:36];
	[pg3 addChild:lb3];
	lb3.position = ccp(screenSize.width / 2, screenSize.height / 2);
	
	
	NSArray* layers = [NSArray arrayWithObjects: pg1, pg2, pg3, nil];
	CCScrollLayer* sl = [CCScrollLayer nodeWithLayers:layers widthOffset:200];
	[self addChild: sl];
	sl.showPagesIndicator = YES;
	sl.minimumTouchLengthToSlide = 1;
	sl.minimumTouchLengthToChangePage = 20;
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
