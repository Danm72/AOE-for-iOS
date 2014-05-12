//
//  GameViewController.h
//  Age of Empires Port
//


//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"
#import "VillagerViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface GameViewController : UIViewController <UIGestureRecognizerDelegate> {
}
//@property (weak, nonatomic)  IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;
@property (strong, nonatomic) MyScene *scene;
@property (strong, nonatomic) SKNode *activeNode;
@property (strong, nonatomic) UIViewController *currentSideController;
@property (weak, nonatomic) IBOutlet UITextField *lblMusicName;
@property (weak, nonatomic) IBOutlet UITextField *_lblMusicTime;



- (IBAction)sideBarTouch:(id)sender;
@end
