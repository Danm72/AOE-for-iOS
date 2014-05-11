//
//  VillagerViewController.m
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "TownCenterViewController.h"
#import "SWRevealViewController.h"
#import "Villager.h"
#import "Builder.h"


@interface TownCenterViewController ()

@end

@implementation TownCenterViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        NSLog(@"init TownCenter");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _atlas = [SKTextureAtlas atlasNamed:@"Builder_walk"];
    SWRevealViewController *revealController = self.revealViewController;

    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        Builder *villager = [Builder spriteNodeWithTexture:[_atlas textureNamed:@"builderwalking0"]];
        [self.delegate addUnit:villager];
    }

//		[self.nameTextField becomeFirstResponder];
}



@end
