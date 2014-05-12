//
//  GameViewController.m
//  Age of Empires Port
//
//  Created by Dan Malone on 04/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "GameViewController.h"
#import "SWRevealViewController.h"
#import "CastleViewController.h"
#import "Building.h"
#import "TownCenter.h"
#import "Barracks.h"
#import "Church.h"
#import "Unit.h"
#import "Builder.h"
#import "TownCenterViewController.h"
#import "BarracksViewController.h"

@interface GameViewController () <MYSceneDelegate, CastleViewControllerDelegate, VillagerViewControllerDelegate, TownCenterViewControllerDelegate>

@property (nonatomic, strong) AVQueuePlayer *player;
@property (nonatomic, strong) id timeObserver;

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
    [[self revealViewController] rightRevealToggle:sender];
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
    
    // Set AVAudioSession
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setDelegate:self];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    // Change the default output audio route
    UInt32 doChangeDefaultRoute = 1;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker,
                            sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
    
    NSArray *queue = @[
                       [AVPlayerItem playerItemWithURL:[[NSBundle mainBundle] URLForResource:@"soundtrack0" withExtension:@"mp3"]],
                       [AVPlayerItem playerItemWithURL:[[NSBundle mainBundle] URLForResource:@"soundtrack1" withExtension:@"mp3"]],
                       [AVPlayerItem playerItemWithURL:[[NSBundle mainBundle] URLForResource:@"soundtrack2" withExtension:@"mp3"]]];
    
    self.player = [[AVQueuePlayer alloc] initWithItems:queue];
    self.player.actionAtItemEnd = AVPlayerActionAtItemEndAdvance;

    [self.player addObserver:self
                  forKeyPath:@"currentItem"
                     options:NSKeyValueObservingOptionNew
                     context:nil];
    
    void (^observerBlock)(CMTime time) = ^(CMTime time) {
        NSString *timeString = [NSString stringWithFormat:@"%02.2f", (float)time.value / (float)time.timescale];
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
            self._lblMusicTime.text = timeString;
        } else {
            NSLog(@"App is backgrounded. Time is: %@", timeString);
        }
    };
    
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(10, 1000)
                                                                  queue:dispatch_get_main_queue()
                                                             usingBlock:observerBlock];
    
    
    [self.player play];

    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
//    _sidebarButton.target = self.revealViewController;
//    _sidebarButton.action = @selector(rightRevealToggle:);
//    _sidebarButton.action = @selector(revealToggle:);

    // Set the gesture
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentItem"])
    {
        AVPlayerItem *item = ((AVPlayer *)object).currentItem;
        self.lblMusicName.text = ((AVURLAsset*)item.asset).URL.pathComponents.lastObject;
        NSLog(@"New music name: %@", self.lblMusicName.text);
    }
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

- (void)buildingClicked:(Building *)building {
    _sidebarButton.hidden = false;

    if ([building isKindOfClass:[TownCenter class]]) {
        TownCenterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"townCenterTable"];

        vc.delegate = self;
        [self setRightViewController:vc];
    }
    if ([building isKindOfClass:[Barracks class]]) {
        BarracksViewController *vc  = [self.storyboard instantiateViewControllerWithIdentifier:@"barracksTable"];

        vc.delegate = self;
        [self setRightViewController:vc];
    }
    if ([building isKindOfClass:[Church class]]) {
        CastleViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"castleTable"];
        vc.delegate = self;
        [self setRightViewController:vc];
    }

    _activeNode = building;

//     SKAction *sequence = [Building selectedBuildingAction]; //RUN BUILDING SELECTED
//     [building runAction:[SKAction repeatActionForever:sequence]];

}

- (void)leftSwipe {
    [[self revealViewController] revealToggle:nil];
}

- (void)rightSwipe {
    [[self revealViewController] rightRevealToggle:nil];
}

- (void)unitClicked:(Unit *)unitNode {
    _sidebarButton.hidden = false;

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
//    [[self revealViewController] rightRevealToggle:nil];
    _currentSideController = vc;
}

- (void)addStructure:(Building *)building {
    //[self.scene increaseNumberOfUnitesForSacte]
    NSLog(@"increase number of units");

    SKAction *sequence = [Building selectedBuildingAction]; //RUN BUILDING SELECTED
    [building runAction:[SKAction repeatActionForever:sequence]];

    building.position = _activeNode.position;
    building.zPosition = _activeNode.zPosition;
    [_scene.buildingLayer addChild:building];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)addUnit:(Builder *)villager {
    NSLog(@"Add Unit");
    villager.position = _activeNode.position;
    villager.position = CGPointMake(villager.position.x + 100, villager.position.y+20);
    villager.zPosition = _scene.size.height - villager.position.y;
    [_scene.unitLayer addChild:villager];
}


@end
