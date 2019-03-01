//
//  AppDelegate.m
//  Ludere
//
//  Created by Odie Edo-Osagie on 06/05/2017.
//  Copyright © 2017 Odie Edo-Osagie. All rights reserved.
//

#import "AppDelegate.h"
#import "OSCManager.h"
#import "AppUtils.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    // Initialize OSCManager for SoundCloud API
    [[OSCManager sharedManager] setAPI_KEY:SOUNDCLOUD_API_KEY];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
