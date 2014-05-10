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

@interface VillagerViewController ()

@end

@implementation VillagerViewController
static NSString *cellIdentifier;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		NSLog(@"init villager");
	}
	return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
//    cellIdentifier = @"rowCell";
//    [self.tab registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
//    self.data = @[@"Apple",@"Banana",@"Peach",@"Grape",@"Strawberry",@"Watermelon"];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"Sidebar loaded");
     _atlas = [SKTextureAtlas atlasNamed:@"buildings"];

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
        [self.delegate addStructure:wall];
    }
    if (indexPath.section == 1)
    {
        
        Church *church = [Church spriteNodeWithTexture:[_atlas textureNamed:@"church"]];
        [self.delegate addStructure:church];
    }
    if (indexPath.section == 2)
    {
        
        TownCenter *center = [TownCenter spriteNodeWithTexture:[_atlas textureNamed:@"elitetowncenter"]];
        [self.delegate addStructure:center];
    }
    if (indexPath.section == 3)
    {
        
        Barracks *barracks = [Barracks spriteNodeWithTexture:[_atlas textureNamed:@"elitebarracks"]];
        [self.delegate addStructure:barracks];
    }
//		[self.nameTextField becomeFirstResponder];
}



//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [self.data count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
//    return cell;
//}

@end
