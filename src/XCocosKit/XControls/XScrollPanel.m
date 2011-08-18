//
//  XScrollPanel.m
//  TapTapRevolution
//
//  Created by Malaar on 18.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XScrollPanel.h"
#import "XDefines.h"

//==============================================================================
//==============================================================================
//==============================================================================
@implementation XScrollPanelSlot

@synthesize baseView;

//==============================================================================
- (id) init
{
	if( (self = [super init]) )
	{
		// temporarry
		baseView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[baseView retain];
		baseView.frame = CGRectMake(0, 0, 100, 80);
	}
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[baseView release];
	
	[super dealloc];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface XScrollPanel (Private)

- (void) setupSlots;
- (void) slotPressed:(id)aSender;
- (XScrollPanelSlot*) slotBySender:(id)aSender;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation XScrollPanel

@synthesize scrollView;
@synthesize delegate;

//==============================================================================
- (id) initWithFrame:(CGRect)aFrame;
{
	if( (self = [super init]) )
	{
		scrollView = [[UIScrollView alloc] initWithFrame:aFrame];
		scrollView.backgroundColor = [UIColor clearColor];
		scrollView.showsHorizontalScrollIndicator = NO;
		scrollView.showsVerticalScrollIndicator = NO;
	}
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[scrollView release];
	[slots release];
	
	[super dealloc];
}

//==============================================================================
- (void) setSlotsPerPageRows:(int)aRows cols:(int)aCols
{
	slotRows = aRows;
	slotCols = aCols;
}

//==============================================================================
- (void) setSlots:(NSArray*)aSlots
{
	XInClassAssert(!slots, @"Slots already exists !!!");
	if(!slots)
	{
		slots = [aSlots retain];
		[self setupSlots];
	}
}

//==============================================================================
- (void) setupSlots
{
	// only for landscape orientation!
	
	// calculate page count
	int pageCount = (int)ceilf( [slots count] / (float)(slotRows * slotCols) );
	
	int index = 0;
	XScrollPanelSlot* slot;
	CGRect slotFrame;
	CGSize pageSize = scrollView.bounds.size;
	CGPoint slotDelta;
	slotDelta.x = pageSize.width / (slotCols + 1);
	slotDelta.y = pageSize.height / (slotRows + 1);
	
	for(int page = 0; page < pageCount; ++page)
	{
		UIView* pageView = [UIView new];
		pageView.frame = CGRectMake(page * pageSize.width, 0, pageSize.width, pageSize.height);
		pageView.backgroundColor = [UIColor clearColor];
		[scrollView addSubview:pageView];
		[pageView release];

		for(int r = 1; r <= slotRows; ++r)
		for(int c = 1; c <= slotCols; ++c)
		{
			if( index < [slots count] && (slot = [slots objectAtIndex:index++]) )
			{
				// change only origin
				slotFrame = slot.baseView.frame;
				slotFrame.origin.x = c * slotDelta.x - slotFrame.size.width / 2;
				slotFrame.origin.y = r * slotDelta.y - slotFrame.size.width / 2;
				slot.baseView.frame = slotFrame;
				
				[slot.baseView addTarget:self action:@selector(slotPressed:) forControlEvents:UIControlEventTouchUpInside];
				
				[pageView addSubview:slot.baseView];
			}
		}
	}
	
	scrollView.contentSize = CGSizeMake(pageCount * pageSize.width, pageSize.height);
}

//==============================================================================
- (void) slotPressed:(id)aSender
{
	XScrollPanelSlot* slot = [self slotBySender:aSender];
	[delegate scrollPanel:self slotPressed:slot];
}

//==============================================================================
- (XScrollPanelSlot*) slotBySender:(id)aSender
{
	XScrollPanelSlot* result = nil;
	for(XScrollPanelSlot* slot in slots)
	{
		if(slot.baseView == aSender)
		{
			result = slot;
			break;
		}
	}
	
	return result;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
