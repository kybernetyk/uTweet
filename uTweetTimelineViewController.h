//
//  uTweetTimelineViewController.h
//  uTweet
//
//  Created by jrk on 04.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>


@interface uTweetTimelineViewController : NSViewController 
{
	IBOutlet NSTableView *tableView;
	
	NSArray *tweetData;
}

@property (retain, readwrite) NSArray *tweetData;

// shows the htmlToShow string in the webView 
- (void) reloadAndShowContent;

- (IBAction) doubleClickOnTableView: (id) sender;

@end
