//
//  GameLoadingViewController.m
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "GameLoadingViewController.h"
#import "GameViewController.h"
#import "MyScene.h"
#import "Unit.h"
#import "Building.h"

@interface GameLoadingViewController ()<MYSceneDelegate>
@property (nonatomic, readwrite, strong) MyScene *loadedScene;
@end

@implementation GameLoadingViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MyScene *scene = [MyScene sceneWithSize:self.view.bounds.size];
    //    MyScene *scene = [MyScene sceneWithSize:CGSizeMake(2000, 2000)];
    //  scene.scaleMode = SKSceneScaleModeResizeFill;
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.delegate = self;
    
    [self.activityIndicator startAnimating];
    [scene loadSceneAssetsWithCompletionHandler:^{
        self.loadedScene = scene;
        [self.activityIndicator stopAnimating];
        [self performSegueWithIdentifier:@"game_has_loaded" sender:self];
        //        [skView presentScene:scene];
        //        [self saveGame:scene :@"SAVE_1"];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"game_has_loaded"])
    {
        GameViewController *viewController = segue.destinationViewController;
        viewController.scene = self.loadedScene;
    }
}

- (void)unitClicked:(Unit *)unitNode {

}

- (void)updateProgress:(NSString *)progress {
    _progressTextView.text = progress;
}


- (void)castleClicked:(Building *)castleNode {

}

- (void)leftSwipe {

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

@end
