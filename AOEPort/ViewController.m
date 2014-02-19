//
//  ViewController.m
//  Age of Empires Port
//
//  Created by Dan Malone on 04/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"

@interface ViewController()
//@property (nonatomic) IBOutlet UIActivityIndicatorView *loadingProgressIndicator;
//@property (nonatomic) IBOutlet UIImageView *gameLogo;
////@property (nonatomic) IBOutlet SKView *skView;
//@property (nonatomic) IBOutlet UIButton *enterButton;
//@property (nonatomic) IBOutlet UIButton *exitButton;
////@property (nonatomic) MyScene *scene;
@end

@implementation ViewController

//- (void) viewWillAppear:(BOOL)animated{
//    [self.loadingProgressIndicator startAnimating];
//    
//    SKView * skView = (SKView *)self.view;
//    // CGSize viewSize = self.view.bounds.size;
//    
//    MyScene *scene = [MyScene sceneWithSize:skView.bounds.size];
//    scene.scaleMode = SKSceneScaleModeResizeFill;
//
//    [scene loadSceneAssetsWithCompletionHandler:^{
//        
//        //MyScene *scene  = [[MyScene alloc] initWithSize:skView.bounds.size];
//        
//        //CGSize viewSize = self.view.bounds.size;
//        [self.loadingProgressIndicator stopAnimating];
//        [self.loadingProgressIndicator setHidden:YES];
//        [skView presentScene:scene];
//        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.enterButton.alpha = 1.0f;
//            self.exitButton.alpha = 1.0f;
//        } completion:NULL];
//        
//    }];
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
  //  scene.scaleMode = SKSceneScaleModeResizeFill;
    scene.scaleMode = SKSceneScaleModeAspectFill;

    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
//
//#pragma mark - UI Display and Actions
//- (void)hideUIElements:(BOOL)shouldHide animated:(BOOL)shouldAnimate {
//    CGFloat alpha = shouldHide ? 0.0f : 1.0f;
//    
//    if (shouldAnimate) {
//        [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.gameLogo.alpha = alpha;
//            self.enterButton.alpha = alpha;
//            self.exitButton.alpha = alpha;
//        } completion:NULL];
//    } else {
//        [self.gameLogo setAlpha:alpha];
//        [self.enterButton setAlpha:alpha];
//        [self.exitButton setAlpha:alpha];
//    }
//}
//
//- (IBAction)chooseEnter:(id)sender {
//    // [self startGameWithHeroType:APAHeroTypeArcher];
//    [self hideUIElements:YES animated:YES];
//    
//}
//
//- (IBAction)chooseExit:(id)sender {
//    //[self startGameWithHeroType:APAHeroTypeWarrior];
//}

@end
