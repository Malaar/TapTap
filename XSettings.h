//
//  XSettings.h
//  TapTapRevolution
//
//  Created by Malaar on 21.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


/// Settings - class to save and load game settings
@interface XSettings : NSObject
{
	//sounds
	BOOL sfxOn;									///< is sfx on
	BOOL soundOn;								///< is sounds on
	
	// skins
	NSString* currentSkinName;					///< name of the current skin (see skin manager)
}

@property (nonatomic, assign) BOOL sfxOn;
@property (nonatomic, assign) BOOL soundOn;
@property (nonatomic, retain) NSString* currentSkinName;

+ (XSettings*) sharedSettings;

- (void) load;
- (void) save;

@end
