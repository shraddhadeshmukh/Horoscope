//
//  AstroDetailView.m
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstroDetailView.h"
#import "TFHppleElement.h"
#import "TFHpple.h"


/*
const NSUInteger kNumImages		= 3;
const CGFloat kScrollObjHeight	= 340.0;
const CGFloat kScrollObjWidth	= 280.0;
*/
static int selView = 1;

@implementation AstroDetailView
@synthesize txtView,bmonth,bdate,plistDictionary,scrollView,horoContent,lblZodiac;
@synthesize zodiacSign,todaysHoro,weeksHoro,monthsHoro;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
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
	
	
	//Get Month and Day
	todaysHoro = [[NSString alloc]init];
	NSString *month = [[NSString alloc] initWithString:@"April"];
	NSString *day = [[NSString alloc] initWithString:bdate];
	zodiacSign=[[NSString alloc]init];
	[scrollView setZoomScale:0];
	[txtView setEditable:NO];
	month = [plistDictionary objectForKey:@"Month"];
	day = [plistDictionary objectForKey:@"Day"];
	
	//Get Zodiac Sign
	NSLog(@"%@,%@",month,day);
	int days = [day intValue];
	
	if ([month isEqualToString:@"April"] && (days<20)) {
		zodiacSign = @"Aries";
	}
	else if (([month isEqualToString:@"March"]) && (days>20)) {
		zodiacSign = @"Aries";
	}else if (([month isEqualToString:@"April"]) && (days>20)) {
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
	
	//Adding Swipe Gesture
	UISwipeGestureRecognizer *frontRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(frontSwipeDetected)] autorelease];
	UISwipeGestureRecognizer *backRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSwipeDetected)] autorelease];
	frontRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	
	[self.view addGestureRecognizer:frontRecognizer];
	[self.view addGestureRecognizer:backRecognizer];
	
	txtView.text = @"temphoroscope";
	horoContent = [NSString stringWithFormat:@"Horoscope for %@\n",zodiacSign];
	lblZodiac.text = horoContent;
	//txtView.text = horoContent;
	[self getTodaysHoroscope];
	[self getMonthsHoroscope];
	[self getWeekHoroscope];
	
	[self displayTodaysHoroscope];
	
	
}

-(void)getTodaysHoroscope{
	
	NSString *myTitle = [[[NSString alloc]init]autorelease];
	NSData *htmlData = [[NSString stringWithContentsOfURL:[NSURL URLWithString: @"http://astrotwinsdaily.wordpress.com/feed/"]] dataUsingEncoding:NSUTF8StringEncoding];
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
	NSMutableArray *date = [xpathParser search:@"//title"];
	if ([date count]>0){ 	
		TFHppleElement *dateElement = [date objectAtIndex:2];
		NSLog(@"%@",[dateElement content]);
		NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"LLLL d"];
		NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
		
		NSLog(@"Todays Date=%@",dateString);
		if ([[dateElement content] isEqualToString:dateString]) {
			NSMutableArray *elements  = [xpathParser search:@"//p"]; // get the page title - this is xpath notation
			for(int i=0;i<[elements count]-1;i++){
				TFHppleElement *element = [elements objectAtIndex:i];
				myTitle = [element content];
				if ([myTitle hasPrefix:zodiacSign]){
					//	txtView.text = myTitle;
					//NSLog(@"%@",myTitle);
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äô" withString:@"'"];
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Ä¶" withString:@"…"];
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äù" withString:@"\""];	
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äú" withString:@"\""];
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äî" withString:@"-"];		
					myTitle=[myTitle stringByAppendingString:myTitle];
					NSLog(@"%@",myTitle);
					self.todaysHoro = myTitle;
				}
			}
		}else {
			self.todaysHoro = @"Todays Horoscope is not Available.";
		}

	}
	
}

