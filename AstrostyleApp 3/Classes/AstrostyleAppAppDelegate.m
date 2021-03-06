//
//  AstrostyleAppAppDelegate.m
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AstrostyleAppAppDelegate.h"
#import "AstrostyleAppViewController.h"
#import "AstroDetailView.h"

@implementation AstrostyleAppAppDelegate

@synthesize window;
@synthesize viewController,tabBarController;
@synthesize plistDictionary,mon,dayValue;

#pragma mark -
#pragma mark Application lifecycle



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
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
	
	mon = [plistDictionary objectForKey:@"Month"];
	dayValue = [plistDictionary objectForKey:@"Day"];
    // Override point for customization after application launch.

	if (([mon isEqualToString:@""])||([dayValue isEqualToString:@""])) {
		[self.window addSubview:viewController.view];
		[self.window makeKeyAndVisible];
	}else{
		AstroDetailView *horoDetailview = [[AstroDetailView alloc]init];
		horoDetailview.bmonth = mon;
		horoDetailview.bdate = dayValue;
		[self.window addSubview:tabBarController.view];
		[self.window makeKeyAndVisible];
	
	}
    // Add the view controller's view to the window and display.

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[mon release];
	[dayValue release];
//	[plistDictionary release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
