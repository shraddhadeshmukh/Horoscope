//
//  AstrostyleAppViewController.h
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AstrostyleAppViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource> {

	IBOutlet UIPickerView *datePicker;
	NSMutableArray *arrayDate;
	NSMutableArray *arrayMonth;
	NSInteger *noofDays;
	NSString *selDate;
	NSString *selMonth;
	
}
@property (nonatomic,retain)IBOutlet UIPickerView *datePicker;
@property (nonatomic,retain)IBOutlet NSString *selDate;
@property (nonatomic,retain)IBOutlet NSString *selMonth;

-(IBAction)selectDate:(id)sender;

@end

