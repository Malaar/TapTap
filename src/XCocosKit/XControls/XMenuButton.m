//
//  XMenuButton.m
//  TapTapRevolution
//
//  Created by Malaar on 14.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMenuButton.h"


@implementation XMenuButton

//==============================================================================
- (void) setCaption:(CCNode*) aCaption
{
	caption = aCaption;
	[self addChild: caption];
	caption.position = ccpCompMult(ccpFromSize(self.contentSize), caption.anchorPoint);
}

//==============================================================================
- (void) setDelegate:(id<XMenuButtonDelegate>) aDelegate
{
	if(delegate != aDelegate)
	{
		[delegate release];
		delegate = [aDelegate retain];
	}
}

//==============================================================================
-(void) selected
{
	[super selected];
	
	caption.position = ccp(caption.position.x, caption.position.y - 1);
}

//==============================================================================
-(void) unselected
{
	[super unselected];

	caption.position = ccp(caption.position.x, caption.position.y + 1);
}

@end
