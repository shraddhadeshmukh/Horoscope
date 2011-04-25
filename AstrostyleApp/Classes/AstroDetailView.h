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
	IBOutlet UIButton *weeklyBtn;
	IBOutlet UIButton *todayBtn;
	IBOutlet UIButton *monthlyBtn;
}

@property (nonatomic,retain)IBOutlet UITextView *txtView;
@property (nonatomic,retain)NSString *bmonth;
@property (nonatomic,retain)NSString *bdate;
@property (nonatomic,retain)NSMutableDictionary *plistDictionary;
@property (nonatomic,retain)IBOutlet UIScrollView *scrollView;


- (void)layoutScrollImages;
- (IBAction)displayWeeklyHoroscope:(id)sender;
- (IBAction)displayTodaysHoroscope:(id)sender;
- (IBAction)displayMonthlyHoroscope:(id)sender;

@end
