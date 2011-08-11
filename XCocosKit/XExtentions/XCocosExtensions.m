//
//  CocosExtensions.m
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XCocosExtensions.h"


@implementation CCNode (Extension)

- (BOOL) hitTest:(CGPoint) aGlobalPos
{
	// simple hit-test without childs and rotation\scale:
	BOOL result = NO;
	if(self.visible)
	{
		CGPoint pos = [self convertToNodeSpace: aGlobalPos];
		CGRect rect = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
		result = CGRectContainsPoint(rect, pos);
	}
	return result;
}

@end
