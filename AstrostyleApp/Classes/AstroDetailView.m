//
//  AstroDetailView.m
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstroDetailView.h"

/*
const NSUInteger kNumImages		= 3;
const CGFloat kScrollObjHeight	= 340.0;
const CGFloat kScrollObjWidth	= 280.0;
*/
static int selView = 1;

@implementation AstroDetailView
@synthesize txtView,bmonth,bdate,plistDictionary,scrollView,horoContent,lblZodiac;

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
	//Get Month and Day
	NSString *month = [[[NSString alloc]initWithString:bmonth] autorelease];
	NSString *day = [[[NSString alloc]initWithString:bdate]autorelease];
	NSString *zodiacSign=[[NSString alloc]init];
	[scrollView setZoomScale:0];
	[txtView setEditable:NO];
	month = [AstroDetailView getValue:@"Month"];
	day = [AstroDetailView getValue:@"Day"];
	
	//Get Zodiac Sign
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
	[self displayTodaysHoroscope:self];
	
	//if ([stories count] == 0) {
		
		NSString * path = @"http://astrotwinsdaily.wordpress.com/";
	[self parseXMLFileAtURL:path];
	NSString *convertString = [[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:path]];
	NSLog(@"%@",convertString);
	
	txtView.text = horoContent;//[stories objectAtIndex:20];

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
		[self displayMonthlyHoroscope:self];
	}else if (selView==0) {
		selView=1;
		[self displayTodaysHoroscope:self];
	}
	
}
-(IBAction)backSwipeDetected{
		
	if (selView==1) {
		selView=0;
		[self displayWeeklyHoroscope:self];
	}else if (selView==2) {
		selView=1;
		[self displayTodaysHoroscope:self];
	}
}

- (IBAction)displayWeeklyHoroscope:(id)sender{
	
	txtView.text = @"Weekly";
	selView=0;
	[weeklyBtn setHighlighted:YES];
	[monthlyBtn setHighlighted:NO];
	[todayBtn setHighlighted:NO];
}

- (IBAction)displayTodaysHoroscope:(id)sender{
	txtView.text = @"Today";
	selView=1;
	[weeklyBtn setHighlighted:NO];
	[monthlyBtn setHighlighted:NO];
	[todayBtn setHighlighted:YES];
}

- (IBAction)displayMonthlyHoroscope:(id)sender{
	txtView.text = @"Monthly";
	selView=2;
	[weeklyBtn setHighlighted:NO];
	[monthlyBtn setHighlighted:YES];
	[todayBtn setHighlighted:NO];
}



- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found file and started parsing");
	
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
	stories = [[NSMutableArray alloc] init];
	    
    NSURL *xmlURL = [NSURL URLWithString:URL];
	    
    rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
	NSLog(@"%@",rssParser);
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [rssParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
	[rssParser setShouldResolveExternalEntities:NO];
	
    [rssParser parse];
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
		
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
   // NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"small"]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
	}
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	
	if ([elementName isEqualToString:@"small"]) {
		
		[item setObject:currentSummary forKey:@"p"];
		
		NSLog(@"ended element: %@", elementName);
		[stories addObject:[item copy]];
		//NSLog(@"adding story: %@", currentTitle);
		
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentElement isEqualToString:@"title"]) {
	//	[currentTitle appendString:string];
	//} else if ([currentElement isEqualToString:@"link"]) {
	//	[currentLink appendString:string];
	} else if ([currentElement isEqualToString:@"p"]) {
		[currentSummary appendString:string];
		NSLog(@"found characters: %@", string);
		//NSString *temp=@"capricorn";
		//if([string length]>10){
		//	NSLog(@"Substring = %@",[string substringToIndex:10]);
		//if ([string hasPrefix:@"Capricorn"]) {
			horoContent = [horoContent stringByAppendingString:string];
		//}
		//}
	} else if ([currentElement isEqualToString:@"small"]) {
		[currentDate appendString:string];
		NSLog(@"found characters: %@", string);
		horoContent = [horoContent stringByAppendingString:string];
	}
	
	//NSLog(@"Summary%@",string);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	
	NSLog(@"all done!");
	NSLog(@"stories array has %d items", [stories count]);
	//[newsTable reloadData];
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
	[bdate release];
	[bmonth release];
	[plistDictionary release];
	[txtView release];
    [super dealloc];
}


@end
