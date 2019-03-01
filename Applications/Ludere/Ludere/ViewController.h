//
//  ViewController.h
//  Ludere
//
//  Created by Odie Edo-Osagie on 06/05/2017.
//  Copyright © 2017 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSOutlineViewDataSource, NSOutlineViewDelegate>


@property (weak) IBOutlet NSOutlineView *outlineView;

@property (nonatomic, strong) NSArray *menuItems;

@end

