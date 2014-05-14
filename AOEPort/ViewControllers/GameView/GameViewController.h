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
- (IBAction)updateStone:(id)sender;
- (IBAction)updateWood:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *woodIcon;
@property (weak, nonatomic) IBOutlet UITextField *woodResourceCounter;
//@property (weak, nonatomic)  IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *stoneIcon;
@property (weak, nonatomic) IBOutlet UITextField *stoneResourceCounter;
@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;
- (IBAction)settingsButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *settingsButtonIcon;
@property (strong, nonatomic) MyScene *scene;
@property (strong, nonatomic) SKSpriteNode *activeNode;
@property (strong, nonatomic) UIViewController *currentSideController;
@property (weak, nonatomic) IBOutlet UITextField *lblMusicName;
@property (weak, nonatomic) IBOutlet UITextField *_lblMusicTime;
- (IBAction)sideBarTouch:(id)sender;
@end
