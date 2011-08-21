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
		baseView.frame = CGRectMake(0, 0, 140, 110);
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
- (CGSize) pageSize;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation XScrollPanel

@synthesize scrollView;
@synthesize delegate;

#pragma mark - init/dealloc
//==============================================================================
- (id) initWithFrame:(CGRect)aFrame;
{
	if( (self = [super init]) )
	{
		scrollView = [[UIScrollView alloc] initWithFrame:aFrame];
		scrollView.delegate = self;
		scrollView.backgroundColor = [UIColor redColor];
		scrollView.showsHorizontalScrollIndicator = NO;
		scrollView.showsVerticalScrollIndicator = NO;
		
		currentPage = 0;
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

#pragma mark - setup slots
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
	int pageCount = [self pageCount];
	
	int index = 0;
	XScrollPanelSlot* slot = [slots objectAtIndex:0];
	CGRect slotFrame = slot.baseView.frame;
	CGSize pageSize = [self pageSize];
	CGPoint slotDelta;
	slotDelta.x = (pageSize.width - slotFrame.size.width * slotCols) / (slotCols+0) + slotFrame.size.width;
	slotDelta.y = (pageSize.height - slotFrame.size.height * slotRows) / (slotRows+0) + slotFrame.size.height;

	for(int page = 0; page < pageCount; ++page)
	{
		UIView* pageView = [UIView new];
		pageView.frame = CGRectMake(page * pageSize.width, 0, pageSize.width, pageSize.height);
		pageView.backgroundColor = [UIColor clearColor];
		[scrollView addSubview:pageView];
		[pageView release];
		
		for(int r = 0; r < slotRows; ++r)
			for(int c = 0; c < slotCols; ++c)
			{
				if( index < [slots count] && (slot = [slots objectAtIndex:index++]) )
				{
					// change only origin
					//slotFrame = slot.baseView.frame;
					slotFrame.origin.x = (c + 0.5f) * slotDelta.x - slotFrame.size.width / 2;
					slotFrame.origin.y = (r + 0.5f) * slotDelta.y - slotFrame.size.height / 2;
					slot.baseView.frame = slotFrame;
					
					[slot.baseView addTarget:self action:@selector(slotPressed:) forControlEvents:UIControlEventTouchUpInside];
					
					[pageView addSubview:slot.baseView];
				}
			}
	}
/*
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
				slotFrame.origin.y = r * slotDelta.y - slotFrame.size.height / 2;
				slot.baseView.frame = slotFrame;
				
				[slot.baseView addTarget:self action:@selector(slotPressed:) forControlEvents:UIControlEventTouchUpInside];
				
				[pageView addSubview:slot.baseView];
			}
		}
	}
//*/
	
	scrollView.contentSize = CGSizeMake(pageCount * pageSize.width, pageSize.height);
}

#pragma mark - delegate
//==============================================================================
- (void) scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
	if( [delegate respondsToSelector:@selector(scrollPanel:pageChangedFrom:to:)] )
	{
		int pageNumber = scrollView.contentOffset.x / [self pageSize].width;
		if(currentPage != pageNumber)
		{
			[delegate scrollPanel:self pageChangedFrom:currentPage to:pageNumber];
			currentPage = pageNumber;
		}
	}
}

//==============================================================================
- (void) slotPressed:(id)aSender
{
	if( [delegate respondsToSelector:@selector(scrollPanel:slotPressed:)] )
	{
		XScrollPanelSlot* slot = [self slotBySender:aSender];
		[delegate scrollPanel:self slotPressed:slot];
	}
}

#pragma mark - private
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
- (CGSize) pageSize
{
	return scrollView.bounds.size;
}

//==============================================================================
- (NSInteger) pageCount
{
	return (int)ceilf( [slots count] / (float)(slotRows * slotCols) );
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
