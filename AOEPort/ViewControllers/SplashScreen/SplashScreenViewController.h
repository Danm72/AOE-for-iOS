//
//  SplashScreenViewController.h
//  AOEPort
//
//  Created by Dan Malone on 16/04/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashScreenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *leftSword;
@property (weak, nonatomic) IBOutlet UIImageView *rightSword;
@property (weak, nonatomic) IBOutlet UIImageView *shield;
@property (weak, nonatomic) IBOutlet UITextField *textBox;
@property (weak, nonatomic) IBOutlet SKView *skView;
@property (weak, nonatomic) IBOutlet UIImageView *explosion;
@end
