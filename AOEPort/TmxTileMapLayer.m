//
//  TmxTileMapLayer.m
//  PestControl
//
//  Created by Main Account on 9/17/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "TmxTileMapLayer.h"
#import "MyScene.h"
#import "Model/Building.h"
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
    [SKTextureAtlas atlasNamed:@"tiles.atlas"];
    
    JSTileMap *map = layer.map;
    
    
    //1
    for (int w = 0 ; w < self.gridSize.width; ++w) {
        for(int h = 0; h < self.gridSize.height; ++h) {
            
            CGPoint coord = CGPointMake(w, h);
            //2
            NSInteger tileGid = [layer.layerInfo tileGidAtCoord:coord];
            
            if(!tileGid)
                continue;
            //3
            if([map propertiesForGid:tileGid][@"dirt"]) {
                
                //   NSLog(@"TileGID is: %s", "dirt1");
                
                //            SKSpriteNode *tile = [layer tileAtCoord:coord];
                //            [self addChild:tile];
                //
            }
            
            
            
            if([map propertiesForGid:tileGid][@"grass"]) {
                
                //NSLog(@"TileGID is: %s", "grass");
                
                //4
                //        SKSpriteNode *tile = [layer tileAtCoord:coord];
                //
                //        tile.physicsBody =
                //        [SKPhysicsBody bodyWithRectangleOfSize:tile.size];
                //        tile.physicsBody.categoryBitMask = PCWallCategory;
                //        tile.physicsBody.dynamic = NO;
                //        tile.physicsBody.friction = 0;
            } else if([map propertiesForGid:tileGid][@"snow"]) {
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
    NSLog(@"TileGID is: %f", point.x);
    
    return tile ? tile : [_layer tileAt:point];
}

- (void)createNodesFromGroup:(TMXObjectGroup *)group
{
    //  NSDictionary *playerObj = [group objectNamed:@"player"];
    if([group.groupName isEqualToString:@"Buildings"]){
        NSArray *walls = [group objectsNamed:@"Wall"];
        for (NSDictionary *wallPos in walls) {
            Building *wall = [Building node];
            wall.position = CGPointMake([wallPos[@"x"] floatValue],
                                        [wallPos[@"y"] floatValue]);
            [self addChild:wall];
        }
    }else if([group.groupName isEqualToString:@"Units"])
    {
        //    Player *player = [Player node];
        //
        ////    player.position = CGPointMake([playerObj[@"x"] floatValue],
        ////                                  [playerObj[@"y"] floatValue]);
        ////    [self addChild:player];
    }
    //  NSDictionary *unitObj = group.groupName;
    //    NSDictionary *buildingObj = [group objectNamed:@"Wall"];
    
    // NSLog(@"TileGID is: %s", []);
    
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
