//
//  MainMenuViewController.h
//  AOEPort
//
//  Created by Dan Malone on 19/04/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UICollectionViewController
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *titles;
@property (weak, nonatomic) IBOutlet SKView *skView;

@end
