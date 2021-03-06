//
//  GameLoadingViewController.h
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScene.h"

@interface GameLoadingViewController : UIViewController
@property (strong,nonatomic) IBOutlet UITextField *progressTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(strong, nonatomic) MyScene *scene;

@end