-(void)getMonthsHoroscope{

	NSString *myTitle = [[[NSString alloc]init]autorelease];
	NSData *htmlData = [[NSString stringWithContentsOfURL:[NSURL URLWithString: @"http://astrotwinsdaily.wordpress.com/feed/"]] dataUsingEncoding:NSUTF8StringEncoding];
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
	NSMutableArray *date = [xpathParser search:@"//title"];
	if ([date count]>0){ 	
		TFHppleElement *dateElement = [date objectAtIndex:2];
		NSLog(@"%@",[dateElement content]);
		NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"LLLL d"];
		NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
		
		NSLog(@"Todays Date=%@",dateString);
		if (![[dateElement content] isEqualToString:dateString]) {
			NSMutableArray *elements  = [xpathParser search:@"//p"]; // get the page title - this is xpath notation
			for(int i=0;i<[elements count]-1;i++){
				TFHppleElement *element = [elements objectAtIndex:i];
				myTitle = [element content];
				if ([myTitle hasPrefix:zodiacSign]){
					//	txtView.text = myTitle;
					//NSLog(@"%@",myTitle);
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äô" withString:@"'"];
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Ä¶" withString:@"…"];
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äù" withString:@"\""];	
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äú" withString:@"\""];
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äî" withString:@"-"];		
					myTitle=[myTitle stringByAppendingString:myTitle];
					NSLog(@"%@",myTitle);
					self.todaysHoro = myTitle;
				}
			}
		}else {
			self.monthsHoro = @"Month Horoscope is not Available.";
		}
		
	}
	
}

-(void)getWeekHoroscope{
		
	//NSDate *firstDayOfWeek = (NSDate*)[[NSDate date] firstWeekday];
	
	NSString *myTitle = [[[NSString alloc]init]autorelease];
	NSData *htmlData = [[NSString stringWithContentsOfURL:[NSURL URLWithString: @"http://astrotwinsdaily.wordpress.com/feed/"]] dataUsingEncoding:NSUTF8StringEncoding];
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
	NSMutableArray *date = [xpathParser search:@"//title"];
	if ([date count]>0){ 	
		TFHppleElement *dateElement = [date objectAtIndex:2];
		NSLog(@"%@",[dateElement content]);
		NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"LLLL d"];
		
		NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
		
		NSLog(@"Todays Date=%@",dateString);
		if (![[dateElement content] isEqualToString:dateString]) {
			NSMutableArray *elements  = [xpathParser search:@"//p"]; // get the page title - this is xpath notation
			for(int i=0;i<[elements count]-1;i++){
				TFHppleElement *element = [elements objectAtIndex:i];
				myTitle = [element content];
				if ([myTitle hasPrefix:zodiacSign]){
					//	txtView.text = myTitle;
					//NSLog(@"%@",myTitle);
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äô" withString:@"'"];
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Ä¶" withString:@"…"];
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äù" withString:@"\""];	
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äú" withString:@"\""];
					myTitle=[myTitle stringByReplacingOccurrencesOfString:@"‚Äî" withString:@"-"];		
					myTitle=[myTitle stringByAppendingString:myTitle];
					NSLog(@"%@",myTitle);
					self.todaysHoro = myTitle;
				}
			}
		}else {
			self.weeksHoro = @"Week Horoscope is not Available.";
		}
		
	}
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)frontSwipeDetected{
		
	if (selView==1) {
		selView=2;
		[self displayMonthlyHoroscope];
	}else if (selView==0) {
		selView=1;
		[self displayTodaysHoroscope];
	}
	
}
-(IBAction)backSwipeDetected{
		
	if (selView==1) {
		selView=0;
		[self displayWeeklyHoroscope];
	}else if (selView==2) {
		selView=1;
		[self displayTodaysHoroscope];
	}
}

- (IBAction)displayWeeklyHoroscope{
	
	txtView.text = @"Weekly";
	selView=0;
	[weeklyBtn setHighlighted:YES];
	[monthlyBtn setHighlighted:NO];
	[todayBtn setHighlighted:NO];
	txtView.text = self.weeksHoro;
}

- (IBAction)displayTodaysHoroscope{
	txtView.text = @"Today";
	selView=1;
	[weeklyBtn setHighlighted:NO];
	[monthlyBtn setHighlighted:NO];
	[todayBtn setHighlighted:YES];
	txtView.text = self.todaysHoro;
}


- (IBAction)displayMonthlyHoroscope{
	txtView.text = @"Monthly";
	selView=2;
	[weeklyBtn setHighlighted:NO];
	[monthlyBtn setHighlighted:YES];
	[todayBtn setHighlighted:NO];
	txtView.text = self.monthsHoro;
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	[todaysHoro release];
	[scrollView release];
	[horoContent release];
	[lblZodiac release];
	[bdate release];
	[bmonth release];
	[plistDictionary release];
	[txtView release];
    [super dealloc];
}


@end
