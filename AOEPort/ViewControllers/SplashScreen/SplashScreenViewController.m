//
//  SplashScreenViewController.m
//  AOEPort
//
//  Created by Dan Malone on 16/04/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "Constants.h"
#import "GameViewController.h"
#import "SplashScene.h"
@import AVFoundation;

@interface SplashScreenViewController ()
@property SystemSoundID pewPewSound;

@end

@implementation SplashScreenViewController

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
    
    SKView * skView = _skView;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [SplashScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
  
    if(DEBUG_MODE == NO){
        [self moveImage:_leftSword duration:1
                  curve:UIViewAnimationCurveLinear x:0 y:self.view.center.y*2];
        [self performSelector:@selector(moveRightSword) withObject:nil afterDelay:.5];
        [self playSound];
        [self performSelector:@selector(attachExplosionAnimation) withObject:nil afterDelay:1];
        [self performSelector:@selector(attachExplosionAnimation) withObject:nil afterDelay:1.2];
        [self performSelector:@selector(attachExplosionAnimation) withObject:nil afterDelay:1.5];
        [self performSelector:@selector(goToNextView) withObject:nil afterDelay:10];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                       ^{
                           [self animateLabelShowText:@"Dan Malone Studios" characterDelay:0.1];
                       });
    }else {
        [self performSelector:@selector(goToNextView) withObject:nil afterDelay:0];


    }
    // Do any additional setup after loading the view.
}

-(void) playSound {
    NSString *pewPewPath = [[NSBundle mainBundle]
                            pathForResource:@"pew" ofType:@"wav"];
    NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &_pewPewSound);
    AudioServicesPlaySystemSound(_pewPewSound);
}

- (void) attachExplosionAnimation {
    _explosion =self.explosion;
}

- (UIImageView *) explosion{
    //Position the explosion image view somewhere in the middle of your current view. In my case, I want it to take the whole view.Try to make the png to mach the view size, don't stretch it
//    _explosion = [[UIImageView alloc] initWithFrame:_explosion.bounds];
    UIImage* poof1 = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"poof_01" ofType: @"png"]];
    UIImage* poof2 = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"poof_02" ofType: @"png"]];
    UIImage* poof3 = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"poof_03" ofType: @"png"]];
    UIImage* poof4 = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"poof_04" ofType: @"png"]];
    UIImage* poof5 = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"poof_05" ofType: @"png"]];

    //Add images which will be used for the animation using an array. Here I have created an array on the fly
//    _explosion.animationImages =  @[[UIImage imageNamed:@"poof_01.png"], [UIImage imageNamed:@"poof_02.png"],[UIImage imageNamed:@"poof_03.png"], [UIImage imageNamed:@"poof_04.png"],[UIImage imageNamed:@"poof_05.png"]];
    _explosion.animationImages =  @[poof1, poof2,poof3, poof4,poof5];

    //Set the duration of the entire animation
    _explosion.animationDuration = .75;
    
    //Set the repeat count. If you don't set that value, by default will be a loop (infinite)
    _explosion.animationRepeatCount = 1;
    
    //Start the animationrepeatcount
    [_explosion startAnimating];
    
    return _explosion;
}

- (void)animateLabelShowText:(NSString*)newText characterDelay:(NSTimeInterval)delay
{
    [self.textBox setText:@""];
    
    for (int i=0; i<newText.length; i++)
    {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self.textBox setText:[NSString stringWithFormat:@"%@%C", self.textBox.text, [newText characterAtIndex:i]]];
                       });
        
        [NSThread sleepForTimeInterval:delay];
    }
}

-(void) moveLeftSword{
    

    [self moveImage:_leftSword duration:0.1
              curve:UIViewAnimationCurveLinear x:0 y:_leftSword.center.y+10];
    [self moveImage:_leftSword duration:0.1
              curve:UIViewAnimationCurveLinear x:0 y:_leftSword.center.y-10];
    
}

-(void) moveRightSword{
    [self moveImage:_rightSword duration:1.
              curve:UIViewAnimationCurveLinear x:0 y:self.view.center.y*3];
}
- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration
            curve:(int)curve x:(CGFloat)x y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
    
}

- (void)goToNextView {
    [self performSegueWithIdentifier:@"menuSegue" sender:self];
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

@end
