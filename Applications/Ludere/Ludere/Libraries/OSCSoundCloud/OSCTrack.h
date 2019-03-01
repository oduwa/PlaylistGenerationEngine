//
//  OSCTrack.h
//  Syren
//
//  Created by Odie Edo-Osagie on 01/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSCUser.h"

@interface OSCTrack : NSObject

/**
 * Unique identifier for this user on soundcloud
 */
@property (nonatomic, strong) NSString *soundcloudId;


/**
 * timestamp of creation in the format "yyyy/MM/dd HH:mm:ss Z". An example is 2014/09/16 18:25:45 +0000
 */
@property (nonatomic, strong) NSString *createdAt;


/**
 * duration of track in milliseconds
 */
@property (nonatomic, strong) NSString *duration;


/**
 * SoundCloud user who uploaded track
 */
@property (nonatomic, strong) OSCUser *user;


/**
 * boolean identifying whether it is possible to comment on track
 */
@property (nonatomic, assign) BOOL isCommentable;


/**
 * Encoding state eg "finished"
 */
@property (nonatomic, strong) NSString *state;


/**
 * size in bytes of the original file
 */
@property (nonatomic, strong) NSString *originalContentSize;


/**
 * The date at which the track details were last modified in the format "yyyy/MM/dd HH:mm:ss Z". An example is 2014/09/16 18:25:45 +0000
 */
@property (nonatomic, strong) NSString *lastModified;


/**
 * denotes whether public/private sharing Eg. "public" or "private"
 */
@property (nonatomic, strong) NSString *sharing;


/**
 * contains a list of tags for the track seperated by spaces. Multiword tags are quoted in doublequotes.
 */
@property (nonatomic, strong) NSArray *tagList;


/**
 * When appended to the "http://soundcloud.com" url, forms the static hyperlink for the track
 */
@property (nonatomic, strong) NSString *permalink;


/**
 * denotes whether streamable via API
 */
@property (nonatomic, assign) BOOL isStreamable;


/**
 * who can embed this track or playlist. One of "all", "me", or "none"
 */
@property (nonatomic, strong) NSString *embeddableBy;


/**
 * denotes whether track is downloadable
 */
@property (nonatomic, assign) BOOL isDownloadable;


/**
 * external purchase link
 */
@property (nonatomic, strong) NSString *purchaseURL;


/**
 * SoundCloud id of the label user
 */
@property (nonatomic, strong) NSString *labelId;


/**
 * track title
 */
@property (nonatomic, strong) NSString *title;


/**
 * HTML description of track
 */
@property (nonatomic, strong) NSString *trackDescription;


/**
 * name of label
 */
@property (nonatomic, strong) NSString *labelName;


/**
 * release number of track
 */
@property (nonatomic, strong) NSString *trackRelease;


/**
 * Type of track.<br />
 Possible values:<br /><br />
 “original”<br />
 “remix”<br />
 “live”<br />
 “recording”<br />
 “spoken”<br />
 “podcast”<br />
 “demo”<br />
 “in progress”<br />
 “stem”<br />
 “loop”<br />
 “sound effect”<br />
 “sample”<br />
 “other”<br />
 */
@property (nonatomic, strong) NSString *trackType;


/**
 * musical key of track eg. "Cmaj"
 */
@property (nonatomic, strong) NSString *keySignature;


/**
 * track ISRC eg. "I123-545454"
 */
@property (nonatomic, strong) NSString *isrc;



/**
 * a link to a video page
 */
@property (nonatomic, strong) NSString *videoUrl;


/**
 * beats per minute of track
 */
@property (nonatomic, strong) NSString *bpm;


/**
 *
 */
@property (nonatomic, strong) NSString *purchaseTitle;


/**
 * Musical genre of track
 */
@property (nonatomic, strong) NSString *genre;


/**
 * month of the release of track eg. 4
 */
@property (nonatomic, strong) NSString *releaseMonth;


/**
 * day of the release of track eg. 21
 */
@property (nonatomic, strong) NSString *releaseDay;


/**
 * year of the release of track eg. 2001
 */
@property (nonatomic, strong) NSString *releaseYear;


/**
 * file format of the original file
 */
@property (nonatomic, strong) NSString *originalFormat;


/**
 * creative common license. <br />
 Possible values:<br />
 “no-rights-reserved”<br />
 “all-rights-reserved”<br />
 “cc-by”<br />
 “cc-by-nc”<br />
 “cc-by-nd”<br />
 “cc-by-sa”<br />
 “cc-by-nc-nd”<br />
 “cc-by-nc-sa”<br />
 */
@property (nonatomic, strong) NSString *license;


/**
 * URI for getting user information from the official SoundCloud API
 */
@property (nonatomic, strong) NSString *uri;


/**
 *
 */
@property (nonatomic, strong) NSString *permalinkUrl;


/**
 * URL to a JPEG image for the artwork of the track.
 JPEG, PNG and GIF are accepted when uploading and will be encoded to multiple JPEGs in these formats:<br /><br />
 t500x500: 500×500<br />
 crop: 400×400<br />
 t300x300: 300×300<br />
 large: 100×100 (default)<br />
 t67x67: 67×67 (only on artworks)<br />
 badge: 47×47<br />
 small: 32×32<br />
 tiny: 20×20 (on artworks)<br />
 tiny: 18×18 (on avatars)<br />
 mini: 16×16<br /><br />
 The URL is pointing to the format large by default. If you want to use a different format you have to replace large with the specific format name in the image URL:<br />
 For example:<br />
 http://i1.sndcdn.com/avatars-000000011308-xq0whu-large.jpg?b17c165<br />
 to<br />
 http://i1.sndcdn.com/avatars-000000011308-xq0whu-crop.jpg?b17c165
 */
@property (nonatomic, strong) NSString *artworkUrl;


/**
 * URL to PNG waveform image. eg. "http://w1.sndcdn.com/fxguEjG4ax6B_m.png"
 */
@property (nonatomic, strong) NSString *waveformUrl;


/**
 * link to 128kbs mp3 stream
 */
@property (nonatomic, strong) NSString *streamUrl;


/**
 * URL to original file
 */
@property (nonatomic, strong) NSString *downloadUrl;


/**
 * track playback count
 */
@property (nonatomic, strong) NSString *playCount;


/**
 * track download count
 */
@property (nonatomic, strong) NSString *downloadCount;


/**
 * track favouritings count
 */
@property (nonatomic, strong) NSString *favouritingsCount;


/**
 * track comment count
 */
@property (nonatomic, strong) NSString *commentCount;


/**
 *
 */
@property (nonatomic, strong) NSString *attachmentsUri;


/**
 *
 */
@property (nonatomic, strong) NSString *policy;

@end
