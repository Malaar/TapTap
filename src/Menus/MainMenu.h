//
//  MainMenu.h
//  TapTapRevolution
//
//  Created by Malaar on 13.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "XLayer.h"
#import "XMenuButton.h"


@interface MainMenu : XLayer <XMenuButtonDelegate>
{

}

+ (id) scene;

@end
