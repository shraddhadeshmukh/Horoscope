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


static int selView = 1;

@implementation AstroDetailView
@synthesize txtView,bmonth,bdate,plistDictionary,scrollView,horoContent,lblZodiac;
@synthesize zodiacSign,todaysHoro,weeksHoro,monthsHoro,bgImage,tileImage,bgImageName,tileImageName;
@synthesize lblTitle,lblText,lblRight,lblLeft;
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
	NSString *month = [[NSString alloc] init];
	NSString *day = [[NSString alloc] init];
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
	
	bgImageName = [[NSString alloc]init];
	tileImageName = [[NSString alloc]init];
	
	if (zodiacSign==@"Aries") {
		bgImageName = @"Aries-Horo-bkrd.png";
		tileImageName = @"";
	}else if (zodiacSign==@"Taurus") {
		bgImageName = @"Taurus-Horo-bkrd.png";
		tileImageName = @"Taurus-Horo-tile.png";	
	}else if (zodiacSign==@"Gemini") {
		bgImageName = @"Gemini-Horo-bkrd.png";
		tileImageName = @"Gemini-Horo-tile.png";	
	}else if (zodiacSign==@"Cancer") {
		bgImageName = @"Cancer-Horo-bkrd.png";
		tileImageName = @"Cancer-Horo-tile.png";	
	}else if (zodiacSign==@"Leo") {
		bgImageName = @"Leo-Horo-bkrd.png";
		tileImageName = @"Leo-Horo-tile.png";	
	}else if (zodiacSign==@"Virgo") {
		bgImageName = @"Virgo-Horo-bkrd.png";
		tileImageName = @"Virgo-Horo-tile.png";	
	}else if (zodiacSign==@"Libra") {
		bgImageName = @"Libra-Horo-bkrd.png";
		tileImageName = @"Libra-Horo-tile.png";	
	}else if (zodiacSign==@"Scorpio") {
		bgImageName = @"Scorpio-Horo-bkrd.png";
		tileImageName = @"Scorpio-Horo-tile.png";	
	}else if (zodiacSign==@"Sagittarius") {
		bgImageName = @"Sagittarius-Horo-bkrd.png";
		tileImageName = @"Sagittarius-Horo-tile.png";	
	}else if (zodiacSign==@"Capricorn") {
		bgImageName = @"Capricorn-Horo-bkrd.png";
		tileImageName = @"Capricorn-Horo-tile.png";	
	}else if (zodiacSign==@"Aquarius") {
		bgImageName = @"Aquarius-Horo-bkrd.png";
		tileImageName = @"Aquarius-Horo-tile.png";	
	}else if (zodiacSign==@"Pisces") {
		bgImageName = @"Pisces-Horo-bkrd.png";
		tileImageName = @"Pisces-Horo-tile copy.png";	
	}

	bgImage.image= [UIImage imageNamed:bgImageName];
	tileImage.image = [UIImage imageNamed:tileImageName];
	//Adding Swipe Gesture
	UISwipeGestureRecognizer *frontRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(frontSwipeDetected)] autorelease];
	UISwipeGestureRecognizer *backRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSwipeDetected)] autorelease];
	frontRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	
	[self.view addGestureRecognizer:frontRecognizer];
	[self.view addGestureRecognizer:backRecognizer];
		
	lblZodiac.text = zodiacSign;
	//txtView.text = horoContent;
	[self getTodaysHoroscope];
	[self getMonthsHoroscope];
	[self getWeekHoroscope];
	
	[self displayTodaysHoroscope];
	
}

-(void)viewWillAppear:(BOOL)animated{
	
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
	NSLog(@"Front %d",selView);	
	if (selView==1) {
		selView=2;
		[self displayMonthlyHoroscope];
	}else if (selView==0) {
		selView=1;
		[self displayTodaysHoroscope];
	}else if (selView==2) {
		selView = 0;
		[self displayWeeklyHoroscope];
	}
	
}
-(IBAction)backSwipeDetected{
		NSLog(@"Back %d",selView);
	if (selView==1) {
		selView=0;
		[self displayWeeklyHoroscope];
	}else if (selView==2) {
		selView=1;
		[self displayTodaysHoroscope];
	}else if (selView==0) {
		selView=2;
		[self displayMonthlyHoroscope];
	}
}

