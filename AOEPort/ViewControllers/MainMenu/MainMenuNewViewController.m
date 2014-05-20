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

@interface MainMenuNewViewController ()

@end

@implementation MainMenuNewViewController
- (IBAction)newGameButtonPressed:(id)sender {
    NSLog(@"PRESSED");

    [self performSelector:@selector(goToNextView) withObject:nil afterDelay:0];
}
- (IBAction)loadGameButtonPressed:(id)sender {
    [self loadGame:@"Test"];
}
- (IBAction)settingsButtonPressed:(id)sender {
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
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"campaignSegue"] && _loadedScene != nil)
    {
        GameLoadingViewController *viewController = segue.destinationViewController;
        viewController.scene = self.loadedScene;
    }
}

- (void)loadGame:(NSString *)saveName {
    //    NSURL *archiveURL = [[NSBundle mainBundle] bundleURL];
    NSString *path = [self pathForDataFile];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSKeyedUnarchiver *unarchiver =
    [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // Customize the unarchiver.
    _loadedScene = [unarchiver decodeObjectForKey:saveName];
    [unarchiver finishDecoding];
    
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
@end
