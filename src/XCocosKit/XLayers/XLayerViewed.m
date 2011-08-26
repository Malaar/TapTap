//
//  XLayerViewed.m
//  TapTapRevolution
//
//  Created by Malaar on 18.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XLayerViewed.h"


@implementation XLayerViewed

#pragma mark - init/dealloc

//==============================================================================
- (id) init
{
	if( (self = [super init]) )
	{
		// create primeView - parent view for any additional views shows in this layer
		CGSize screenSize = [UIScreen mainScreen].bounds.size;
		CGRect frame = CGRectMake(0, 0, screenSize.height, screenSize.width);
		primeView = [[UIView alloc] initWithFrame:frame];
		primeView.backgroundColor = [UIColor clearColor];
		primeView.hidden = YES;
		[[CCDirector sharedDirector].openGLView addSubview:primeView];
		[primeView release];
	}
	
	return self;
}

//==============================================================================
- (void) dealloc
{
	[primeView removeFromSuperview];
	
	[super dealloc];
}

//==============================================================================
- (void) onEnter
{
	[super onEnter];

	primeView.hidden = NO;
}

//==============================================================================
- (void) onExit
{
	[super onExit];
	
	primeView.hidden = YES;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
