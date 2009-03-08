//
//  uTweetPrefsWindowController.h
//  uTweet
//
//  Created by jrk on 05.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DBPrefsWindowController.h"

@interface uTweetPrefsWindowController : DBPrefsWindowController 
{
	IBOutlet NSView *generalPrefsView;
	IBOutlet NSView *advancedPrefsView;
	
}

@end
