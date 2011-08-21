//
//  XScrollPanel.h
//  TapTapRevolution
//
//  Created by Malaar on 18.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//==============================================================================
//==============================================================================
//==============================================================================
@interface XScrollPanelSlot : NSObject
{
	UIButton* baseView;
}

@property (nonatomic, readonly) UIButton* baseView;

@end

@class XScrollPanel;

//==============================================================================
//==============================================================================
//==============================================================================
@protocol XScrollPanelDelegate

@optional
- (void) scrollPanel:(XScrollPanel*)aScrollPanel slotPressed:(XScrollPanelSlot*)aSlot;
- (void) scrollPanel:(XScrollPanel*)aScrollPanel pageChangedFrom:(int)aPageFrom to:(int)aPageTo;

@end


//==============================================================================
//==============================================================================
//==============================================================================
@interface XScrollPanel : NSObject <UIScrollViewDelegate>
{
	UIScrollView* scrollView;
	int slotRows;										///< count of rows of slots on page
	int slotCols;										///< count of cols of slots on page

	NSArray* slots;
	
	NSObject<XScrollPanelDelegate>* delegate;
	NSInteger currentPage;								///< index of current page
}

@property (nonatomic, assign) NSObject<XScrollPanelDelegate>* delegate;

@property (nonatomic, readonly) UIScrollView* scrollView;

- (id) initWithFrame:(CGRect)aFrame;

- (void) setSlotsPerPageRows:(int)aRows cols:(int)aCols;
- (void) setSlots:(NSArray*)aSlots;

- (NSInteger) pageCount;

@end
