//
//  AstrostyleAppViewController.m
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstrostyleAppViewController.h"
#import "AstroDetailView.h"
#import "AstrostyleAppAppDelegate.h"
 
@implementation AstrostyleAppViewController
@synthesize datePicker,selDate,selMonth;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	arrayMonth = [[NSMutableArray alloc]initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December",nil];
	
	arrayDate =  [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",nil];
	selDate = @"1";
	selMonth = @"January";
	noofDays = (NSInteger*)31;
    [super viewDidLoad];

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	if (component==0) {
		return [arrayMonth count];
	}else {
		return (NSInteger)noofDays;
	}
	
	return [arrayDate count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component==0) {
		return [arrayMonth objectAtIndex:row];
	}else{
		return [arrayDate objectAtIndex:row];
	}
	return [arrayMonth objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (component==0) {
		if (row==0) {
			//[datePicker selectRow:row-1 inComponent:1 animated:YES];
			noofDays=(NSInteger*)31;
			[datePicker reloadComponent:1];
		}
		else if(row==1){
			noofDays = (NSInteger*)28;
			[datePicker reloadComponent:1];
		}else if(row==2){
			noofDays = (NSInteger*)31;
			[datePicker reloadComponent:1];
		}else if(row==3){
			noofDays = (NSInteger*)30;
			[datePicker reloadComponent:1];
		}else if(row==4){
			noofDays = (NSInteger*)31;
			[datePicker reloadComponent:1];
		}else if(row==5){
			noofDays = (NSInteger*)30;
			[datePicker reloadComponent:1];
		}else if(row==6){
			noofDays = (NSInteger*)31;
			[datePicker reloadComponent:1];
		}else if(row==7){
			noofDays = (NSInteger*)31;
			[datePicker reloadComponent:1];
		}else if(row==8){
			noofDays = (NSInteger*)30;
			[datePicker reloadComponent:1];
		}else if(row==9){
			noofDays = (NSInteger*)31;
			[datePicker reloadComponent:1];
		}else if(row==10){
			noofDays = (NSInteger*)30;
			[datePicker reloadComponent:1];
		}else if(row==11){
			noofDays = (NSInteger*)31;
			[datePicker reloadComponent:1];
		}
	}
	
	if (component==0) {
		NSLog(@"Selected Color: %@. Index of selected color: %i", [arrayMonth objectAtIndex:row], row);
		selMonth = [arrayMonth objectAtIndex:row];
	}else if (component==1) {
		NSLog(@"Selected Color: %@. Index of selected color: %i", [arrayDate objectAtIndex:row], row);
		selDate = [arrayDate objectAtIndex:row];
	}
}

-(IBAction)selectDate:(id)sender{
	
	NSLog(@"Month=%@, date=%@",selMonth,selDate);

	BOOL success;
	NSError *error;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Store.plist"];
	
	success = [fileManager fileExistsAtPath:filePath];
	if (!success) {
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"Store" ofType:@"plist"];
		success = [fileManager copyItemAtPath:path toPath:filePath error:&error];
    }
	
	NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	
	[plistDict setValue:selMonth forKey:@"Month"];
	[plistDict setValue:selDate forKey:@"Day"];
	[plistDict writeToFile:filePath atomically: YES];
	[plistDict release];
	AstrostyleAppAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	//[appDelegate.viewController ]
	AstroDetailView *detailView = [[[AstroDetailView alloc]initWithNibName:@"AstroDetailView" bundle:nil] autorelease];
	detailView.bdate = selDate;
	detailView.bmonth = selMonth;
	[appDelegate.viewController presentModalViewController:detailView animated:YES];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	
}


- (void)dealloc {
	[datePicker release];
	[selDate release];
	[selMonth release];
    [super dealloc];
}

@end
