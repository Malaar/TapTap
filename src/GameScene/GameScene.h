//
//  GameScene.h
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "XLayer.h"
#import "XButton.h"
#import "TapLevel.h"


typedef enum GameMode
{
	modeNone,
	modeRelax,
	modeHighlighting
	
} GameMode;

@interface GameScene : XLayer <XButtonDelegate>
{
	NSMutableArray* buttons;
	NSMutableArray* levels;

	NSMutableArray* highlightedButtons;
	NSMutableArray* pressedButtons;

	int currentLevelIndex;
	TapLevel* currentLevel;
	int correctTapCount;
	
	float currentTime;
	float relaxTime;
	
	GameMode gameMode;
	
	int pressedCount;
	
	int maxHighlightedButtons;
}

+ (id) scene;

@end
