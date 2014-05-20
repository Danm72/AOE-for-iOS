//
//  MainMenuNewViewController.h
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScene.h"

@interface MainMenuNewViewController : UIViewController
@property (weak, nonatomic) IBOutlet SKView *skView;
@property(weak, nonatomic) MyScene *loadedScene;

@end
