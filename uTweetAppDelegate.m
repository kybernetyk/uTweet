//
//  uTweetAppDelegate.m
//  uTweet
//
//  Created by jrk on 04.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "uTweetAppDelegate.h"
#import "uTweetMainWindowController.h"
#import "uTweetPrefsWindowController.h"
#import "TitleValueTransformer.h"

@implementation uTweetAppDelegate
@synthesize mainWindowController;

+ (void)initialize
{
#ifdef DEBUG
	NSLog(@"initialize");
#endif
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	//NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"YES"	forKey:@"MsgAtStartup"];
	NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys: 
								 @"please set username/pass",@"UserName",
								 @"empty",@"UserPassword",
								 nil]; //esc + space
	
	//achtung - das 1. nil koennte probleme machen bei nachfolgenden defaults!
	
	[userDefaults registerDefaults:appDefaults];
	
}


-(void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
	TitleValueTransformer *titleValueTransformer;
	
	// create an autoreleased instance of our value transformer
	titleValueTransformer = [[[TitleValueTransformer alloc] init]
					   autorelease];
	
	// register it with the name that we refer to it with
	[NSValueTransformer setValueTransformer:titleValueTransformer
									forName:@"TitleValueTransformer"];
	
	
	[self showMainWindow: nil];
	
}

- (IBAction)openPreferencesWindow:(id)sender
{
	[[uTweetPrefsWindowController sharedPrefsWindowController] showWindow: nil];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
	[self showMainWindow: nil];
	return YES;
}

- (void)applicationDidBecomeActive:(NSNotification *)aNotification
{
	[self showMainWindow: nil];
}

- (IBAction) showMainWindow: (id) sender
{
	if (mainWindowController == nil)
	{
		[self setMainWindowController: [[uTweetMainWindowController alloc] initWithWindowNibName:@"MainWindow"]];
		
		
	}
	
	
	if ([[mainWindowController window] isVisible] == NO)
		[[[self mainWindowController] window] makeKeyAndOrderFront: nil];

	[[NSApp dockTile] setBadgeLabel: nil];
}



@end
