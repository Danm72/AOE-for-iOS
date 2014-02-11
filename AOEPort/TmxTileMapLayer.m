//
//  TmxTileMapLayer.m
//  PestControl
//
//  Created by Main Account on 9/17/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "TmxTileMapLayer.h"
#import "MyScene.h"
//#import "Model/Building.h"
//#import "Breakable.h"
//#import "Player.h"
//#import "Bug.h"

@implementation TmxTileMapLayer {
  TMXLayer *_layer;
  CGSize _tmxTileSize;
  CGSize _tmxGridSize;
  CGSize _tmxLayerSize;
}

- (instancetype)initWithTmxLayer:(TMXLayer *)layer
{
  if (self = [super init]) {
    _layer = layer;
    _tmxTileSize = layer.mapTileSize;
    _tmxGridSize = layer.layerInfo.layerGridSize;
    _tmxLayerSize = CGSizeMake(layer.layerWidth, 
                               layer.layerHeight);
   [self createNodesFromLayer:layer];
  }
  return self;
}

- (CGSize)gridSize {
  return _tmxGridSize;
}

- (CGSize)tileSize {
  return _tmxTileSize;
}

- (CGSize)layerSize {
  return _tmxLayerSize;
}

- (void)createNodesFromLayer:(TMXLayer *)layer
{
  SKTextureAtlas *atlas =
    [SKTextureAtlas atlasNamed:@"tiles32"];
  
  JSTileMap *map = layer.map;
    
    
  //1
//  for (int w = 0 ; w < self.gridSize.width; ++w) {
//    for(int h = 0; h < self.gridSize.height; ++h) {
    for (int w = 0 ; w < 100; ++w) {
        for(int h = 0; h < 100; ++h) {


      CGPoint coord = CGPointMake(w, h);
      //2
      NSInteger tileGid = 
        [layer.layerInfo tileGidAtCoord:coord];
      if(!tileGid)
        continue;
      //3
//        if([map propertiesForGid:tileGid][@"g_fm2_00_COLOR"]) {
//            SKSpriteNode *tile = [layer tileAtCoord:coord];
//            [self addChild:tile];
//
//        }
        
    
        
      if([map propertiesForGid:tileGid][@"wall"]) {
                  //4
//        SKSpriteNode *tile = [layer tileAtCoord:coord];
//        
//        tile.physicsBody =
//        [SKPhysicsBody bodyWithRectangleOfSize:tile.size];
//        tile.physicsBody.categoryBitMask = PCWallCategory;
//        tile.physicsBody.dynamic = NO;
//        tile.physicsBody.friction = 0;
      } else if([map propertiesForGid:tileGid][@"tree"]) {
//        SKNode *tile =
//         [[Breakable alloc]
//          initWithWhole:[atlas textureNamed:@"tree"]
//                 broken:[atlas textureNamed:@"tree-stump"]];
//         tile.position = [self pointForCoord:coord];
//         [self addChild:tile];
//         [layer removeTileAtCoord:coord];
      }
    }
  }
}

- (SKNode*)tileAtPoint:(CGPoint)point
{
  SKNode *tile = [super tileAtPoint:point];
  return tile ? tile : [_layer tileAt:point];
}

- (void)createNodesFromGroup:(TMXObjectGroup *)group
{
//  NSDictionary *playerObj = [group objectNamed:@"player"];
   NSDictionary *buildingObj = [group objectNamed:@"Archery"];

  if (buildingObj) {
//    Player *player = [Player node];
//      Building *building = [Building node];
//
//      building.position = CGPointMake([buildingObj[@"x"] floatValue],
//                                    [buildingObj[@"y"] floatValue]);
//
////    player.position = CGPointMake([playerObj[@"x"] floatValue],
////                                  [playerObj[@"y"] floatValue]);
////    [self addChild:player];
//          [self addChild:building];

  }
    
//    SKSpriteNode *tile = [SKSpriteNode spriteNodeWithTexture:
//                          [atlas textureNamed:@"tiles32"]];
//    tile.position = CGPointMake(0, 0);
//    
//    [self addChild:tile];
  
//  NSArray *bugs = [group objectsNamed:@"bug"];
//  for (NSDictionary *bugPos in bugs) {
//    Bug *bug = [Bug node];
//    bug.position = CGPointMake([bugPos[@"x"] floatValue],
//                               [bugPos[@"y"] floatValue]);
//    [self addChild:bug];
//  }

}

- (instancetype)initWithTmxObjectGroup:(TMXObjectGroup *)group
                              tileSize:(CGSize)tileSize
                              gridSize:(CGSize)gridSize
{
  if (self = [super init]) {
    _tmxTileSize = tileSize;
    _tmxGridSize = gridSize;
    _tmxLayerSize = CGSizeMake(tileSize.width * gridSize.width,
                               tileSize.height*gridSize.height);
    
    [self createNodesFromGroup:group];
  }
  return self;
}

@end
