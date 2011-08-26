//
//  XSimpleSkinManager.h
//  TapTapRevolution
//
//  Created by Malaar on 14.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


/// simple manager of skins
@interface XSimpleSkinManager : NSObject
{
	NSString* baseSkinPath;
	NSDictionary* skins;

	NSString* currentSkinName;
	NSString* currentSkinPath;
	NSString* currentSkinPathLocal;
}

@property (nonatomic, readonly) NSString* baseSkinPath;

+ (XSimpleSkinManager*) sharedSimpleSkinManager;

- (void) switchToSkin:(NSString*) aSkinName;

- (NSString*) pathToCurrentSkin:(NSString*) aPathToConvert;
- (NSString*) localPathToCurrentSkin:(NSString*) aPathToConvert;

@end
