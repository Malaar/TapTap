//
//  CocosExtensions.m
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XCocosExtensions.h"


//==============================================================================
//==============================================================================
//==============================================================================
@implementation CCNode (Extension)

//==============================================================================
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


//==============================================================================
//==============================================================================
//==============================================================================
@implementation CCMenuItem (Extension)

//==============================================================================
- (void) setTarget:(id)rec action:(SEL) cb
{
	NSMethodSignature * sig = nil;
	if( rec && cb )
	{
		[invocation release];
		sig = [rec methodSignatureForSelector:cb];
		
		invocation = nil;
		invocation = [NSInvocation invocationWithMethodSignature:sig];
		[invocation setTarget:rec];
		[invocation setSelector:cb];
#if NS_BLOCKS_AVAILABLE
		if ([sig numberOfArguments] == 3) 
#endif
			[invocation setArgument:&self atIndex:2];
		
		[invocation retain];
	}
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation CCLabelBMFont (Extension)

//==============================================================================
/**
 * for details see http://www.cocos2d-iphone.org/forum/topic/17307
 */
- (void) setText:(NSString*) aText
{
	if (aText)
	{
		int newCapacity = [aText length] + 1;
		
		if (textureAtlas_.totalQuads < newCapacity)
		{
			
			CCLOG(@"cocos2d: CCSpriteBatchNode: resizing TextureAtlas capacity from [%u] to [%u].",
				  (unsigned int)textureAtlas_.capacity,
				  (unsigned int)newCapacity);
			
			if( ! [textureAtlas_ resizeCapacity:newCapacity] )
			{
				// serious problems
				CCLOG(@"cocos2d: WARNING: Not enough memory to resize the atlas");
				NSAssert(NO,@"XXX: SpriteSheet#increaseAtlasCapacity SHALL handle this assert");
			}
		}
	}
	
	[self setString:aText];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================
