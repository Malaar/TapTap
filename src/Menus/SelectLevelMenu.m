//
//  SelectLevelMenu.m
//  TapTapRevolution
//
//  Created by Malaar on 18.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectLevelMenu.h"
#import "MainMenu.h"


@implementation SelectLevelMenu

//==============================================================================
+ (id) scene
{
	CCScene* scene = [CCScene node];
	XLayer* layer = [SelectLevelMenu node];
	[scene addChild:layer];
	return scene;
}

//==============================================================================
- (id) init
{
	if( (self = [super init]) )
	{
		//
		CGRect frame = CGRectMake(0, 0, 480, 320);
		XScrollPanel* scrollPanel = [[XScrollPanel alloc] initWithFrame:frame];
		scrollPanel.delegate = self;
		[primeView addSubview:scrollPanel.scrollView];
		scrollPanel.scrollView.pagingEnabled = YES;
//		[scrollPanel release];
		[scrollPanel setSlotsPerPageRows:2 cols:3];
		
		NSMutableArray* slots = [NSMutableArray array];
		for(int i = 0; i < 50; ++i)
		{
			XScrollPanelSlot* slot = [[XScrollPanelSlot new] autorelease];
			[slots addObject:slot];
		}
		[scrollPanel setSlots:slots];
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

//==============================================================================
//==============================================================================
//==============================================================================
@end
