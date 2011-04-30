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
#import "FBConnect.h"
#import "FBDialog.h"



static NSString* kApiKey = @"";

// Enter either your API secret or a callback URL (as described in documentation):
static NSString* kApiSecret = @""; // @"<YOUR SECRET KEY>";
static NSString* kGetSessionProxy = nil; // @"<YOUR SESSION CALLBACK)>";

///////////////////////////////////////////////////////////////////////////////////////////////////
static int selView = 1;

@implementation AstroDetailView
@synthesize txtView,bmonth,bdate,plistDictionary,scrollView,horoContent,lblZodiac;
@synthesize zodiacSign,todaysHoro,weeksHoro,monthsHoro,bgImage,tileImage,bgImageName,tileImageName;
@synthesize lblTitle,lblText,lblRight,lblLeft;
@synthesize toEmailAddress, bccEmailAddress,errorMessage;

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
	
	//Checking for Facebook Session
	if (kGetSessionProxy) {
		_session = [[FBSession sessionForApplication:kApiKey getSessionProxy:kGetSessionProxy
											delegate:self] retain];
	} else {
		_session = [[FBSession sessionForApplication:kApiKey secret:kApiSecret delegate:self] retain];
		NSLog(@"Loading Apikey=%@",_session.apiKey);
		[self askPermission];
	}
	if (_session) {
		[_session resume];
	}
	[_loginButton initButton]; 
	_loginButton.style = FBLoginButtonStyleNormal;
	
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
	[weeksview addSubview:_loginButton];
	[weeksview addSubview:emailBtn];
	[weeksview addSubview:_feedButton];
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
	[todaysview addSubview:_loginButton];
	[todaysview addSubview:emailBtn];
	[todaysview addSubview:_feedButton];
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
	[monthsview addSubview:_loginButton];
	[monthsview addSubview:emailBtn];
	[monthsview addSubview:_feedButton];
	
	[self.view addSubview:monthsview];
	txtView.text=self.monthsHoro;
	[txtView reloadInputViews];

}

#pragma mark FBDialogDelegate

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError*)error {
	
	NSLog(@"Error(%d) %@", error.code,error.localizedDescription);
	
}

#pragma mark FBSessionDelegate

- (void)session:(FBSession*)session didLogin:(FBUID)uid {
	
	_permissionButton.hidden = NO;
	_feedButton.hidden       = NO;
	_statusButton.hidden     = NO;
	_photoButton.hidden      = NO;
	
	NSString* fql = [NSString stringWithFormat:
					 @"select uid,name from user where uid == %lld", session.uid];
	NSLog(@"FQL=%@",fql);
	NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
	[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params];
	[self askPermission];
	[self translationExamples];
	
}

- (void)sessionDidNotLogin:(FBSession*)session {
	NSLog(@"Cancel Login");
}

- (void)sessionDidLogout:(FBSession*)session {
	NSLog(@"Disconnected");
	_permissionButton.hidden = NO;
	_feedButton.hidden       = YES;
	_statusButton.hidden     = NO;
	_photoButton.hidden      = NO;
}

#pragma mark FBRequestDelegate

- (void)request:(FBRequest*)request didLoad:(id)result {
	if ([request.method isEqualToString:@"facebook.fql.query"]) {
		NSArray* users = result;
		NSDictionary* user = [users objectAtIndex:0];
		NSString* name = [user objectForKey:@"name"];
		NSLog(@"Logged in as %@", name);
	} else if ([request.method isEqualToString:@"facebook.users.setStatus"]) {
		NSString* success = result;
		if ([success isEqualToString:@"1"]) {
			NSLog(@"Status successfully set");
			
		} else {
			 
			NSLog(@"Problem setting status");
		}
	} else if ([request.method isEqualToString:@"facebook.photos.upload"]) {
		NSDictionary* photoInfo = result;
		NSString* pid = [photoInfo objectForKey:@"pid"];
		
		NSLog(@"Uploaded with pid %@", pid);
	}
}

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error {
	NSLog(@"Error(%d) %@", error.code,error.localizedDescription);
}


- (void)askPermission{
	FBPermissionDialog* dialog = [[[FBPermissionDialog alloc] init] autorelease];
	dialog.delegate = self;
	dialog.permission = @"status_update";
	[dialog show];
	NSLog(@"ASKPERMISSION");
}

