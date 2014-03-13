//
//  TmxTileMapLayer.m
//  PestControl
//
//  Created by Main Account on 9/17/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "TmxTileMapLayer.h"
#import "Building.h"
#import "Wall.h"
#import "GrassTile.h"
#import "TownCenter.h"
#import "Church.h"
#import "Barracks.h"

//#import "Breakable.h"
//#import "Player.h"
//#import "Bug.h"

@implementation TmxTileMapLayer {
    TMXLayer *_layer;
    CGSize _tmxTileSize;
    CGSize _tmxGridSize;
    CGSize _tmxLayerSize;
}

- (instancetype)initWithTmxLayer:(TMXLayer *)layer {
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

- (void)createNodesFromLayer:(TMXLayer *)layer {
    SKTextureAtlas *atlas =
            [SKTextureAtlas atlasNamed:@"buildings"];

    JSTileMap *map = layer.map;

    //1
    for (int w = 0; w < self.gridSize.width; ++w) {
        for (int h = 0; h < self.gridSize.height; ++h) {

            CGPoint coord = CGPointMake(w, h);
            //2
            NSInteger tileGid = [layer.layerInfo tileGidAtCoord:coord];
            //   [self tileAtCoord:coord];

            if (!tileGid)
                continue;
            //3
            if ([map propertiesForGid:tileGid][@"dirt"]) {
                //  [layer removeTileAtCoord:coord];

                //     NSLog(@"TileGID is: %s", "dirt1");
                //                Tile *tile = [[GrassTile alloc ]initWithTexture:[atlas textureNamed:@"dirt1"]];
                //                tile.position = [self pointForCoord:coord];
                //
                //                [self addChild:tile];

                //            SKSpriteNode *tile = [layer tileAtCoord:coord];
                //            [self addChild:tile];
                //

                // [self addChild:tile];
            }

            if ([map propertiesForGid:tileGid][@"grass"]) {
                //                [layer removeTileAtCoord:coord];
                //
                //                Tile *tile = [[GrassTile alloc ]initWithTexture:[atlas textureNamed:@"Grass"]];
                //                tile.position = [self pointForCoord:coord];
                //
                //                [self addChild:tile];


            } else if ([map propertiesForGid:tileGid][@"snow"]) {
                //  [layer removeTileAtCoord:coord];

                //                Tile *tile = [[GrassTile alloc ]initWithTexture:[atlas textureNamed:@"snow"]];
                //                tile.position = [self pointForCoord:coord];
                //
                //                [self addChild:tile];
                //        SKNode *tile =
                //         [[Breakable alloc]
                //          initWithWhole:[atlas textureNamed:@"tree"]
                //                 broken:[atlas textureNamed:@"tree-stump"]];
                //         tile.position = [self pointForCoord:coord];
                //         [self addChild:tile];
                //         [layer removeTileAtCoord:coord];
            }
            if ([map propertiesForGid:tileGid][@"Wall"]) {
                //  [layer removeTileAtCoord:coord];

                //                Tile *tile = [[GrassTile alloc ]initWithTexture:[atlas textureNamed:@"dirt1"]];
                //                tile.position = [self pointForCoord:coord];
                //
                //                [self addChild:tile];

                //            SKSpriteNode *tile = [layer tileAtCoord:coord];
                //            [self addChild:tile];
                //
                Building *tile = [[Wall alloc] initWithTexture:[atlas textureNamed:@"wall"]];
                tile.position = [self pointForCoord:coord];
                tile.zPosition = coord.x + coord.y * layer.layerInfo.layerGridSize.width;
                [self addChild:tile];

                // [self addChild:tile];
            }
            if ([map propertiesForGid:tileGid][@"TownCenter"]) {
                //  [layer removeTileAtCoord:coord];

                //                Tile *tile = [[GrassTile alloc ]initWithTexture:[atlas textureNamed:@"dirt1"]];
                //                tile.position = [self pointForCoord:coord];
                //
                //                [self addChild:tile];

                //            SKSpriteNode *tile = [layer tileAtCoord:coord];
                //            [self addChild:tile];
                //
                Building *tile = [[TownCenter alloc] initWithTexture:[atlas textureNamed:@"towncenter"]];
                tile.position = [self pointForCoord:coord];

                tile.zPosition = coord.x + coord.y * layer.layerInfo.layerGridSize.width;

                [self addChild:tile];


                // [self addChild:tile];
            }
            if ([map propertiesForGid:tileGid][@"Barracks"]) {
                //  [layer removeTileAtCoord:coord];

                //                Tile *tile = [[GrassTile alloc ]initWithTexture:[atlas textureNamed:@"dirt1"]];
                //                tile.position = [self pointForCoord:coord];
                //
                //                [self addChild:tile];

                //            SKSpriteNode *tile = [layer tileAtCoord:coord];
                //            [self addChild:tile];
                //
                Building *tile = [[Barracks alloc] initWithTexture:[atlas textureNamed:@"elitebarracks"]];
                tile.position = [self pointForCoord:coord];
                tile.zPosition = coord.x + coord.y * layer.layerInfo.layerGridSize.width;

                [self addChild:tile];

                // [self addChild:tile];
            }
            if ([map propertiesForGid:tileGid][@"Church"]) {
                //  [layer removeTileAtCoord:coord];

                //                Tile *tile = [[GrassTile alloc ]initWithTexture:[atlas textureNamed:@"dirt1"]];
                //                tile.position = [self pointForCoord:coord];
                //
                //                [self addChild:tile];

                //            SKSpriteNode *tile = [layer tileAtCoord:coord];
                //            [self addChild:tile];
                //
                Building *tile = [[Church alloc] initWithTexture:[atlas textureNamed:@"barracks"]];
                tile.position = [self pointForCoord:coord];
                tile.zPosition = coord.x + coord.y * layer.layerInfo.layerGridSize.width;

                [self addChild:tile];

                // [self addChild:tile];
            }

            else if (![map propertiesForGid:tileGid][@"snow"] && ![map propertiesForGid:tileGid][@"grass"] && ![map propertiesForGid:tileGid][@"dirt"]) {
                //                NSLog(@"TileGID is: %s", "What are you?!");
                //                [layer removeTileAtCoord:coord];

                //                Building *tile = [[Wall alloc ]initWithTexture:[atlas textureNamed:@"wall"]];
                //                tile.position = [self pointForCoord:coord];
                //                [self addChild:tile];
            }
        }
    }
}

- (SKNode *)tileAtPoint:(CGPoint)point {
    SKNode *tile = [super tileAtPoint:point];
    NSLog(@"TileGID is: %f, %@", point.x, tile.name);

    return tile ? tile : [_layer tileAt:point];
}

- (void)createNodesFromGroup:(TMXObjectGroup *)group {
    //  NSDictionary *playerObj = [group objectNamed:@"player"];
    if ([group.groupName isEqualToString:@"Buildings"]) {
        SKTextureAtlas *atlas =
                [SKTextureAtlas atlasNamed:@"buildings"];
        NSArray *walls = [group objectsNamed:@"Wall"];

        if (walls) {
            for (NSDictionary *wallPos in walls) {
                Building *wall = [[Wall alloc] initWithTexture:[atlas textureNamed:@"wall"]];
                wall.position = CGPointMake([wallPos[@"x"] floatValue],
                        [wallPos[@"y"] floatValue]);
                wall.zPosition = [wallPos[@"z"] floatValue];
                // wall.position = CGPointMake(2569.000000, -232164.265625);
                [self addChild:wall];
            }
        }
        NSArray *townCentres = [group objectsNamed:@"TownCentre"];
        if (townCentres) {
            for (NSDictionary *wallPos in walls) {
                Building *town = [[TownCenter alloc] initWithTexture:[atlas textureNamed:@"towncenter"]];
                town.position = CGPointMake([wallPos[@"x"] floatValue],
                        [wallPos[@"y"] floatValue]);
                // wall.position = CGPointMake(2569.000000, -232164.265625);

                [self addChild:town];
            }
        }


    } else if ([group.groupName isEqualToString:@"Units"]) {
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
                              gridSize:(CGSize)gridSize {
    if (self = [super init]) {
        _tmxTileSize = tileSize;
        _tmxGridSize = gridSize;
        _tmxLayerSize = CGSizeMake(tileSize.width * gridSize.width,
                tileSize.height * gridSize.height);

        [self createNodesFromGroup:group];
    }
    return self;
}

@end
