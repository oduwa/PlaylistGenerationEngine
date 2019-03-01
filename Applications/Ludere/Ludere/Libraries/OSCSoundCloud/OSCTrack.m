//
//  OSCTrack.m
//  Syren
//
//  Created by Odie Edo-Osagie on 01/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "OSCTrack.h"
#import "OSCManager.h"

@implementation OSCTrack

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@: %@", [super description], _title];
}

- (NSString *) streamUrl
{
    return [NSString stringWithFormat:@"http://api.soundcloud.com/tracks/%@/stream.json?client_id=%@", [self soundcloudId], [OSCManager sharedManager].API_KEY];
}

@end
