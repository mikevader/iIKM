//
//  AppDelegate.m
//  IKM Database
//
//  Created by Michael Mühlebach on 11/9/11.
//  Copyright (c) 2011 Zühlke Engineering AG. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;


- (void)setupByPreferences
{
    NSString *testValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"IKMServerUrl"];
    if (testValue == nil)
    {
        // no default values have been set, create them here based on what's in our Settings bundle info
        //
        NSString *pathStr = [[NSBundle mainBundle] bundlePath];
        NSString *settingsBundlePath = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
        NSString *finalPath = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
        
        NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSArray *prefSpecifierArray = [settingsDict objectForKey:@"PreferenceSpecifiers"];
        
        NSString *ikmServerUrlDefault = nil;

        NSDictionary *prefItem;
        for (prefItem in prefSpecifierArray)
        {
            NSString *keyValueStr = [prefItem objectForKey:@"Key"];
            id defaultValue = [prefItem objectForKey:@"DefaultValue"];
            
            if ([keyValueStr isEqualToString:@"IKMServerUrl"])
            {
                ikmServerUrlDefault = defaultValue;
            }
//            else if ([keyValueStr isEqualToString:kLastNameKey])
//            {
//                lastNameDefault = defaultValue;
//            }
//            else if ([keyValueStr isEqualToString:kNameColorKey])
//            {
//                nameColorDefault = defaultValue;
//            }
//            else if ([keyValueStr isEqualToString:kBackgroundColorKey])
//            {
//                backgroundColorDefault = defaultValue;
//            }
        }
        
        // since no default values have been set (i.e. no preferences file created), create it here     
        NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                     ikmServerUrlDefault, @"IKMServerUrl",
                                     nil];
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // we're ready to go, so lastly set the key preference values
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self setupByPreferences];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
