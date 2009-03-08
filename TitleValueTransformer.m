//
//  TitleValueTransformer.m
//  uTweet
//
//  Created by jrk on 05.03.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TitleValueTransformer.h"


@implementation TitleValueTransformer

+ (Class)transformedValueClass 
{ 
	return [NSString class]; 
}

+ (BOOL)allowsReverseTransformation { return NO; }

- (id)transformedValue:(id)value 
{
    if (value == nil)
		return @"µTweet";
	
	
	return [NSString stringWithFormat:@"µTweet - %@",value];
}

@end
