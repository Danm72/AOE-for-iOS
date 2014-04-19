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


@interface MyScene : SKScene {
}

- (BOOL)tileAtPoint:(CGPoint)point hasAnyProps:(uint32_t)props;

- (BOOL)tileAtCoord:(CGPoint)coord hasAnyProps:(uint32_t)props;

- (void)loadSceneAssetsWithCompletionHandler:(AssetLoadCompletionHandler)callback;

-(void) loadSceneAssets;

@end
