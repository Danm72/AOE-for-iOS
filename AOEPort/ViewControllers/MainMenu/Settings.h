//
//  Settings.h
//  AOEPort
//
//  Created by Dan Malone on 04/06/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *DebugModeOutlet;
- (IBAction)DebugPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *tileMapOutlet;
- (IBAction)tilemapPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;

@end
