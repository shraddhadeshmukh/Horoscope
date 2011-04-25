//
//  AstroDetailView.m
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstroDetailView.h"

const NSUInteger kNumImages		= 3;
const CGFloat kScrollObjHeight	= 199.0;
const CGFloat kScrollObjWidth	= 280.0;

@implementation AstroDetailView
@synthesize swipeRecognizer,swipeRightRecognizer,txtView,bmonth,bdate,plistDictionary,scrollView;

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
	//[txtView setEditable:NO];
	month = [AstroDetailView getValue:@"Month"];
	day = [AstroDetailView getValue:@"Day"];
	int days = [day intValue];
	if ((month==@"January")&&(day)) {
		<#statements#>
	}
	
	txtView.text = @"temphoroscope";
	//UIGestureRecognizer *recognizer;
	
	swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
	self.swipeRecognizer = (UISwipeGestureRecognizer *)swipeRecognizer;
	[self.view addGestureRecognizer:swipeRecognizer];
	swipeRecognizer.delegate = self;
	
	swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
	self.swipeRightRecognizer = (UISwipeGestureRecognizer *)swipeRecognizer;
	[self.view addGestureRecognizer:swipeRightRecognizer];
	swipeRightRecognizer.delegate = self;
	swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight; 
	//[recognizer release];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	
	
	[scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	scrollView.scrollEnabled = YES;
	
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
	scrollView.pagingEnabled = YES;
	
	// load all the images from our bundle and add them to the scroll view
	NSUInteger i;
	for (i = 1; i <= kNumImages; i++)
	{
		NSString *pageName = [NSString stringWithFormat:@"View for ", ];
				
		txtView.text = pageName;
		
		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		CGRect rect = txtView.frame;
		rect.size.height = kScrollObjHeight;
		rect.size.width = kScrollObjWidth;
		txtView.frame = rect;
		//imageView.tag = i;	// tag our images for later use when we place them in serial fashion
		[scrollView addSubview:txtView];
		//[imageView release];
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	
    // Disallow recognition of tap gestures in the segmented control.
   // if ((touch.view == segmentedControl) && (gestureRecognizer == tapRecognizer)) {
  ////      return NO;
   // }
    return YES;
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
	
	//CGPoint location = [recognizer locationInView:self.view];
	//[self showImageWithText:@"swipe" atPoint:location];
	
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        
		txtView.text = @"Left Swipe";
		//[segmentedControl setSelectedSegmentIndex:2];
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        txtView.text = @"Right Swipe";
		//[segmentedControl setSelectedSegmentIndex:0];
    }
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.55];
	self.view.alpha = 0.0;
	self.view.alpha = 1.0;
	[UIView commitAnimations];
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
	[swipeRecognizer release];
	[plistDictionary release];
	[txtView release];
    [super dealloc];
}


@end