- (void)publishFeed:(id)target {
	FBStreamDialog* dialog = [[[FBStreamDialog alloc] init] autorelease];
	dialog.delegate = self;
	dialog.userMessagePrompt = @"Example prompt";
	dialog.attachment = @"{\"name\":\"Facebook Connect for iPhone\",\"href\":\"http://developers.facebook.com/connect.php?tab=iphone\",\"caption\":\"Caption\",\"description\":\"Description\",\"media\":[{\"type\":\"image\",\"src\":\"http://img40.yfrog.com/img40/5914/iphoneconnectbtn.jpg\",\"href\":\"http://developers.facebook.com/connect.php?tab=iphone/\"}],\"properties\":{\"another link\":{\"text\":\"Facebook home page\",\"href\":\"http://www.facebook.com\"}}}";
	// replace this with a friend's UID
	// dialog.targetId = @"999999";
	[dialog show];
}


- (void)publishStatus{

	if (_session.sessionKey) {
		
	NSString *statusString = [[NSString alloc]initWithString:self.txtView.text];
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							statusString, @"status",
							@"true", @"status_includes_verb",
							nil];
	[[FBRequest requestWithDelegate:self] call:@"facebook.users.setStatus" params:params];
	}else {
		UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"Session Expires" message:@"Please login" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil]autorelease];
		[alert show];
	}
}


- (void)setStatus:(id)target {
	NSString *statusString = @"Testing iPhone Connect SDK";
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							statusString, @"status",
							@"true", @"status_includes_verb",
							nil];
	[[FBRequest requestWithDelegate:self] call:@"facebook.users.setStatus" params:params];
}

- (void)uploadPhoto:(id)target {
	NSString *path = @"http://www.facebook.com/images/devsite/iphone_connect_btn.jpg";
	NSURL    *url  = [NSURL URLWithString:path];
	NSData   *data = [NSData dataWithContentsOfURL:url];
	UIImage  *img  = [[UIImage alloc] initWithData:data];
	
	NSDictionary *params = nil;
	[[FBRequest requestWithDelegate:self] call:@"facebook.photos.upload" params:params dataParam:(NSData*)img];
}

// FB Translation Framework examples

- (void)uploadSomeStrings {
	NSError *error = nil;
	int result;
	
	NSString *newString =
    [NSString stringWithFormat:@"String to translate from iPhone SDK, %d.",rand() % 10000];
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
	[dict setObject:@"comment" forKey:newString];
	
	result = [FBNativeStringUploader uploadStringSet:dict error:&error];
}

/*
 * A list of supported locales can be found at:
 * http://www.facebook.com/translations/AppleToFbLocales.plist
 * Or for a programmatic check, see [FBTranslationsLoader supportsLocale:].
 */
- (void)getSomeTranslations {
	NSString *failure = @"Supported locale assertion failed";
	NSAssert2([FBTranslationsLoader supportsLocale:@"es_ES"] == 1,
			  failure,
			  1,
			  [FBTranslationsLoader supportsLocale:@"es_ES"]);
	
	NSAssert2([FBTranslationsLoader supportsLocale:@"xx_YY"] == 0,
			  failure,
			  0,
			  [FBTranslationsLoader supportsLocale:@"xx_YY"]);
	
	
	[FBTranslationsLoader loadTranslationsForLocale:@"es_ES" delegate:self];
}

- (void)translationExamples {
	[self uploadSomeStrings];
	
	[self getSomeTranslations];
}

- (void)assertExpectedTranslation:(NSString *)nativeString
                      description:(NSString *)description
              expectedTranslation:(NSString *)expectedTranslation {
	NSString *translationMismatch =
	@"Translations mismatch. Expected <%@>, got <%@>.";
	
	NSAssert2(
			  [FBLocalizedString(nativeString, description) 
			   isEqualToString:expectedTranslation],
			  translationMismatch,
			  expectedTranslation,
			  FBLocalizedString(nativeString, description)
			  );  
}

- (void)translationsDidLoad {
	NSString *dummy = FBLocalizedString(@"Test String 6", @"Sample description");
	NSString *dummy2 =
    FBLocalizedString(@"Test String 5", @"Test of \"quotes.\", \n, \t.");
	
		
}

- (void)translationsDidFailWithError:(NSError *)error {
	NSAssert(false, @"Loading translations errored.");
}

-(IBAction)emailHoroscope{
		
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	
}
#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"My Horoscope!"];
	
	// Fill out the email body text
	NSString *emailBody = self.txtView.text;
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			message.text = @"Result: failed";
			break;
		default:
			message.text = @"Result: not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Workaround

-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
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
	[_session logout];
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