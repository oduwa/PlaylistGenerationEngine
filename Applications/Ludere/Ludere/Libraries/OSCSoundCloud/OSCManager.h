//
//  OSCManager.h
//  Syren
//
//  Created by Odie Edo-Osagie on 01/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSCTrack.h"

@interface OSCManager : NSObject

@property (nonatomic, strong) NSString *API_KEY;


+ (OSCManager *) sharedManager;
+ (NSString *) escapeString:(NSString *)string;
- (void) setAPIKey: (NSString *) key;
- (NSString *) API_KEY;

@end
