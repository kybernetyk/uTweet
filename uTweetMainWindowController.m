//
//  uTweetMainWindowController.m
//  uTweet
//
//  Created by jrk on 04.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "uTweetMainWindowController.h"
#import "uTweetTimelineViewController.h"

@implementation uTweetMainWindowController
@synthesize enteredTweetText;
@synthesize userName;
@synthesize userPassword;
@synthesize isWindowFloating;
@synthesize inputField;

- (void) setIsWindowFloating: (BOOL) newValue
{
//	NSLog(@"set floating %i",newValue);
	[self willChangeValueForKey:@"isWindowFloating"];
	isWindowFloating = newValue;
	
	[self didChangeValueForKey:@"isWindowFloating"];
	
	[self setAppropriateWindowLevel];
}

	
- (void) setAppropriateWindowLevel
{
	//BOOL isFloating = [[NSUserDefaults standardUserDefaults] boolForKey:@"ApplicationWindowFloating"];
	if (isWindowFloating)
		[[self window] setLevel: NSFloatingWindowLevel];
	else
		[[self window] setLevel: NSNormalWindowLevel];
}

/*- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
	NSLog(@"kp change: %@",keyPath);
	
	if ([keyPath isEqual:@"ApplicationWindowFloating"])
	{
		
		[self setAppropriateWindowLevel];
	}

    // be sure to call the super implementation
    // if the superclass implements it
    /*[super observeValueForKeyPath:keyPath
	 ofObject:object
	 change:change
	 context:context];*/
//}


- (void)windowDidLoad
{
	//[[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"ApplicationWindowFloating" options:NSKeyValueObservingOptionNew context: NULL];
//	[self setUserName:@"ROLF"];
	//[self setAppropriateWindowLevel];
	
	/*[self bind:@"userName" toObject:[NSUserDefaults standardUserDefaults] withKeyPath:@"UserName" options: nil];
	[self bind:@"userPassword" toObject:[NSUserDefaults standardUserDefaults] withKeyPath:@"UserPassword" options: nil];
	[self bind:@"isWindowFloating" toObject:[NSUserDefaults standardUserDefaults] withKeyPath:@"ApplicationWindowFloating" options: nil];

	 [inputField bind:@"value" toObject: self withKeyPath: @"enteredTweetText" options: nil];

	 */
//	NSUserDefaultsController *conti = [NSUserDefaultsController sharedUserDefaultsController];
//	NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"NSContinuouslyUpdatesValue"];

	//first bind our properties to the usr defaults
	//so we can get the values
/*	[self bind:@"userName" toObject: conti withKeyPath: @"values.UserName" options: dict];
	[self bind:@"userPassword" toObject: conti withKeyPath: @"values.UserPassword" options: dict];
	[self bind:@"isWindowFloating" toObject: conti withKeyPath: @"values.ApplicationWindowFloating" options: dict];
*/
	//now bind the user defaults to our properties
	//so we can update them through changing our properties
	//thats fufu :( we should update user std explicit over the [[NSUserDefaults]] interface
	//[[NSUserDefaults standardUserDefaults] bind: @"UserName" toObject: self withKeyPath: @"userName" options: nil];
	//[[NSUserDefaults standardUserDefaults] bind: @"UserPassword" toObject: self withKeyPath: @"userPassword" options: nil];
	//[[NSUserDefaults standardUserDefaults] bind: @"ApplicationWindowFloating" toObject: self withKeyPath: @"isWindowFloating" options: nil];
	

	//NOW NEW AND WORKING WITH THE CONTROLLER BIDERCTIONAL
	//SECRET: BIND TO [[] values] and not the controller itself!
	//now setting our member variable will update the user defaults
	id conti = [[NSUserDefaultsController sharedUserDefaultsController] values];
	NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"NSContinuouslyUpdatesValue"];
	
	//first bind our properties to the usr defaults
	//so we can get the values
	[self bind:@"userName" toObject: conti withKeyPath: @"UserName" options: dict];
	[self bind:@"userPassword" toObject: conti withKeyPath: @"UserPassword" options: dict];
	[self bind:@"isWindowFloating" toObject: conti withKeyPath: @"ApplicationWindowFloating" options: dict];
	
	
	//that's wrong!
	/*[conti bind:@"UserName" toObject: self withKeyPath:@"userName" options: nil];
	[conti bind:@"UserPassword" toObject: self withKeyPath:@"userPassword" options: nil];
	[conti bind:@"ApplicationWindowFloating" toObject: self withKeyPath:@"isWindowFloating" options: nil];*/
	

	//OK HEUTE WISSEN WIR MEHR
	//1. binden an "objectcontroller.values.KEY"
	//2. fuer biderectional dann im eigenen objekt
	//	 in der settermethode fuer die gebundene property
	//	 erst das observierte object rausfinden mit:
	//   id obsrvd_obj = [[self infoForBinding:@"userName"] objectForKey:@"NSObservedObject"]
	//	 NSString *obsrvd_keypath = [[self infoForBinding:@"userName"] objectForKey:@"NSObservedKeyPath"];
	//
	//	 und dann das object updaten mit:
	//	 [obsrvd_obj setValue:@"NEUE VALUE" forKeyPath: obsrvd_keypath];
	
	NSLog(@"%@",[self infoForBinding:@"userName"]);
//	id obsrvd = [[self infoForBinding:@"userName"] objectForKey:@"NSObservedObject"];
//	NSString *obsrvd_keypath = [[self infoForBinding:@"userName"] objectForKey:@"NSObservedKeyPath"];
	
	//[[obsrvd values] setUserName:@"OMFG"];
	//[obsrvd setValue:@"OMEGAR" forKeyPath: obsrvd_keypath];
	//[obsrvd setValue:@"kjhjkkkkhk" forKeyPath: obsrvd_keypath];
	//[self setUserName:@"omegarolf"];
