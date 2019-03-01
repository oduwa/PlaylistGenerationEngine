//
//  OSCQuery.h
//  Syren
//
//  Created by Odie Edo-Osagie on 01/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSCManager.h"

@interface OSCQuery : NSObject

+ (NSArray *) searchForTrack:(NSString *)query;
+ (void) searchForTrackInBackground:(NSString *)query WithBlock:(void (^)(NSArray *results))completionBlock;

@end
