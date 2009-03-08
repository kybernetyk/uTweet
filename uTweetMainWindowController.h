//
//  uTweetMainWindowController.h
//  uTweet
//
//  Created by jrk on 04.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGTwitterEngine.h"

@class uTweetTimelineViewController;

@interface uTweetMainWindowController : NSWindowController <MGTwitterEngineDelegate> 
{    
	IBOutlet NSView *customView;
	IBOutlet NSTextField *inputField;
	
	uTweetTimelineViewController *timelineViewController;
	MGTwitterEngine *twitterEngine;	
	
	NSString *enteredTweetText;
	
	NSString *userName;
	NSString *userPassword;
	BOOL isWindowFloating;
	
	NSString  *_updateConnectionIdentifier;
	NSUInteger lastReceivedTweetID; //the id of the most recent tweet in our timeline
								// if they stay same between 2 updates nothing has changed
	
	NSTimer *timelineUpdateTimer;
}
@property (retain, readwrite) NSString *enteredTweetText;
@property (retain, readwrite) NSString *userName;
@property (retain, readwrite) NSString *userPassword;
@property (assign, readwrite) BOOL isWindowFloating;
@property (retain, readwrite) NSTextField *inputField;

- (IBAction) sendTweet: (id) sender;
- (IBAction) requestTimelineUpdate: (id) sender;

- (void) processTimelineUpdate: (NSArray *) timelineData;
- (void) setAppropriateWindowLevel;

@end
