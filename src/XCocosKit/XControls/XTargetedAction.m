//
//  untitled.m
//  TapTapRevolution
//
//  Created by Malaar on 13.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XTargetedAction.h"


@implementation XTargetedAction

//==============================================================================
- (void) addTarget:(id)aTarget action:(SEL)aSelector
{
	NSMethodSignature* signature = [aTarget methodSignatureForSelector:aSelector];
	NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
	[invocation setTarget:aTarget];
	[invocation setSelector:aSelector];
	[invocation setArgument:&self atIndex:2];
	[actions addObject:invocation];
}

//==============================================================================
- (void) performActions
{
	for(NSInvocation* invocation in actions)
	{
		[invocation invoke];
	}
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
