//
//  MainMenuNewViewController.m
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "MainMenuNewViewController.h"
#import "MenuScene.h"

@interface MainMenuNewViewController ()

@end

@implementation MainMenuNewViewController
- (IBAction)newGameButtonPressed:(id)sender {
    NSLog(@"PRESSED");

    [self performSelector:@selector(goToNextView) withObject:nil afterDelay:0];
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
@end