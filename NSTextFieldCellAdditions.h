//
//  NSTextFieldCellAdditions.h
//  uTweet
//
//  Created by jrk on 05.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSTextFieldCell (CustomExpansionFrame)

- (NSRect)expansionFrameWithFrame:(NSRect)cellFrame inView:(NSView *)view;

@end

