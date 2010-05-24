//
//  SNES4iPadAppDelegate.m
//  SNES4iPad
//
//  Created by Yusef Napora on 5/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "SNES4iPadAppDelegate.h"

#import "EmulationViewController.h"
#import "RomSelectionViewController.h"
#import "RomDetailViewController.h"
#import "SettingsViewController.h"
#import "ControlPadConnectViewController.h"
#import "ControlPadManager.h"


SNES4iPadAppDelegate *AppDelegate()
{
	return (SNES4iPadAppDelegate *)[[UIApplication sharedApplication] delegate];
}

@implementation SNES4iPadAppDelegate

@synthesize window, splitViewController, romSelectionViewController, romDetailViewController, settingsViewController;
@synthesize controlPadConnectViewController, controlPadManager;
@synthesize romDirectoryPath, saveDirectoryPath, snapshotDirectoryPath;
@synthesize emulationViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
      
      [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
	settingsViewController = [[SettingsViewController alloc] init];
	// access the view property to force it to load
	settingsViewController.view = settingsViewController.view;
	
	controlPadConnectViewController = [[ControlPadConnectViewController alloc] init];
	controlPadManager = [[ControlPadManager alloc] init];
	

	NSString *documentsPath = @"/var/mobile/Media";
	romDirectoryPath = [[documentsPath stringByAppendingPathComponent:@"ROMs/SNES/"] retain];
	saveDirectoryPath = [[romDirectoryPath stringByAppendingPathComponent:@"saves"] retain];
	snapshotDirectoryPath = [[saveDirectoryPath stringByAppendingPathComponent:@"snapshots"] retain];
		
	// Make the main emulator view controller
	emulationViewController = [[EmulationViewController alloc] init];
	emulationViewController.view.hidden = YES;
	
	
    // Add the split view controller's view to the window and display.
    [window addSubview:splitViewController.view];
	
	// Add the emulation view in its hidden state.
	[window addSubview:emulationViewController.view];
	
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Save data if appropriate
}

- (void) showEmulator:(BOOL)showOrHide
{
	if (showOrHide) {
        self.splitViewController.view.hidden = YES;
        self.emulationViewController.view.hidden = NO;
		[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
	} else {
        self.emulationViewController.view.hidden = YES;
        self.splitViewController.view.hidden = NO;
		[[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
	}
}



#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[romDirectoryPath release];
	[settingsViewController release];
	[romDetailViewController release];
	[romSelectionViewController release];
	[controlPadManager release];
	[controlPadConnectViewController release];
    [splitViewController release];
    [window release];
    [super dealloc];
}


@end

