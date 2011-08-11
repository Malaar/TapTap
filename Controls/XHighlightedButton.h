//
//  XHighlightedButton.h
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XButton.h"


@interface XHighlightedButton : XButton
{
	CCSprite* highlightSprite;
	BOOL highlighted;
}

@property (nonatomic, readonly) BOOL highlighted;

+ (id) buttonWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame highlightedFrame:(CCSpriteFrame*)aHighlightedFrame;

- (id) initWithNormalFrame:(CCSpriteFrame*)aNormalFrame selectedFrame:(CCSpriteFrame*)aSelectedFrame highlightedFrame:(CCSpriteFrame*)aHighlightedFrame;

- (void) highlight;

@end
