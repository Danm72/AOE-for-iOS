//
//  GameViewController.h
//  Age of Empires Port
//

//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"
@interface GameViewController : UIViewController{
    IBOutlet UIButton *slideButton;
    IBOutlet UIButton *buildingPrimaryBtn;
    IBOutlet UIButton *buildingSecondaryBtn;
}
@property (weak, nonatomic)  IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic)  UIButton *slideButton;
@property (weak, nonatomic)  UIButton *buildingPrimaryBtn;
@property (weak, nonatomic)  UIButton *buildingSecondaryBtn;
@property (strong, nonatomic) MyScene *scene;
- (IBAction)sideBarTouch:(id)sender;
-(void) loadScene;
@end
