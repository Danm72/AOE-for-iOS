//
//  MainMenuViewController.m
//  AOEPort
//
//  Created by Dan Malone on 19/04/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MainMenuTableViewCell.h"
#import "MenuScene.h"
#import "GameViewController.h"

@interface MainMenuViewController () <UICollectionViewDataSource>//, UICollectionViewDelegateFlowLayout>

@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.images = @[@"parchment.png",@"parchment.png",@"parchment.png",@"parchment.png"];
    self.titles = @[@"New Game",@"Skirmish",@"Load Game",@"Settings"];

    SKView * skView = _skView;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    // Create and configure the scene.
    SKScene * scene = [MenuScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;

    // Present the scene.
    [skView presentScene:scene];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    //    NSString *searchTerm = self.menuOpts[section];
    //    return [self.menuOptions[searchTerm] count];
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    return [self.collectionView cellForItemAtIndexPath:indexPath];
    MainMenuTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CampaignCell" forIndexPath:indexPath];
    //cell.imageView.image = [UIImage imageNamed:self.truckImages[0]];
    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
    cell.images.image = image;
    cell.textBox.text = [self.titles objectAtIndex:indexPath.row];
    [cell.textBox  setFont:[UIFont fontWithName:@"Times New Roman" size:18.0]];
    [cell.textBox  setTextColor:[UIColor blueColor]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Select Item
    if(indexPath.row == 0){
        [self performSelector:@selector(goToNextView) withObject:nil afterDelay:0];
    }
}

- (void)goToNextView {
    [self performSegueWithIdentifier:@"campaignSegue" sender:self];
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"campaignSegue"]) {

        // Get destination view
//        GameViewController *vc = [segue destinationViewController];
//        
//        // Pass the information to your destination view
//        [vc loadScene];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
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
/*- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *searchTerm = self.sear
 ches[indexPath.section]; FlickrPhoto *photo =
//            self.searchResults[searchTerm][indexPath.row];
    UIImage *image = [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
    CGSize retval = CGSizeMake(100, 100);
    retval.height += 35; retval.width += 35; return retval;
}

// 3
- (UIEdgeInsets)collectionView:
        (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 50, 50, 20);
}*/

@end
