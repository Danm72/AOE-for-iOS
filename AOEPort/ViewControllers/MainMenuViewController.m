//
//  MainMenuViewController.m
//  AOEPort
//
//  Created by Dan Malone on 17/04/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MainMenuChoiceTableViewCell.h"

@interface MainMenuViewController () <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) NSMutableDictionary *menuOptions;
@property(nonatomic, strong) NSMutableArray *menuOpts;
//@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuOpts = [@[] mutableCopy];
    self.menuOptions = [@{} mutableCopy];

    self.images = @[@"parchment.png",@"10375043.png"];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
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
    MainMenuChoiceTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CampaignCell" forIndexPath:indexPath];
    //cell.imageView.image = [UIImage imageNamed:self.truckImages[0]];
    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
    cell.images.image = image;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Select Item
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

@end
