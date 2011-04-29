//
//  AstroDetailView.h
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBDialog.h"
#import "FBConnect.h"
#import "FBSession.h"
#import "FBRequest.h"
#import "FBDialog.h"
#import "FBStreamDialog.h"
#import "FBLoginButton.h"
#import "FBLoginDialog.h"
#import "FBConnectGlobal.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AstroDetailView : UIViewController <FBDialogDelegate,FBSessionDelegate,FBRequestDelegate,FBTranslationsLoaderDelegate,MFMailComposeViewControllerDelegate>{

	
	//Facebook *facebook;
	
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
		
	NSMutableDictionary * item;
	
	
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
	
	IBOutlet UIButton* _permissionButton;
	IBOutlet UIButton* _feedButton;
	IBOutlet UIButton* _statusButton;
	IBOutlet UIButton* _photoButton;
	IBOutlet FBLoginButton* _loginButton;
	FBSession* _session;
	
	NSString *toEmailAddress;
	NSString *errorMessage;
	IBOutlet UILabel *message;
	IBOutlet UIButton *emailBtn;
	
													
}
//@property (nonatomic,retain)Facebook *facebook;
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

@property(nonatomic,retain) NSString *toEmailAddress;
@property(nonatomic,retain) NSString *bccEmailAddress;
@property(nonatomic,retain) NSString *errorMessage;


-(void)getTodaysHoroscope;
-(void)getWeekHoroscope;
-(void)getMonthsHoroscope;
- (IBAction)displayWeeklyHoroscope;
- (IBAction)displayTodaysHoroscope;
- (IBAction)displayMonthlyHoroscope;
- (IBAction)frontSwipeDetected;
- (IBAction)backSwipeDetected;

//Facebook Methods
- (IBAction)askPermission;
- (IBAction)publishStatus;
- (IBAction)publishFeed:(id)target;
- (IBAction)setStatus:(id)target;
- (IBAction)uploadPhoto:(id)target;
- (void)translationExamples;
- (void)translationsDidLoad;
- (void)translationsDidFailWithError:(NSError *)error;


-(IBAction)emailHoroscope;
-(void)displayComposerSheet;
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error; 
-(void)launchMailAppOnDevice;

@end
