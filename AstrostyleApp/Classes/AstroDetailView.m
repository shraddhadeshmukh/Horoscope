//
//  AstroDetailView.m
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstroDetailView.h"

const NSUInteger kNumImages		= 3;
const CGFloat kScrollObjHeight	= 340.0;
const CGFloat kScrollObjWidth	= 280.0;

@implementation AstroDetailView
@synthesize txtView,bmonth,bdate,plistDictionary,scrollView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

+ (void) initialize{
	
	NSLog(@"initialize Resources.m");
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Store.plist"];
	success = [fileManager fileExistsAtPath:filePath];
	NSLog(@"%@", filePath);
	
	if(!success){
		NSLog(@"not success");
		NSError *error;
		// The writable database does not exist, so copy the default to the appropriate location.
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Store.plist"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:filePath error:&error];
		if (!success) {
			NSAssert1(0, @"Failed to create Messages.plist file with message '%@'.", [error localizedDescription]);
		}
	}
	
	plistDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
	
}

+(NSString *) getValue:(NSString *)key{
	
	NSString *value =  [plistDictionary objectForKey:key];
	return value;
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *month = [[[NSString alloc]initWithString:bmonth] autorelease];
	NSString *day = [[[NSString alloc]initWithString:bdate]autorelease];
	NSString *zodiacSign=[[NSString alloc]init];
	[scrollView setZoomScale:0];
	[txtView setEditable:NO];
	month = [AstroDetailView getValue:@"Month"];
	day = [AstroDetailView getValue:@"Day"];
	NSLog(@"%@,%@",month,day);
	int days = [day intValue];
	if (([month isEqualToString:@"April"])&&(days<20)) {
		zodiacSign = @"Aries";
	}else if (([month isEqualToString:@"March"])&&(days>20)) {
		zodiacSign = @"Aries";
	}else if (([month isEqualToString:@"April"])&&(days>20)) {
		zodiacSign = @"Taurus";
	}else if (([month isEqualToString:@"May"])&&(days<21)) {
		zodiacSign = @"Taurus";
	}else if (([month isEqualToString:@"May"])&&(days>20)) {
		zodiacSign = @"Taurus";
	}else if (([month isEqualToString:@"June"])&&(days<21)) {
		zodiacSign = @"Gemini";
	}else if (([month isEqualToString:@"June"])&&(days>20)) {
		zodiacSign = @"Cancer";
	}else if (([month isEqualToString:@"July"])&&(days<23)) {
		zodiacSign = @"Cancer";
	}else if (([month isEqualToString:@"July"])&&(days>22)) {
		zodiacSign = @"Leo";
	}else if (([month isEqualToString:@"August"])&&(days<23)) {
		zodiacSign = @"Leo";
	}else if (([month isEqualToString:@"August"])&&(days>22)) {
		zodiacSign = @"Virgo";
	}else if (([month isEqualToString:@"September"])&&(days<23)) {
		zodiacSign = @"Virgo";
	}else if (([month isEqualToString:@"September"])&&(days>22)) {
		zodiacSign = @"Libra";
	}else if (([month isEqualToString:@"October"])&&(days<23)) {
		zodiacSign = @"Libra";
	}else if (([month isEqualToString:@"October"])&&(days>22)) {
		zodiacSign = @"Scorpio";
	}else if (([month isEqualToString:@"November"])&&(days<22)) {
		zodiacSign = @"Scorpio";
	}else if (([month isEqualToString:@"November"])&&(days>21)) {
		zodiacSign = @"Sagittarius";
	}else if (([month isEqualToString:@"December"])&&(days<22)) {
		zodiacSign = @"Sagittarius";
	}else if (([month isEqualToString:@"December"])&&(days>23)) {
		zodiacSign = @"Capricorn";
	}else if (([month isEqualToString:@"January"])&&(days<20)) {
		zodiacSign = @"Capricorn";
	}else if (([month isEqualToString:@"January"])&&(days>19)) {
		zodiacSign = @"Aquarius";
	}else if (([month isEqualToString:@"February"])&&(days<19)) {
		zodiacSign = @"Aquarius";
	}else if (([month isEqualToString:@"February"])&&(days>18)) {
		zodiacSign = @"Pisces";
	}else if (([month isEqualToString:@"March"])&&(days<21)) {
		zodiacSign = @"Pisces";
	}

	txtView.text = @"temphoroscope";
		
	[scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
		
	scrollView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	
	// load all the images from our bundle and add them to the scroll view
	NSUInteger i;
	for (i = 1; i <= kNumImages; i++)
	{
		NSString *pageName = [NSString stringWithFormat:@"Horoscope for %@",zodiacSign];
				
		txtView.text = pageName;
		
		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		CGRect rect;// = scrollView.frame;
		rect.size.height = kScrollObjHeight;
		rect.size.width = kScrollObjWidth;
		txtView.frame = rect;
		[scrollView addSubview:txtView];
				
		NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", i];
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		UILabel *label= [[UILabel alloc]init];
		label.text = pageName;
		[imageView addSubview:label]; 
 		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		rect.size.height = kScrollObjHeight;
		rect.size.width = kScrollObjWidth;
		imageView.frame = rect;
		imageView.tag = i;	// tag our images for later use when we place them in serial fashion
		[scrollView addSubview:imageView];
		[imageView release];
	}
	
	[self layoutScrollImages];	// now place the photos in serial layout within the scrollview
}

- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [scrollView subviews];
	
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (kScrollObjWidth);
		}
	}
	
	// set the content size so it can be scrollable
	[scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), [scrollView bounds].size.height)];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)displayWeeklyHoroscope:(id)sender{
}

- (IBAction)displayTodaysHoroscope:(id)sender{
}

- (IBAction)displayMonthlyHoroscope:(id)sender{
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[bdate release];
	[bmonth release];
	
	[plistDictionary release];
	[txtView release];
    [super dealloc];
}


@end
