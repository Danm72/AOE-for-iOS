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

@interface GameViewController ()
//@property (nonatomic) IBOutlet UIActivityIndicatorView *loadingProgressIndicator;
//@property (nonatomic) IBOutlet UIImageView *gameLogo;
//@property (nonatomic) IBOutlet SKView *skView;
//@property (nonatomic) IBOutlet UIButton *enterButton;
//@property (nonatomic) IBOutlet UIButton *exitButton;
//@property (nonatomic) MyScene *scene;
@end

@implementation GameViewController

/*- (void) viewWillAppear:(BOOL)animated{
    [self.loadingProgressIndicator startAnimating];

    SKView * skView = (SKView *)self.view;
    // CGSize viewSize = self.view.bounds.size;

    MyScene *scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeResizeFill;

    [scene loadSceneAssetsWithCompletionHandler:^{

        //MyScene *scene  = [[MyScene alloc] initWithSize:skView.bounds.size];

        //CGSize viewSize = self.view.bounds.size;
        [self.loadingProgressIndicator stopAnimating];
        [self.loadingProgressIndicator setHidden:YES];
        [skView presentScene:scene];
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.enterButton.alpha = 1.0f;
            self.exitButton.alpha = 1.0f;
        } completion:NULL];

    }];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
}*/

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);

    // Set the gesture
    [self.navigationController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    // Configure the view.
//    SKView *skView = [[SKView alloc] init];
    SKView *skView = (SKView *) self.view;

    self.view = skView;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    // Create and configure the scene.
//    MyScene *scene = [MyScene sceneWithSize:skView.bounds.size];
    MyScene *scene = [MyScene sceneWithSize:CGSizeMake(2000, 2000)];

    //  scene.scaleMode = SKSceneScaleModeResizeFill;
    scene.scaleMode = SKSceneScaleModeAspectFill;

    [scene loadSceneAssetsWithCompletionHandler:^{
        NSLog(@"Done Loading");
        [skView presentScene:scene];
    }];

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

- (void)test {
    NSLog(@"%s", "Button Pressed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
/*
#pragma mark - UI Display and Actions
- (void)hideUIElements:(BOOL)shouldHide animated:(BOOL)shouldAnimate {
    CGFloat alpha = shouldHide ? 0.0f : 1.0f;

    if (shouldAnimate) {
        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.gameLogo.alpha = alpha;
            self.enterButton.alpha = alpha;
            self.exitButton.alpha = alpha;
        } completion:NULL];
    } else {
        [self.gameLogo setAlpha:alpha];
        [self.enterButton setAlpha:alpha];
        [self.exitButton setAlpha:alpha];
    }
}

- (IBAction)chooseEnter:(id)sender {
    // [self startGameWithHeroType:APAHeroTypeArcher];
    [self hideUIElements:YES animated:YES];

}

- (IBAction)chooseExit:(id)sender {
    //[self startGameWithHeroType:APAHeroTypeWarrior];
}*/

@end
