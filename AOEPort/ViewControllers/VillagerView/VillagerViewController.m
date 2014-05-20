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
#import "TextureContainer.h"

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
    
//    _atlas = [SKTextureAtlas atlasNamed:@"buildings"];
    _tx = [TextureContainer getInstance];

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
        //        SKTexture *tex = [SKTexture textureWithImageNamed:@"building_site1.png"];
        
        //        Wall *wall = [Wall spriteNodeWithTexture:tex];
        NSLog(@"Wall Building");

        Wall *wall = [Wall spriteNodeWithTexture:[_tx.buildings textureNamed:@"building_site1"]];
        NSLog(@"Wall Building Loaded");

        if([self.delegate updateResources:wall.stone woodNeeded:wall.wood]){
            wall.placed = NO;
            [self.delegate addStructure:wall];
            
        }
        else {
            wall = nil;
            [self showAlert];
        }
    }
    if (indexPath.section == 1)
    {
        Church *church = [Church spriteNodeWithTexture:[_tx.buildings textureNamed:@"building_site1"]];
        
        if([self.delegate updateResources:church.stone woodNeeded:church.wood]){
            
            church.placed = NO;
            
            [self.delegate addStructure:church];
        }else {
            church = nil;
            [self showAlert];
        }
    }
    if (indexPath.section == 2)
    {
        TownCenter *center = [TownCenter spriteNodeWithTexture:[_tx.buildings textureNamed:@"building_site1"]];
        
        if([self.delegate updateResources:center.stone woodNeeded:center.wood]){
            
            center.placed = NO;
            [self.delegate addStructure:center];
        }else {
            center = nil;
            [self showAlert];
        }
    }
    if (indexPath.section == 3)
    {
        Barracks *barracks = [Barracks spriteNodeWithTexture:[_tx.buildings textureNamed:@"building_site1"]];
        
        if([self.delegate updateResources:barracks.stone woodNeeded:barracks.wood]){
            
            barracks.placed = NO;
            [self.delegate addStructure:barracks];
        }else {
            barracks = nil;
            [self showAlert];
        }
    }
    //		[self.nameTextField becomeFirstResponder];
}

- (void) showAlert {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Resources"
                          message:@"Not Enough Resources"
                          delegate:nil
                          cancelButtonTitle:@"Dismiss"
                          otherButtonTitles:nil];
    
    [alert show];
//    [alert release];
    alert = nil;
}

@end
