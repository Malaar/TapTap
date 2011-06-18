//
//  TouchReceiver.h
//  ZombieMenu
//
//  Created by yo on 27.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TouchReceiver

@optional
- (void) touchBegin:(CGPoint) aGlobalPos;
- (void) touchMove:(CGPoint) aGlobalPos;
- (void) touchEnd:(CGPoint) aGlobalPos;

@end
