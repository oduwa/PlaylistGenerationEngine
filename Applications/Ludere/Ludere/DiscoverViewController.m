//
//  DiscoverViewController.m
//  Ludere
//
//  Created by Odie Edo-Osagie on 06/05/2017.
//  Copyright © 2017 Odie Edo-Osagie. All rights reserved.
//

#import "DiscoverViewController.h"
#import "AFNetworking.h"
#import "NSView+DisableSubviews.h"
#import "NSImageView+WebCache.h"
#import "OSCQuery.h"


@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.discoveredSongs = [NSMutableArray new];
    [self configureCollectionViewWithGridLayout:YES];
}

# pragma mark - Actions

- (IBAction)didPressFileSelectionButton:(id)sender
{
    [self openFilePickerDialog];
}

# pragma mark - Collection View

- (void) configureCollectionViewWithGridLayout:(BOOL)usesGridLayout
{
    if(usesGridLayout){
        NSCollectionViewGridLayout *gridLayout = [[NSCollectionViewGridLayout alloc] init];
        gridLayout.minimumItemSize = NSMakeSize(400, 400);
        gridLayout.maximumNumberOfColumns = 3;
        gridLayout.minimumInteritemSpacing = 20.0;
        gridLayout.minimumLineSpacing = 20.0;
        self.collectionView.collectionViewLayout = gridLayout;
    }
    else{
        NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = NSMakeSize(150, 150);
        flowLayout.sectionInset = NSEdgeInsetsMake(10, 20, 10, 20);
        flowLayout.minimumInteritemSpacing = 20.0;
        flowLayout.minimumLineSpacing = 20.0;
        self.collectionView.collectionViewLayout = flowLayout;
    }
    
    self.view.wantsLayer = YES;
    

    self.collectionView.layer.backgroundColor = [NSColor clearColor].CGColor;
    self.collectionView.selectable = YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [self.discoveredSongs count];
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView
     itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    // Recycle or create an item.
    DiscoveryCollectionViewItem* item = (DiscoveryCollectionViewItem*) [self.collectionView makeItemWithIdentifier:@"DiscoveryCollectionViewItem"
                                                                forIndexPath:indexPath];
    
    Track *track = self.discoveredSongs[indexPath.item];
    item.textField.stringValue = track.title;
    [item.imageView setImageURL:[NSURL URLWithString:track.coverUrl]];
    
    return item;
}

- (void)collectionView:(NSCollectionView *)collectionView
didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths
{
    NSIndexPath *indexPath = [indexPaths allObjects][0];
    Track *track = self.discoveredSongs[indexPath.item];
    [self fetchDataForTrack:track];
}

# pragma mark - Helpers

- (void) startActivityIndicator
{
    [self.activityIndicator startAnimation:self];
    [self.view disableSubviews:YES];
}

- (void) stopActivityIndicator
{
    [self.activityIndicator stopAnimation:self];
    [self.view disableSubviews:NO];
}

- (void) openFilePickerDialog
{
    /* Create file picker dialog */
    NSOpenPanel* fileDialog = [NSOpenPanel openPanel];
    fileDialog.canChooseFiles = YES;
    fileDialog.canChooseDirectories = NO;
    fileDialog.allowsMultipleSelection = NO;
    
    /* Launch dialog */
    if([fileDialog runModal] == NSModalResponseOK){
        [self startActivityIndicator];
        
        /* Get selected file */
        NSURL *selectedFilename = [fileDialog URLs][0];
        self.fileTextField.stringValue = [selectedFilename path];
        
        /* Upload file */
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSURL *filePath = [fileDialog URLs][0];
        [manager POST:@"http://localhost:80/Ludere/upload.php?browser=false" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileURL:filePath name:@"audio" error:nil];
        } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseString);
            
            /* Serialize response to JSON */
            NSError *error;
            NSArray *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
            if(!error){
                NSLog(@"JSON Dict: %@", jsonDict);
                self.discoveredSongs = [NSMutableArray new];
                for(NSDictionary *similar in jsonDict){
                    Track *t = [[Track alloc] init];
                    t.title = similar[@"title"];
                    t.soundcloudUrl = similar[@"url"];
                    [self.discoveredSongs addObject:t];
                }
                /*
                NSArray<NSImageView *> *imageViews = @[_imageView1, _imageView2, _imageView3];
                for(int i = 0; i < 3; i++){
                    NSDictionary *similar = jsonDict[i];
                    NSString *imageUrl = [NSString stringWithFormat:@"http://localhost:80/Ludere/PlaylistGenerationEngine/Artworks/%@.jpg",
                                            similar[@"title"]];
                    imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSImage *img = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                    imageViews[i].image = img;
                }
                 */
                [self stopActivityIndicator];
                [self.collectionView reloadData];
            }
            else{
               NSLog(@"FAILED WITH ERROR %@", [error userInfo]);
               [self stopActivityIndicator];
            }
            
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            
            NSLog(@"FAILED WITH ERROR %@", [error userInfo]);
            [self stopActivityIndicator];
            
        }];
        
        
    }
}

- (void) fetchDataForTrack:(Track *)track
{
    [self startActivityIndicator];
    [OSCQuery searchForTrackInBackground:track.title WithBlock:^(NSArray *results) {
        /* Stop activity indicator */
        [self stopActivityIndicator];
        
        OSCTrack *f = (OSCTrack *)results[0];
        
        self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:f.streamUrl]];
        self.player = [[AVPlayer alloc] initWithPlayerItem:_playerItem];
        [self.player play];
        
        /* Send notification to the host controller of the popup to stop activity indicator */
        //[[NSNotificationCenter defaultCenter] postNotificationName:kStopTapeCreatorActivityIndicatorNotification object:nil];
    }];
}

@end
