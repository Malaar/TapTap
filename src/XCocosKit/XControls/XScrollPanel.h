//
//  XScrollPanel.h
//  TapTapRevolution
//
//  Created by Malaar on 18.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCScrollLayer.h"
#include "XCocosExtensions.h"


//==============================================================================
//==============================================================================
//==============================================================================
@interface XScrollPanelSlot : CCLayer
{
}

- (void) configureChilds;

- (void) setTarget:(NSObject*)aTarget action:(SEL)aSelector;

@end

@class XScrollPanel;

//==============================================================================
//==============================================================================
//==============================================================================
@protocol XScrollPanelDelegate

@optional
- (void) scrollPanel:(XScrollPanel*)aScrollPanel slotPressed:(XScrollPanelSlot*)aSlot atPageIndex:(int)aPageIndex;
- (void) scrollPanel:(XScrollPanel*)aScrollPanel pageChangedFrom:(int)aPageFrom to:(int)aPageTo;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@interface XScrollPanel : CCScrollLayer
{
	NSArray* slots;
	
	NSObject<XScrollPanelDelegate>* delegate;
}

@property (nonatomic, assign) NSObject<XScrollPanelDelegate>* delegate;

- (id) initWithSlots:(NSArray*)aSlots widthOffset:(NSInteger)aWidthOffset;

- (NSInteger) pageCount;
- (NSInteger) currentPage;

@end
