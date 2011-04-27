//
//  AstroDetailView.h
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AstroDetailView : UIViewController <NSXMLParserDelegate>{

	IBOutlet UITextView *txtView;
	NSString *bmonth;
	NSString *bdate;
	NSMutableDictionary *plistDictionary;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIButton *weeklyBtn;
	IBOutlet UIButton *todayBtn;
	IBOutlet UIButton *monthlyBtn;
	IBOutlet UILabel *lblZodiac;
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
}
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

//- (void)layoutScrollImages;
-(void)getTodaysHoroscope;
-(void)getWeekHoroscope;
-(void)getMonthsHoroscope;
- (IBAction)displayWeeklyHoroscope;
- (IBAction)displayTodaysHoroscope;
- (IBAction)displayMonthlyHoroscope;
- (IBAction)frontSwipeDetected;
- (IBAction)backSwipeDetected;
- (void)parseXMLFileAtURL:(NSString *)URL;
@end
