//
//  MainMenuNewViewController.m
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "MainMenuNewViewController.h"
#import "MenuScene.h"
#import "MyScene.h"
#import "GameLoadingViewController.h"
#import "Constants.h"
#import "SWRevealViewController.h"
#import "Settings.h"

@interface MainMenuNewViewController ()

@end

@implementation MainMenuNewViewController
- (IBAction)newGameButtonPressed:(id)sender {
    NSLog(@"PRESSED");
    

    [self performSelector:@selector(goToNextView) withObject:nil afterDelay:0];
}
- (IBAction)loadGameButtonPressed:(id)sender {
    [self loadGame:@"Test"];
    
    [self performSelector:@selector(goToNextView) withObject:nil afterDelay:0];
}
- (IBAction)settingsButtonPressed:(id)sender {
    [self performSelector:@selector(goToNextViewSettings) withObject:nil afterDelay:0];
    
    Settings *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:vc animated:NO];
//    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.images = @[@"parchment.png",@"parchment.png",@"parchment.png",@"parchment.png"];
//    self.titles = @[@"New Game",@"Skirmish",@"Load Game",@"Settings"];
    
    SKView * skView = _skView;
    if(DEBUG_MODE){
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
    }
    
    // Create and configure the scene.
    SKScene * scene = [MenuScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)goToNextView {
    [self performSegueWithIdentifier:@"campaignSegue" sender:self];
}

- (void)goToNextViewSettings {
    [self performSegueWithIdentifier:@"settingsSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"campaignSegue"] && _loadedScene != nil)
    {
        SWRevealViewController *controller = segue.destinationViewController;
        GameLoadingViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"gameLoadController"];

        [controller setFrontViewController:viewController];
//        [controller frontViewController]
        viewController.scene = _loadedScene;


    }else if([segue.identifier isEqualToString:@"campaignSegue"])
    {
//        GameLoadingViewController *viewController = segue.destinationViewController;
    }
}

- (void)loadGame:(NSString *)saveName {
    //    NSURL *archiveURL = [[NSBundle mainBundle] bundleURL];
    NSString *path = [self pathForDataFile];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSKeyedUnarchiver *unarchiver =
    [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // Customize the unarchiver.
    NSObject *obj =[unarchiver decodeObjectForKey:saveName];
    
    MyScene *scene = (MyScene*)obj;
    [unarchiver finishDecoding];
    
    _loadedScene = scene;
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
    
    NSString *fileName = @"SaveME.savedState";
    return [folder stringByAppendingPathComponent: fileName];
}

@end