- (IBAction)displayWeeklyHoroscope{
	
	
	selView=0;
	
	txtView.text = self.weeksHoro;
	UIView *weeksview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 360)];
	[weeksview addSubview:bgImage];
	
	[weeksview addSubview:whiteBG];
	[weeksview addSubview:tileImage];
	//txtView.text=self.monthsHoro;
	[weeksview addSubview:lblZodiac];
	[weeksview addSubview:txtView];
	
	[weeksview addSubview:barimage];
	
	
	lblLeft.text = @"Monthly";
	[weeksview addSubview:lblLeft];
	lblRight.text = @"Daily";
	[weeksview addSubview:lblRight];
	
	lblTitle.text = @"This Week";
	[weeksview addSubview:lblTitle];
	NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];
    NSLog(@"Current date: %@", now);
	
    // required components for today
    NSDateComponents *components = [cal components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit ) fromDate:now];
	
    // adjust them for first day of previous week (Monday)
    [components setWeekday:1];
    [components setWeek:([components week] - 1)];
	
    // construct new date and return
    NSDate *newDate = [cal dateFromComponents:components];
    NSLog(@"New date: %@", newDate);
	
    // adjust them for first day of previous week (Monday)
    [components setWeekday:1];
    [components setWeek:([components week] + 1)];
	
    // construct new date and return
    NSDate *nextDate = [cal dateFromComponents:components];
    NSLog(@"New date: %@", nextDate);
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"LLLL d"];
	
	NSString *dateString = [dateFormatter stringFromDate:newDate];
	lblText.text = dateString;
	
	[dateFormatter setDateFormat:@"dd"];
	NSString *lastdayofweek = [dateFormatter stringFromDate:nextDate];
	
	lblText.text = [lblText.text stringByAppendingFormat:@"-%@",lastdayofweek];
	[weeksview addSubview:lblText];
	
	[self.view addSubview:weeksview];
	txtView.text = self.weeksHoro;
	[txtView reloadInputViews];
}

- (IBAction)displayTodaysHoroscope{
	
	selView=1;
	
	txtView.text = self.todaysHoro;
	UIView *todaysview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 360)];
	[todaysview addSubview:bgImage];
	
	[todaysview addSubview:whiteBG];
	[todaysview addSubview:tileImage];
	
	[todaysview addSubview:lblZodiac];
	[todaysview addSubview:txtView];
	
	[todaysview addSubview:barimage];
		
	lblLeft.text = @"Weekly";
	[todaysview addSubview:lblLeft];
	lblRight.text = @"Monthly";
	[todaysview addSubview:lblRight];
	
	lblTitle.text = @"TODAY";
	[todaysview addSubview:lblTitle];
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"LLLL d, yyyy"];
	
	NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
	lblText.text = dateString;
	[todaysview addSubview:lblText];
	
	[self.view addSubview:todaysview];
	txtView.text = self.todaysHoro;
	[txtView reloadInputViews];
}


- (IBAction)displayMonthlyHoroscope{
	
	selView=2;
	
	UIView *monthsview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 360)];
	[monthsview addSubview:bgImage];
	
	[monthsview addSubview:whiteBG];
	[monthsview addSubview:tileImage];
	txtView.text=self.monthsHoro;
	[monthsview addSubview:lblZodiac];
	[monthsview addSubview:txtView];
	
	[monthsview addSubview:barimage];
	

	lblLeft.text = @"Daily";
	[monthsview addSubview:lblLeft];
	lblRight.text = @"Weekly";
	[monthsview addSubview:lblRight];
		
	lblTitle.text = @"THIS MONTH";
	[monthsview addSubview:lblTitle];
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"LLLL yyyy"];
	
	NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
	lblText.text = dateString;
	[monthsview addSubview:lblText];
	
	[self.view addSubview:monthsview];
	txtView.text=self.monthsHoro;
	[txtView reloadInputViews];
		 
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
