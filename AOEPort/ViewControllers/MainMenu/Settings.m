//
//  Settings.m
//  AOEPort
//
//  Created by Dan Malone on 04/06/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Settings.h"
#import "Constants.h"

@implementation Settings

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(DEBUG_MODE)
        [self.DebugModeOutlet setOn:YES];
    else
        [self.DebugModeOutlet setOn:NO];

}

- (IBAction)DebugPressed:(id)sender {
    bool tmp = !DEBUG_MODE;
    DEBUG_MODE = tmp;
}
- (IBAction)tilemapPressed:(id)sender {
    TILEMAP_MODE = !TILEMAP_MODE;

}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
@end
