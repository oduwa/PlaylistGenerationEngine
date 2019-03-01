//
//  OSCUser.m
//  Syren
//
//  Created by Odie Edo-Osagie on 01/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "OSCUser.h"

@implementation OSCUser

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@: %@", [super description], _username];
}

@end
