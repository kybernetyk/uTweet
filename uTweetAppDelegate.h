//
//  uTweetAppDelegate.h
//  uTweet
//
//  Created by jrk on 04.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class uTweetMainWindowController;

@interface uTweetAppDelegate : NSObject 
{
	uTweetMainWindowController *mainWindowController;
}

- (IBAction) showMainWindow: (id) sender;
- (IBAction) openPreferencesWindow:(id)sender;

@property (readwrite, retain) uTweetMainWindowController *mainWindowController;



@end
