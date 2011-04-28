//
//  AstroDetailView.h
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AstroDetailView : UIViewController {

	
	
	IBOutlet UITextView *txtView;
	NSString *bmonth;
	NSString *bdate;
	NSMutableDictionary *plistDictionary;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UILabel *lblLeft;
	IBOutlet UILabel *lblRight;
	IBOutlet UILabel *lblZodiac;
	IBOutlet UILabel *lblText;
	IBOutlet UILabel *lblTitle;
	IBOutlet UIView *whiteBG;
	IBOutlet UIImageView *barimage;
	
	NSString *horoContent;
	
	NSXMLParser * rssParser;
	
	NSMutableArray * stories;
	
	
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink;
	UIActivityIndicatorView * activityIndicator;
	NSString *todaysHoro;
	NSString *weeksHoro;
	NSString *monthsHoro;
	NSString *zodiacSign;
	NSString *bgImageName;
	NSString *tileImageName;
	IBOutlet UIImageView *bgImage;
	IBOutlet UIImageView *tileImage;
	
}
@property (nonatomic,retain)IBOutlet UILabel *lblTitle;
@property (nonatomic,retain)IBOutlet UILabel *lblText;
@property (nonatomic,retain)IBOutlet UILabel *lblLeft;
@property (nonatomic,retain)IBOutlet UILabel *lblRight;
@property (nonatomic,retain)NSString *bgImageName;
@property (nonatomic,retain)NSString *tileImageName;
@property (nonatomic,retain)UIImageView *bgImage;
@property (nonatomic,retain)UIImageView *tileImage;
@property (nonatomic,retain)NSString *zodiacSign;
@property (nonatomic,retain)NSString *todaysHoro;
@property (nonatomic,retain)NSString *weeksHoro;
@property (nonatomic,retain)NSString *monthsHoro;
@property (nonatomic,retain)IBOutlet UITextView *txtView;
@property (nonatomic,retain)NSString *bmonth;
@property (nonatomic,retain)NSString *bdate;
@property (nonatomic,retain)NSMutableDictionary *plistDictionary;
@property (nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain)NSString *horoContent;
@property (nonatomic,retain)IBOutlet UILabel *lblZodiac;


-(void)getTodaysHoroscope;
-(void)getWeekHoroscope;
-(void)getMonthsHoroscope;
- (IBAction)displayWeeklyHoroscope;
- (IBAction)displayTodaysHoroscope;
- (IBAction)displayMonthlyHoroscope;
- (IBAction)frontSwipeDetected;
- (IBAction)backSwipeDetected;

@end