//	NSLog(@"%@",conti);

	
	
	timelineViewController = [[uTweetTimelineViewController alloc] initWithNibName:@"TimelineView" bundle: nil];
	[customView addSubview: [timelineViewController view]];

	// Create a TwitterEngine and set our login details.
    twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
	[twitterEngine setClearsCookies: YES];
	[twitterEngine setUsesSecureConnection: NO];
	[twitterEngine setClientName:@"µTweet" version:@"0.1" URL:@"http://www.fluxforge.com" token:@"mutweet"];
    [twitterEngine setUsername: [self userName] password: [self userPassword]];

    
	[[self window] setTitle: [NSString stringWithFormat:@"µTweet - %@",[twitterEngine username]]];

	//3 minuten timer <3
	timelineUpdateTimer = [NSTimer scheduledTimerWithTimeInterval: 180.0f
	 target: self
	 selector: @selector(handleUpdateTimer:)
	 userInfo: nil
	 repeats: YES];
	 
	[self requestTimelineUpdate: nil];

	 
}

- (void) handleUpdateTimer: (NSTimer *) timer
{
	[self requestTimelineUpdate: nil];
}

- (IBAction) requestTimelineUpdate: (id) sender
{
    [twitterEngine setUsername: [self userName] password: [self userPassword]];
	[twitterEngine getFollowedTimelineFor:nil since:nil startingAtPage:0];
}

- (void) processTimelineUpdate: (NSArray *) timelineData
{
	//NSLog(@"%@",timelineData);
	
	NSUInteger recentTweetId = [[[timelineData objectAtIndex: 0] objectForKey:@"id"] intValue];
	NSLog(@"recentID: %i -- lastID: %i",recentTweetId,lastReceivedTweetID);
	if (recentTweetId != lastReceivedTweetID)
	{
	//	[NSApp setBadgeLabel:@"OMG NEW TWEETS!"];
		if ([NSApp isActive] == NO)
			[[NSApp dockTile] setBadgeLabel:@"!!!"];
		lastReceivedTweetID = recentTweetId;
	}
	

	
	NSMutableArray *arr = [NSMutableArray array];

	for (NSDictionary *dict in timelineData)
	{
		NSMutableDictionary *dc = [NSMutableDictionary dictionary];
		
		NSString *authorName = [[dict objectForKey:@"user"] objectForKey:@"screen_name"];
		NSString *tweetText = [dict objectForKey:@"text"];

		NSArray *tempArray = [tweetText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//		NSLog(@"ta: %@",tempArray);

		NSMutableArray *urls = [NSMutableArray array];
		for (NSString *s in tempArray)
		{
			if ([s hasPrefix:@"http://"])
				[urls addObject: s];
		}

		if ([urls count] > 0)
		{
			[dc setObject:urls forKey:@"urls"];
		}
		
		
		//NSLog(@"%@",urls);
		
		NSString *str = [NSString stringWithFormat:@"%@: %@",authorName, tweetText];
		[dc setObject: str forKey:@"tweet"];
		[dc setObject: authorName forKey:@"author"];
		
		
		[arr addObject: [NSDictionary dictionaryWithDictionary:dc]];
	}
	
	
	[timelineViewController setTweetData: [NSArray arrayWithArray: arr]];
}


- (IBAction) sendTweet: (id) sender
{
	//NSLog(@"sending tweet: %@",[self enteredTweetText]);
	//NSLog(@"%@",[inputField stringValue]);
	//return;
	[twitterEngine setUsername: [self userName] password: [self userPassword]];
	
	_updateConnectionIdentifier = [twitterEngine sendUpdate: [self enteredTweetText]];
	[self setEnteredTweetText: @""];
}

- (void)finalize 
{
	NSLog(@"finalize baby");
    [super finalize];
}

#pragma mark ---
#pragma mark MGTwitterEngineDelegate methods
#pragma mark ---
- (void)requestSucceeded:(NSString *)connectionIdentifier
{
    NSLog(@"Request succeeded for connectionIdentifier = %@", connectionIdentifier);
}


- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error
{
    NSLog(@"Request failed for connectionIdentifier = %@, error = %@ (%@)", 
          connectionIdentifier, 
          [error localizedDescription], 
          [error userInfo]);
}


- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)connectionIdentifier
{
 //   NSLog(@"Got statuses for %@:\r%@", connectionIdentifier, statuses);
	if ([connectionIdentifier isEqualToString: _updateConnectionIdentifier])
	{
		_updateConnectionIdentifier = nil;
		[self requestTimelineUpdate: nil];
		return;
	}
	
	[self processTimelineUpdate: statuses];
}


- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got direct messages for %@:\r%@", connectionIdentifier, messages);
}


- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got user info for %@:\r%@", connectionIdentifier, userInfo);
}


- (void)miscInfoReceived:(NSArray *)miscInfo forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got misc info for %@:\r%@", connectionIdentifier, miscInfo);
}

- (void)searchResultsReceived:(NSArray *)searchResults forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got search results for %@:\r%@", connectionIdentifier, searchResults);
}


- (void)imageReceived:(NSImage *)image forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got an image for %@: %@", connectionIdentifier, image);
    
    // Save image to the Desktop.
    NSString *path = [[NSString stringWithFormat:@"~/Desktop/%@.tiff", connectionIdentifier] stringByExpandingTildeInPath];
    [[image TIFFRepresentation] writeToFile:path atomically:NO];
}

- (void)connectionFinished
{
	if ([twitterEngine numberOfConnections] == 0)
	{
		NSLog(@"connection finished. %i open connections left ...",[twitterEngine numberOfConnections]);
		//[NSApp terminate:self];
	}
}

@end
