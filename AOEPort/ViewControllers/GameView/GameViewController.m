//
//  GameViewController.m
//  Age of Empires Port
//
//  Created by Dan Malone on 04/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "GameViewController.h"
#import "MyScene.h"
#import "SWRevealViewController.h"
#import "CastleViewController.h"
#import "Building.h"
#import "TownCenter.h"
#import "Barracks.h"
#import "Church.h"
#import "Unit.h"
#import "Builder.h"

@interface GameViewController () <MYSceneDelegate, CastleViewControllerDelegate, VillagerViewControllerDelegate>

//@property (nonatomic) IBOutlet UIImageView *gameLogo;
//@property (nonatomic) IBOutlet SKView *skView;
//@property (nonatomic) IBOutlet UIButton *enterButton;
//@property (nonatomic) IBOutlet UIButton *exitButton;
//@property (nonatomic) MyScene *scene;
@end

@implementation GameViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)sideBarTouch:(id)sender {
    [[self revealViewController] revealToggle:sender];
//    CastleViewController *vc = [[CastleViewController alloc] init];
//    [[self revealViewController] setRightViewController:vc];
//    [[self revealViewController] rightRevealToggle:sender];
}

- (void)setScene:(MyScene *)scene {
    _scene = scene;
    SKView *skView = (SKView *) self.view;
    _scene.delegate = self;
    [skView presentScene:_scene];
}

- (BOOL)saveGame:(MyScene *)scene :(NSString *)saveName {
//    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
//    NSString *secondParentPath = [[bundlePath stringByDeletingLastPathComponent] stringByDeletingLastPathComponent];

    @try {
        // Try something

        NSURL *archiveURL = [[NSBundle mainBundle] bundleURL];
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:scene forKey:saveName];
        [archiver finishEncoding];


        BOOL result = [data writeToURL:archiveURL atomically:YES];

        return result;

    }
    @catch (NSException *e) {
        NSLog(@"Exception: %@", e);
        return false;
    }
}

- (void)loadGame:(NSString *)saveName {
    NSURL *archiveURL = [[NSBundle mainBundle] bundleURL];

    NSData *data = [NSData dataWithContentsOfURL:archiveURL];

    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // Customize the unarchiver.
    MyScene *scene = [unarchiver decodeObjectForKey:saveName];
    [unarchiver finishDecoding];

    SKView *skView = (SKView *) self.view;

    self.view = skView;

    [skView presentScene:scene];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(rightRevealToggle:);
    _sidebarButton.action = @selector(revealToggle:);

    // Set the gesture
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)castleClicked:(Building *)building {

    if ([building isKindOfClass:[TownCenter class]]) {
        CastleViewController *vc = [[CastleViewController alloc] init];
        vc.delegate = self;
        [self setRightViewController:vc];
    }
    if ([building isKindOfClass:[Barracks class]]) {
        CastleViewController *vc = [[CastleViewController alloc] init];
        vc.delegate = self;
        [self setRightViewController:vc];
    }
    if ([building isKindOfClass:[Church class]]) {
        CastleViewController *vc = [[CastleViewController alloc] init];
        vc.delegate = self;
        [self setRightViewController:vc];
    }

//     SKAction *sequence = [Building selectedBuildingAction]; //RUN BUILDING SELECTED
//     [building runAction:[SKAction repeatActionForever:sequence]];

}

- (void)leftSwipe {
    [[self revealViewController] revealToggle:nil];
}

- (void)unitClicked:(Unit *)unitNode {
    if ([unitNode isKindOfClass:[Builder class]]) {
//        VillagerViewController *vc = [[VillagerViewController alloc] init];
        VillagerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"buildingTable"];

        vc.delegate = self;
        [self setRightViewController:vc];
        
        _activeNode = unitNode;
    }
}

- (void)updateProgress:(NSString *)progress {

}


- (void)setRightViewController:(UIViewController *)vc {
    [[self revealViewController] setRightViewController:vc];
    [[self revealViewController] rightRevealToggle:nil];
}

- (void)addStructure:(Building*) building {
    //[self.scene increaseNumberOfUnitesForSacte]
    NSLog(@"increase number of units");
    
    SKAction *sequence = [Building selectedBuildingAction]; //RUN BUILDING SELECTED
    [building runAction:[SKAction repeatActionForever:sequence]];
    
    building.position = _activeNode.position;
    building.zPosition = _activeNode.zPosition;
    [_scene.buildingLayer addChild:building];
    
}

- (void)test {
    NSLog(@"%s", "Button Pressed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end
