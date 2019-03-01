//
//  Track.m
//  Ludere
//
//  Created by Odie Edo-Osagie on 24/05/2017.
//  Copyright © 2017 Odie Edo-Osagie. All rights reserved.
//

#import "Track.h"

#define API_BASE_URL "http://localhost:80/Ludere"

@implementation Track

- (id) init
{
    self = [super init];
    
    if(self){
        self.title = @"";
        self.soundcloudUrl = @"";
        self.coverUrl = @"";
    }
    
    return self;
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    _coverUrl = [NSString stringWithFormat:@"%s/PlaylistGenerationEngine/Artworks/%@.jpg", API_BASE_URL, _title];
    _coverUrl = [_coverUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
