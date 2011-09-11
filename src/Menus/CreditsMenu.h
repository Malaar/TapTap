//
//  CreditsMenu.h
//  TapTapRevolution
//
//  Created by KiT on 9/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "XLayer.h"
#import "XMenuButton.h"

@interface CreditsMenu : XLayer <XMenuButtonDelegate>
{
	UIWebView* webView;

}

+ (id) scene;

@end
