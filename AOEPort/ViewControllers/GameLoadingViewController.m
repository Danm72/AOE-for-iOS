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

@interface GameLoadingViewController () <MYSceneDelegate>
//@property (nonatomic, readwrite, strong) MyScene *loadedScene;
@property BOOL preloaded;
@end

@implementation GameLoadingViewController
@synthesize progressTextView;
@synthesize scene;

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


-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _preloaded = NO;
    if(scene == nil){
        scene = [MyScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        scene.delegate1 = self;
    }else{
        _preloaded = YES;
    }
    
    //    MyScene *scene = [MyScene sceneWithSize:CGSizeMake(2000, 2000)];
    //  scene.scaleMode = SKSceneScaleModeResizeFill;
    
    [self.activityIndicator startAnimating];
    TextureContainer *tx = [TextureContainer getInstance];
    
    tx.builderBuild = [SKTextureAtlas atlasNamed:@"Builder_build"];
    tx.builderIdle= [SKTextureAtlas atlasNamed:@"builder_idle"];
    tx.builderWalk= [SKTextureAtlas atlasNamed:@"Builder_walk"];
    tx.buildings = [SKTextureAtlas atlasNamed:@"buildings"];
    tx.trees = [SKTextureAtlas atlasNamed:@"trees"];
    tx.resources = [SKTextureAtlas atlasNamed:@"resources"];
    
    [SKTextureAtlas preloadTextureAtlases:@[tx.builderBuild, tx.builderIdle, tx.builderWalk, tx.buildings, tx.trees, tx.resources] withCompletionHandler:^{
        
        NSLog(@"DONE DONE DONE");
        if(!_preloaded){
            [scene loadSceneAssetsWithCompletionHandler:^{
                //            self.loadedScene = _scene;
                [self.activityIndicator stopAnimating];
                [self performSegueWithIdentifier:@"game_has_loaded" sender:self];
                //        [skView presentScene:scene];
                //        [self saveGame:scene :@"SAVE_1"];
            }];
        }else{
            [self performSegueWithIdentifier:@"game_has_loaded" sender:self];
        }
        
    }];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"game_has_loaded"])
    {
        GameViewController *viewController = segue.destinationViewController;
        viewController.scene = scene;
    }
}

- (void)updateProgress:(NSString *)progress {
    progressTextView.text = progress;
    NSLog(@"Text View Value = %@",progressTextView.text);

//    [_progressTextView setNeedsDisplay];
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
