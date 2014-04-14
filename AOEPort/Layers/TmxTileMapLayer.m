#import "TmxTileMapLayer.h"
#import "Building.h"
#import "Wall.h"
#import "GrassTile.h"
#import "TownCenter.h"
#import "Church.h"
#import "Barracks.h"
#import "DirtTile.h"
#import "SnowTile.h"
#import "SandTile.h"

@implementation TmxTileMapLayer {
    TMXLayer *_layer;
    CGSize _tmxTileSize;
    CGSize _tmxGridSize;
    CGSize _tmxLayerSize;

    SKTexture *dirt;
    SKTexture *sand;
    SKTexture *grass;
    SKTexture *snow;
    SKTexture *townCentre;
    SKTexture *barracks;
    SKTexture *eliteBarracks;
    SKTexture *wall;

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
//    _layer = nil;
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
    SKTextureAtlas *atlas;
    Boolean tileLayer = [layer.layerInfo.name isEqualToString:@"Tiles"];
    if (tileLayer) {
        atlas = [SKTextureAtlas atlasNamed:@"tiles"];
        dirt = [atlas textureNamed:@"dirt2"];
        sand = [atlas textureNamed:@"sand"];
        grass = [atlas textureNamed:@"grass"];
        snow = [atlas textureNamed:@"snow"];
    } else {
        atlas = [SKTextureAtlas atlasNamed:@"buildings"];
        wall = [atlas textureNamed:@"wall"];
        townCentre = [atlas textureNamed:@"towncenter"];
        barracks = [atlas textureNamed:@"barracks"];
        eliteBarracks = [atlas textureNamed:@"elitebarracks"];

    }

    //1
    for (int w = 0; w < self.gridSize.width; ++w) {
        for (int h = 0; h < self.gridSize.height; ++h) {


            CGPoint coord = CGPointMake(w, h);
            NSInteger tileGid = [layer.layerInfo tileGidAtCoord:coord];

            if (!tileGid)
                continue;
            //3
            if (tileLayer) {
                [self layerContainingTile:layer coord:coord];
            } else if (!tileLayer) {
                [self removeBuildingFromLayer:layer coord:coord];
            }

        }
    }

}

- (void)removeBuildingFromLayer:(TMXLayer *)layer coord:(CGPoint)coord {
    JSTileMap *map = layer.map;

    //2
    NSInteger tileGid = [layer.layerInfo tileGidAtCoord:coord];
    //   [self tileAtCoord:coord];

    if ([map propertiesForGid:tileGid][@"Wall"]) {

        Building *tile = [[Wall alloc] initWithTexture:wall];
        tile.position = [self pointForCoord:coord];

        tile.zPosition = self.layerSize.height - tile.position.y;


        tile.texture.filteringMode = SKTextureFilteringNearest;

        [self addChild:tile];
    } else if ([map propertiesForGid:tileGid][@"TownCenter"]) {

        Building *tile = [[TownCenter alloc] initWithTexture:townCentre];
        tile.position = [self pointForCoord:coord];
        tile.zPosition = self.layerSize.height - tile.position.y;

        tile.texture.filteringMode = SKTextureFilteringNearest;

        [self addChild:tile];

    } else if ([map propertiesForGid:tileGid][@"Barracks"]) {

        Building *tile = [[Barracks alloc] initWithTexture:eliteBarracks];
        tile.position = [self pointForCoord:coord];
        tile.zPosition = self.layerSize.height - tile.position.y;

        tile.texture.filteringMode = SKTextureFilteringNearest;

        [self addChild:tile];

    } else if ([map propertiesForGid:tileGid][@"Church"]) {

        Building *tile = [[Church alloc] initWithTexture:barracks];
        tile.position = [self pointForCoord:coord];
        tile.zPosition = self.layerSize.height - tile.position.y;
        tile.texture.filteringMode = SKTextureFilteringNearest;

        [self addChild:tile];
    }
}

- (void)layerContainingTile:(TMXLayer *)layer coord:(CGPoint)coord {
    JSTileMap *map = layer.map;
    //2
    NSInteger tileGid = [layer.layerInfo tileGidAtCoord:coord];

    if ([map propertiesForGid:tileGid][@"dirt"]) {

        Tile *tile = [[DirtTile alloc] initWithTexture:dirt];
        tile.position = [self pointForCoord:coord];
        tile.zPosition = self.layerSize.height - tile.position.y;


        [self setBlendMode:tile];


        [self addChild:tile];
    }
    else if ([map propertiesForGid:tileGid][@"sand"]) {
        Tile *tile = [[SandTile alloc] initWithTexture:sand];
        tile.position = [self pointForCoord:coord];
        tile.zPosition = self.layerSize.height - tile.position.y;

        [self setBlendMode:tile];

//        [self addChild:tile];

    } else if ([map propertiesForGid:tileGid][@"grass"]) {
        Tile *tile = [[GrassTile alloc] initWithTexture:grass];
        tile.position = [self pointForCoord:coord];
        tile.zPosition = self.layerSize.height - tile.position.y;

        [self setBlendMode:tile];

        [self addChild:tile];

    } else if ([map propertiesForGid:tileGid][@"snow"]) {

        Tile *tile = [[SnowTile alloc] initWithTexture:snow];
        tile.position = [self pointForCoord:coord];
        tile.zPosition = self.layerSize.height - tile.position.y;

        [self setBlendMode:tile];

        [self addChild:tile];
    } else if (![map propertiesForGid:tileGid][@"snow"] && ![map propertiesForGid:tileGid][@"grass"] && ![map propertiesForGid:tileGid][@"dirt"]) {
        //                NSLog(@"TileGID is: %s", "What are you?!");
        //                [layer removeTileAtCoord:coord];

        //                Building *tile = [[Wall alloc ]initWithTexture:[atlas textureNamed:@"wall"]];
        //                tile.position = [self pointForCoord:coord];
        //                [self addChild:tile];

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

    }


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

- (void)setBlendMode:(Tile *)tileToBlend {
    tileToBlend.blendMode = SKBlendModeReplace;
    tileToBlend.texture.filteringMode = SKTextureFilteringNearest;
}

@end
