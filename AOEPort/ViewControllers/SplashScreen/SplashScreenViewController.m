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

@interface SplashScreenViewController ()

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
  
    if(DEBUG_MODE == NO){
        [self performSelector:@selector(goToNextView) withObject:nil afterDelay:5];

    
    }else {
        [self performSelector:@selector(goToNextView) withObject:nil afterDelay:0];
    }
    // Do any additional setup after loading the view.
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
