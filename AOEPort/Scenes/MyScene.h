//
//  MyScene.h
//  Age of Empires Port
//
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TileMapLayer.h"

//#import "Player.h"
//#import "Bug.h"
//#import "Breakable.h"
//#import "FireBug.h"
#import "TmxTileMapLayer.h"
#import "TouchHandlers.h"

#define kNumPlayers 4
typedef void (^AssetLoadCompletionHandler)(void);


@protocol MYSceneDelegate <NSObject>
-(void)castleClicked;
@end

@interface MyScene : SKScene {
}
@property (nonatomic, weak) id <MYSceneDelegate> delegate;
- (void)loadSceneAssetsWithCompletionHandler:(AssetLoadCompletionHandler)callback;

-(void) loadSceneAssets;

@end
