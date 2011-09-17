//
//  OptionsMenu.h
//  TapTapRevolution
//
//  Created by KiT on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "XLayer.h"
#import "XMenuButton.h"

@interface OptionsMenu :  XLayer <XMenuButtonDelegate>
{
	bool isMusicOn;
	bool isSFXOn;
	
	XMenuButton* btSoundOnOff;
	XMenuButton* btSFXOnOff;

}

+ (id) scene;

@end
