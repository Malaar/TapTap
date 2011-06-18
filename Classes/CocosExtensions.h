//
//  CocosExtensions.h
//  TapTapRevolution
//
//  Created by Malaar on 18.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"



@interface CCNode (Extension)

- (BOOL) hitTest:(CGPoint) aGlobalPos;

@end
