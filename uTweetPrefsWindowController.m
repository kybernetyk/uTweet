//
//  uTweetPrefsWindowController.m
//  uTweet
//
//  Created by jrk on 05.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "uTweetPrefsWindowController.h"


@implementation uTweetPrefsWindowController
- (void)setupToolbar
{
	[self addView:generalPrefsView label:@"General"];
	[self addView:advancedPrefsView label:@"Advanced"];
}

@end
