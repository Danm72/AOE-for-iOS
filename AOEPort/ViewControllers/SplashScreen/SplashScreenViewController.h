//
//  SplashScreenViewController.h
//  AOEPort
//
//  Created by Dan Malone on 16/04/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashScreenViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *leftSword;
@property (strong, nonatomic) IBOutlet UIImageView *rightSword;
@property (strong, nonatomic) IBOutlet UIImageView *shield;
@property (strong, nonatomic) IBOutlet UITextField *textBox;
@property (strong, nonatomic) IBOutlet SKView *skView;
@property (strong, nonatomic) IBOutlet UIImageView *explosion;
@end
