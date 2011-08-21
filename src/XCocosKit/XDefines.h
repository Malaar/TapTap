/*
 *  XDefines.h
 *  TapTapRevolution
 *
 *  Created by Malaar on 14.08.11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifdef DEBUG
	#define XInClassAssert(condition, desc)										\
	{																			\
		NSString* strDesc = ([NSString stringWithFormat:@"[%@ - %@] : %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), desc]);	\
		if(!condition)															\
			NSLog(@"%@", strDesc);												\
		NSAssert( condition,  strDesc);											\
	}
#else
	#define XInClassAssert(condition, desc)
#endif
