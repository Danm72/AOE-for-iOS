//
//  VillagerViewController.m
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "VillagerViewController.h"
#import "Wall.h"
#import "TownCenter.h"
#import "Barracks.h"
#import "Church.h"
#import "SWRevealViewController.h"

@interface VillagerViewController ()

@end

@implementation VillagerViewController
static NSString *cellIdentifier;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
	}
	return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

     _atlas = [SKTextureAtlas atlasNamed:@"buildings"];
    SWRevealViewController *revealController = self.revealViewController;

    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
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
        
        Wall *wall = [Wall spriteNodeWithTexture:[_atlas textureNamed:@"wall"]];
        wall.placed = NO;
        [self.delegate addStructure:wall];
    }
    if (indexPath.section == 1)
    {
        
        Church *church = [Church spriteNodeWithTexture:[_atlas textureNamed:@"church"]];
        church.placed = NO;

        [self.delegate addStructure:church];
    }
    if (indexPath.section == 2)
    {
        
        TownCenter *center = [TownCenter spriteNodeWithTexture:[_atlas textureNamed:@"elitetowncenter"]];
        center.placed = NO;
        [self.delegate addStructure:center];
    }
    if (indexPath.section == 3)
    {
        
        Barracks *barracks = [Barracks spriteNodeWithTexture:[_atlas textureNamed:@"elitebarracks"]];
        barracks.placed = NO;
        [self.delegate addStructure:barracks];
    }
//		[self.nameTextField becomeFirstResponder];
}

@end
