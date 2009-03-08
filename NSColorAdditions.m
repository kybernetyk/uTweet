#import "NSColorAdditions.h"

@implementation NSColor (CustomAlternatingRowBackgroundColors)
+ (NSArray *)controlAlternatingRowBackgroundColors 
{
	NSColor * anEvenRowColor = [NSColor colorWithDeviceRed: 0.8f green: 0.7f blue: 0.65f alpha: 0.8];
	NSColor * anOddRowColor = [NSColor colorWithDeviceRed: 0.70f green: 0.55f blue: 0.45f alpha: 0.8];
	
	return [NSArray arrayWithObjects:anEvenRowColor, anOddRowColor, nil];
}

@end

