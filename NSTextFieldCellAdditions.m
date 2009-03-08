//
//  NSTextFieldCellAdditions.m
//  uTweet
//
//  Created by jrk on 05.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSTextFieldCellAdditions.h"


@implementation NSTextFieldCell (CustomExpansionFrame)


// disable the tooltip like tableview shit lol
- (NSRect)expansionFrameWithFrame:(NSRect)cellFrame inView:(NSView *)view
{
	return NSZeroRect;
}

@end