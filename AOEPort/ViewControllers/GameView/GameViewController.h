//
//  GameViewController.h
//  Age of Empires Port
//

//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"
#import "VillagerViewController.h"

@interface GameViewController : UIViewController <UIGestureRecognizerDelegate> {
}
@property (weak, nonatomic)  IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) MyScene *scene;
- (IBAction)sideBarTouch:(id)sender;
@end
