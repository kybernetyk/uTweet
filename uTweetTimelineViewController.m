//
//  uTweetTimelineViewController.m
//  uTweet
//
//  Created by jrk on 04.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "uTweetTimelineViewController.h"


@implementation uTweetTimelineViewController
@synthesize tweetData;

- (void) setTweetData: (NSArray *) newData
{
	NSLog(@"set load!");
	[self willChangeValueForKey:@"tweetData"];
	[tweetData release];
	
	tweetData = newData;
	[tweetData retain];

	NSSize size;
	size.height = 10;
	
	[tableView setTarget: self];
	[tableView setDoubleAction:@selector(doubleClickOnTableView:)];
	
	[tableView setIntercellSpacing: size];
	[tableView reloadData];
	//[self reloadAndShowContent];
	[self didChangeValueForKey:@"tweetData"];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];


	return self;
}

- (void) reloadAndShowContent;
{
}

- (IBAction) doubleClickOnTableView: (id) sender
{
	NSString *url = [[[tweetData objectAtIndex: [tableView selectedRow]] objectForKey:@"urls"] objectAtIndex: 0];
	
	if (url)
	{
		[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:url]];
	//	[tableView deselectAll: self];
	}

}

#pragma mark ---
#pragma mark tableView Delegates ...
#pragma mark ---

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	NSLog(@"%i",[tweetData count]);
	return [tweetData count];
}

- (float)tableView:(NSTableView *)atableView heightOfRow:(int)row
{
	NSString *str = [[tweetData objectAtIndex:row] objectForKey:@"tweet"];
	NSTableColumn *col = [[tableView tableColumns] objectAtIndex:0];
	
	NSCell *colDataCell = [[[NSCell alloc] initTextCell:str]  
						   autorelease];
	[colDataCell setWraps:YES];
	[colDataCell setFont:[[col dataCell] font]];
	
	return [colDataCell cellSizeForBounds:NSMakeRect(0.0, 0.0, [col width], FLT_MAX)].height;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	/*NSString *s = [NSString stringWithString: @"<b>hallo</b>: ich bin toll"];
	NSData *data = [s dataUsingEncoding: NSUTF16StringEncoding];
	
	NSAttributedString *str = [[NSAttributedString alloc] initWithHTML: data
															   baseURL: nil
													documentAttributes: nil];
	
	return [str string];*/
	return [[tweetData objectAtIndex:rowIndex] objectForKey:@"tweet"];
	//return str;
}


/*- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex
{
	
	return NO;
}*/

@end
