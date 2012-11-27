//
//  CMAppDelegate.m
//  TWFY
//
//  Created by Tim on 20/11/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMAppDelegate.h"

#import <RestKit/Restkit.h>

#import "CMMPTableViewController.h"
#import "CMConstViewController.h"
#import "CMPartyTableViewController.h"
#import "CMSettingsViewController.h"

#import "CMParser.h"

@implementation CMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Initialise Magical Record
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"TWFY.sqlite"];
/*
    NSURL *storeUrl = [NSPersistentStore MR_urlForStoreName:@"TWYF.sqlite"];
    NSLog(@"url = %@", storeUrl);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TWFY" ofType:@"sqlite"];
    
    NSURL *preloadURL = [NSURL fileURLWithPath:path];
    NSError* err = nil;
        
    if (![[NSFileManager defaultManager] copyItemAtURL:preloadURL toURL:storeUrl error:&err]) {
        NSLog(@"Oops, could not copy preloaded data");
    }

    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"TWFY.sqlite"];
*/
    // Create initial MP objects
    CMParser *parser = [[CMParser alloc] init];
    [parser parseInitialAppData];
    
    
/*    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[CMViewController alloc] initWithNibName:@"CMViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[CMViewController alloc] initWithNibName:@"CMViewController_iPad" bundle:nil];
    } */
    
    CMMPTableViewController *mpTable = [[CMMPTableViewController alloc] initWithNibName:@"CMMPTableView" bundle:nil];
    UINavigationController *mpNavController = [[UINavigationController alloc] initWithRootViewController:mpTable];
    [mpNavController setTitle:@"MPs"];
    
    CMConstViewController *constTable = [[CMConstViewController alloc] initWithNibName:@"CMConstView" bundle:nil];
    UINavigationController *constNavController = [[UINavigationController alloc] initWithRootViewController:constTable];
    [constNavController setTitle:@"Constituencies"];
    
    CMPartyTableViewController *partyTable = [[CMPartyTableViewController alloc] initWithNibName:@"CMPartyTableView" bundle:nil];
    UINavigationController *partyNavController = [[UINavigationController alloc] initWithRootViewController:partyTable];
    [partyNavController setTitle:@"Parties"];
    
    CMSettingsViewController *settingsView = [[CMSettingsViewController alloc] initWithNibName:@"CMSettingsView" bundle:nil];
    [settingsView setTitle:@"Settings"];
    
    NSArray *tabsArray = [NSArray arrayWithObjects:mpNavController, constNavController, partyNavController, settingsView, nil];
    
    // Instantiate tab bar
    UITabBarController *tbc = [[UITabBarController alloc] init];
    [tbc setViewControllers:tabsArray];
    
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

@end
