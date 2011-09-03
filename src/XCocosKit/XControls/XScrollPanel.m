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

//==============================================================================
- (id) init
{
	if( (self = [super init]) )
	{
		[self configureChilds];
	}
	
	return self;
}

//==============================================================================
//- (void) dealloc
//{
//	[super dealloc];
//}

#pragma mark - override to configure
//==============================================================================
- (void) configureChilds
{
	// empty by default
}

//==============================================================================
- (void) setTarget:(NSObject*)aTarget action:(SEL)aSelector
{
	// empty by default
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface XScrollPanel (Private)

- (void) slotPressed;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation XScrollPanel

@synthesize delegate;

#pragma mark - init/dealloc
//==============================================================================
- (id) initWithSlots:(NSArray*)aSlots widthOffset:(NSInteger)aWidthOffset
{
	if( (self = [super initWithLayers:aSlots widthOffset:aWidthOffset]) )
	{
		slots = [aSlots retain];
		for(XScrollPanelSlot* slot in aSlots)
		{
			[slot setTarget:self action:@selector(slotPressed)];
		}
	}
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[slots release];
	
	[super dealloc];
}

#pragma mark - delegate
//==============================================================================
- (void) slotPressed
{
	if( delegate && [delegate respondsToSelector:@selector(scrollPanel:slotPressed:atPageIndex:)] )
	{
		XScrollPanelSlot* slot = [slots objectAtIndex:currentScreen_];
		[delegate scrollPanel:self slotPressed:slot atPageIndex:currentScreen_];
	}
}

//==============================================================================
- (NSInteger) pageCount
{
	return totalScreens_;
}

//==============================================================================
- (NSInteger) currentPage
{
	return currentScreen_;
}

//==============================================================================
-(void) moveToPage:(int)aPage
{
	if(currentScreen_ != aPage && delegate && [delegate respondsToSelector:@selector(scrollPanel:pageChangedFrom:to:)] )
	{
		[delegate scrollPanel:self pageChangedFrom:currentScreen_ to:aPage];
	}
	
	[super moveToPage:aPage];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
