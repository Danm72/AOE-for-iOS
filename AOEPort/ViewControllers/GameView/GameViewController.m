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
#import "Wall.h"
#import "SideBarMenuViewController.h"

@interface GameViewController () <MYSceneDelegate, CastleViewControllerDelegate, VillagerViewControllerDelegate, TownCenterViewControllerDelegate, TouchProtocol, SideBarProtocol>

@property (nonatomic, strong) AVQueuePlayer *player;
@property (nonatomic, strong) id timeObserver;

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
    _scene.handlers.delegate = self;
}

-(void) saveClicked{
    if( [self saveGame:_scene :@"Test"]){
        NSLog(@"Saved");
    }else{
        NSLog(@"Save Failed");
    }
}

-(void) loadClicked{
    [self loadGame:@"Test"];
}

- (NSString *) pathForDataFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder = @"~/Library";
    folder = [folder stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath:folder] == NO)
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *fileName = @"Save.taskStore";
    return [folder stringByAppendingPathComponent: fileName];
}

- (BOOL)saveGame:(MyScene *)scene :(NSString *)saveName {
//    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
//    NSString *secondParentPath = [[bundlePath stringByDeletingLastPathComponent] stringByDeletingLastPathComponent];

    @try {
        // Try something

//        NSURL *archiveURL = [[NSBundle mainBundle] bundleURL];
        NSString * path = [self pathForDataFile];
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:scene forKey:saveName];
        [archiver finishEncoding];


//        BOOL result = [data writeToURL:archiveURL atomically:YES];
        
        NSError *error;
      BOOL success = [data writeToFile:path options:0 error:&error];
        if (!success) {
            NSLog(@"writeToFile failed with error %@", error);
        }

        return success;

    }
    @catch (NSException *e) {
        NSLog(@"Exception: %@", e);
        return false;
    }
}

- (void)loadGame:(NSString *)saveName {
//    NSURL *archiveURL = [[NSBundle mainBundle] bundleURL];
    NSString *path = [self pathForDataFile];
    NSData *data = [NSData dataWithContentsOfFile:path];

    NSKeyedUnarchiver *unarchiver =
    [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // Customize the unarchiver.
    MyScene *scene = [unarchiver decodeObjectForKey:saveName];
    [unarchiver finishDecoding];

    [self setScene:scene];
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
                       [AVPlayerItem playerItemWithURL:[[NSBundle mainBundle] URLForResource:@"soundtrack1" withExtension:@"mp3"]],
                       [AVPlayerItem playerItemWithURL:[[NSBundle mainBundle] URLForResource:@"soundtrack0" withExtension:@"mp3"]],
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
    
//    UIImage *btnImage = [UIImage imageNamed:@"house"];
    UIImage* btnImage = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"house" ofType: @"png"]];

    [_sidebarButton setImage:btnImage forState:UIControlStateNormal];

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
    
//    UIImage *btnImage = [UIImage imageNamed:@"hammer"];
    UIImage* btnImage = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"hammer" ofType: @"png"]];

    [_sidebarButton setImage:btnImage forState:UIControlStateNormal];

    if ([unitNode isKindOfClass:[Builder class]]) {
//        VillagerViewController *vc = [[VillagerViewController alloc] init];
        VillagerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"buildingTable"];
        vc.delegate = self;
        [self setRightViewController:vc];

        _activeNode = unitNode;
    }
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


//    [self performSelector:@selector(lol) withObject:building afterDelay:1];

    [_scene.buildingLayer addChild:building];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)addUnit:(Builder *)villager {
    NSLog(@"Add Unit");
    CGFloat z =_activeNode.zPosition;


    villager.position = _activeNode.position;
    CGSize s =_scene.size;

    villager.position = CGPointMake(villager.position.x  + _activeNode.size.width /2, villager.position.y+20);

    villager.zPosition =_activeNode.zPosition;
    [_scene.unitLayer addChild:villager];
}


- (IBAction)settingsButton:(id)sender {
    
    SideBarMenuViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewControllerId"];
    
    vc.delegate = self;
    [[self revealViewController]  setRearViewController:vc];
    
    [[self revealViewController] revealToggle:nil];
    
}
- (IBAction)updateWood:(id)sender {
//    _woodResourceCounter+=1;
}
- (IBAction)updateStone:(id)sender {
//    _stoneResourceCounter+=1;

}

-(void) panEnded{
    NSLog(@"Pan Ended");

    _woodIcon.hidden = NO;
    _stoneIcon.hidden = NO;
    
    _stoneResourceCounter.hidden = NO;
    _woodResourceCounter.hidden = NO;
    _settingsButtonIcon.hidden = NO;

    if(_activeNode)
        _sidebarButton.hidden = NO;

}
-(void) panBegun{
    NSLog(@"Pan Begun");
    _woodIcon.hidden = YES;
    _stoneIcon.hidden = YES;
    
    _stoneResourceCounter.hidden = YES;
    _woodResourceCounter.hidden = YES;
    _settingsButtonIcon.hidden = YES;
   _sidebarButton.hidden = YES;
}

-(void) unitUnselected{
    _activeNode = nil;
    _sidebarButton.hidden = YES;
}
-(BOOL)updateResources:(NSInteger)requiredStone woodNeeded:(NSInteger) requiredWood{
    NSInteger stone = [_stoneResourceCounter.text intValue];
    NSInteger wood = [_woodResourceCounter.text intValue];
    
    if(stone - requiredStone < 0){
        return false;
    }else if (wood - requiredWood < 0){
        return false;
    }
    _stoneResourceCounter.text = [NSString stringWithFormat:@"%ld",(stone - requiredStone)] ;
    _woodResourceCounter.text = [NSString stringWithFormat:@"%ld", wood - requiredWood];

    return true;

}

@end
