//
//  GameViewController.h
//  Age of Empires Port
//

//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

-(void) loadScene;
@end
