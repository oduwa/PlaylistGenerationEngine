//
//  OSCUser.h
//  Syren
//
//  Created by Odie Edo-Osagie on 01/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSCUser : NSObject

/**
 * Unique identifier for this user on soundcloud
 */
@property (nonatomic, strong) NSString *soundcloudID;


/**
 * When appended to the "http://soundcloud.com" url, forms the static hyperlink for the user
 */
@property (nonatomic, strong) NSString *permalink;


/**
 * Unchanging static hyperlink for the user page
 */
@property (nonatomic, strong) NSString *permalinkUrl;


/**
 * Soundcloud user's username
 */
@property (nonatomic, strong) NSString *username;


/**
 * The date at which the user details were last modified in the format "yyyy/MM/dd HH:mm:ss Z". An example is 2014/09/16 18:25:45 +0000
 */
@property (nonatomic, strong) NSString *lastModified;


/**
 * URI for getting user information from the official SoundCloud API
 */
@property (nonatomic, strong) NSString *uri;


/**
 * Url to a jpeg image for the user's avatar
 */
@property (nonatomic, strong) NSString *avatarUrl;


@end
