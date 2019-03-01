//
//  ViewController.m
//  Ludere
//
//  Created by Odie Edo-Osagie on 06/05/2017.
//  Copyright © 2017 Odie Edo-Osagie. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.menuItems = @[@"Discover", @"Journey", @"Playlists"];
    
    self.outlineView.dataSource = self;
    self.outlineView.delegate = self;
    [_outlineView reloadData];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


#pragma mark - NSOutlineView Datasource

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    return [self.menuItems count];
}


- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    return NO;
}


- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    return self.menuItems[index];
}

- (NSView *)outlineView:(NSOutlineView *)outlineView
     viewForTableColumn:(NSTableColumn *)tableColumn
                   item:(id)item
{
    NSTableCellView *cell = [_outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    cell.textField.stringValue = item;
    
    /*
    if([item isEqualToString:@"News"]){
        cell.imageView.image = [self tintImage:[NSColor whiteColor] withImage:[NSImage imageNamed:icons[0]]];
    }
    else if([item isEqualToString:@"Videos"]){
        cell.imageView.image = [self tintImage:[NSColor whiteColor] withImage:[NSImage imageNamed:icons[1]]];
    }
    else if([item isEqualToString:@"Database"]){
        cell.imageView.image = [self tintImage:[NSColor whiteColor] withImage:[NSImage imageNamed:icons[2]]];
    }
    else if([item isEqualToString:@"Manga Reader"]){
        cell.imageView.image = [self tintImage:[NSColor whiteColor] withImage:[NSImage imageNamed:icons[2]]];
    }
     */
    
    
    return cell;
}

@end
