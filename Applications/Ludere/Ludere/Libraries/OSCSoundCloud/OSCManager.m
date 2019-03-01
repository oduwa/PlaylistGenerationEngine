//
//  OSCManager.m
//  Syren
//
//  Created by Odie Edo-Osagie on 01/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "OSCManager.h"


static OSCManager *globalInstance = nil;

@implementation OSCManager

@synthesize API_KEY;


+ (OSCManager *) sharedManager
{
    @synchronized(self)
    {
        if (!globalInstance)
            globalInstance = [[self alloc] init];
        
        return globalInstance;
    }
    
    return globalInstance;
}

- (id) init
{
    self = [super init];
    
    if(self){
        API_KEY = [[NSString alloc] init];
    }
    
    return self;
}

/* iVars */
- (void) setAPIKey: (NSString *) key
{
    API_KEY = key;
}


- (NSString *) API_KEY
{
    return API_KEY;
}


#pragma mark - Static Methods

+ (NSString *) escapeString:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    string = [string stringByReplacingOccurrencesOfString:@"#" withString:@"%23"];
    string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    string = [string stringByReplacingOccurrencesOfString:@"!" withString:@"%21"];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    string = [string stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    
    NSString *result = string;
    
    return result;
}

@end
