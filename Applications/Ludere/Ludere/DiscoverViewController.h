//
//  DiscoverViewController.h
//  Ludere
//
//  Created by Odie Edo-Osagie on 06/05/2017.
//  Copyright © 2017 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Track.h"
#import "DiscoveryCollectionViewItem.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <AVFoundation/AVAsset.h>

@interface DiscoverViewController : NSViewController <NSCollectionViewDataSource, NSCollectionViewDelegate>

@property (weak) IBOutlet NSTextField *fileTextField;
@property (weak) IBOutlet NSButton *fileSelectionButton;
@property (weak) IBOutlet NSProgressIndicator *activityIndicator;
@property (weak) IBOutlet NSCollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray<Track*> *discoveredSongs;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVAudioPlayer *avAudioPlayer;

@end
