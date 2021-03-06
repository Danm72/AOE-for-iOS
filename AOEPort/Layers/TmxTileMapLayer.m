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
#import "Tree.h"
#import "TextureContainer.h"

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
    SKTexture *church;
}

- (instancetype)initWithTmxLayer:(TMXLayer *)layer {
    if (self = [super init]) {
        _layer = layer;
        _tmxTileSize = _layer.mapTileSize;
        _tmxGridSize = _layer.layerInfo.layerGridSize;
        _tmxLayerSize = CGSizeMake(3200, 3200);


        [self createNodesFromLayer:layer];

    }
//    _layer = nil;
    return self;
}

- (instancetype)initWithTmxObjectGroup:(TMXObjectGroup *)group
                              tileSize:(CGSize)tileSize
                              gridSize:(CGSize)gridSize {
    if (self = [super init]) {
        _tmxTileSize = tileSize;
        _tmxGridSize = gridSize;
        _tmxLayerSize = CGSizeMake(3200, 3200);

        [self createNodesFromGroup:group];
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
//    SKTextureAtlas *atlas;
    TextureContainer *tx = [TextureContainer getInstance];

    Boolean tileLayer = [layer.layerInfo.name isEqualToString:@"Tiles"];
    if (tileLayer) {
        tx.tiles = [SKTextureAtlas atlasNamed:@"tiles"];

        dirt = [tx.tiles textureNamed:@"dirt1"];
        sand = [tx.tiles  textureNamed:@"sand"];
        grass = [tx.tiles  textureNamed:@"grass"];
        snow = [tx.tiles  textureNamed:@"snow"];
    } else {

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
                NSLog(@"Not Tile layer");
            }

        }
    }

}

- (void)layerContainingTile:(TMXLayer *)layer coord:(CGPoint)coord {
    JSTileMap *map = layer.map;
    //2
    NSInteger tileGid = [layer.layerInfo tileGidAtCoord:coord];

    if ([map propertiesForGid:tileGid][@"dirt"]) {

        Tile *tile = [[DirtTile alloc] initWithTexture:dirt];
        tile.position = [self pointForCoord:coord];
//        tile.zPosition = self.layerSize.height - tile.position.y;


        [self setBlendMode:tile];

//        [_layer removeTileAtCoord:coord];
        [self addChild:tile];
    }
    else if ([map propertiesForGid:tileGid][@"sand"]) {
        Tile *tile = [[SandTile alloc] initWithTexture:sand];
        tile.position = [self pointForCoord:coord];
//        tile.zPosition = self.layerSize.height - tile.position.y;

        [self setBlendMode:tile];

//        [_layer removeTileAtCoord:coord];

        [self addChild:tile];

    } else if ([map propertiesForGid:tileGid][@"grass"]) {
        Tile *tile = [[GrassTile alloc] initWithTexture:grass];
        tile.position = [self pointForCoord:coord];
//        tile.zPosition = self.layerSize.height - tile.position.y;

        [self setBlendMode:tile];

//        [_layer removeTileAtCoord:coord];

        [self addChild:tile];

    } else if ([map propertiesForGid:tileGid][@"snow"]) {

        Tile *tile = [[SnowTile alloc] initWithTexture:snow];
        tile.position = [self pointForCoord:coord];
//        tile.zPosition = self.layerSize.height - tile.position.y;

        [self setBlendMode:tile];

//        [_layer removeTileAtCoord:coord];

        [self addChild:tile];
    } else if (![map propertiesForGid:tileGid][@"snow"] && ![map propertiesForGid:tileGid][@"grass"] && ![map propertiesForGid:tileGid][@"dirt"]) {
//        NSLog(@"TileGID is: %s", "What are you?!");

        Tile *tile = [[SandTile alloc] initWithTexture:sand];
        tile.position = [self pointForCoord:coord];
//        tile.zPosition = self.layerSize.height - tile.position.y;

//        [_layer removeTileAtCoord:coord];

        [self addChild:tile];

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
//        _atlas = [SKTextureAtlas atlasNamed:@"buildings"];
        TextureContainer *tx = [TextureContainer getInstance];

        wall = [tx.buildings textureNamed:@"wall"];
        townCentre = [tx.buildings textureNamed:@"towncenter"];
        barracks = [tx.buildings textureNamed:@"elitebarracks"];
//        eliteBarracks = [atlas textureNamed:@"elitebarracks"];
        church = [tx.buildings textureNamed:@"church"];

        NSArray *walls = [group objectsNamed:@"Wall"];

        if (walls) {
            for (NSDictionary *wallPos in walls) {

                Building *tile = [[Wall alloc] initWithTexture:wall];
                tile.position = CGPointMake([wallPos[@"x"] floatValue],
                        [wallPos[@"y"] floatValue]);

                tile.zPosition = 3200 - tile.position.y;
                tile.placed = TRUE;

                tile.texture.filteringMode = SKTextureFilteringNearest;
                [_layer removeTileAtCoord:CGPointMake([wallPos[@"x"] floatValue],
                        [wallPos[@"y"] floatValue])];
                [self addChild:tile];
            }
        }
        NSArray *townCentres = [group objectsNamed:@"Town"];
        if (townCentres) {
            for (NSDictionary *townPos in townCentres) {

                Building *tile = [[TownCenter alloc] initWithTexture:townCentre];
                tile.position = CGPointMake([townPos[@"x"] floatValue],
                        [townPos[@"y"] floatValue]);
                tile.zPosition = 3200 - tile.position.y;
                tile.placed = TRUE;

                tile.texture.filteringMode = SKTextureFilteringNearest;

                [_layer removeTileAtCoord:CGPointMake([townPos[@"x"] floatValue],
                        [townPos[@"y"] floatValue])];
                [self addChild:tile];

            }
        }
        NSArray *barrax = [group objectsNamed:@"Barracks"];
        if (barracks) {
            for (NSDictionary *barracksPos in barrax) {
                Building *tile = [[Barracks alloc] initWithTexture:barracks];
                tile.position = CGPointMake([barracksPos[@"x"] floatValue],
                        [barracksPos[@"y"] floatValue]);
                tile.zPosition = 3200 - tile.position.y;
                tile.placed = TRUE;

                tile.texture.filteringMode = SKTextureFilteringNearest;
                [_layer removeTileAtCoord:CGPointMake([barracksPos[@"x"] floatValue],
                        [barracksPos[@"y"] floatValue])];
                [self addChild:tile];
            }
        }

        NSArray *churches = [group objectsNamed:@"Church"];
        if (barracks) {
            for (NSDictionary *churchPos in churches) {

                Building *tile = [[Church alloc] initWithTexture:church];
                tile.position = CGPointMake([churchPos[@"x"] floatValue],
                        [churchPos[@"y"] floatValue]);
                tile.zPosition = 3200 - tile.position.y;
                tile.texture.filteringMode = SKTextureFilteringNearest;
                tile.placed = YES;

                [self addChild:tile];
            }
        }

    } else if ([group.groupName isEqualToString:@"Resources"]) {
        NSArray *trees = [group objectsNamed:@"Tree"];
        if (trees) {
//            _atlas = [SKTextureAtlas atlasNamed:@"trees"];
            TextureContainer *tx = [TextureContainer getInstance];

            for (NSDictionary *treePos in trees) {
                int r = arc4random() % 10;

                NSString *name;
                
                @try {
                    if(r <= 4){
                        name = @"bamboo01";
                    }else if (r == 5){
                        name = @"bamboo02";
                    }else if (r == 6){
                        name = @"bamboo03";
                    }else if (r == 7){
                        name = @"bamboo04";
                    }else if (r == 8){
                        name = @"bamboo05";
                    }else if (r == 9){
                        name = @"bamboo06";
                    }
                } @catch (NSException *exception) {
                    NSLog(@"Exception: %@", exception);
                }
                
                Tree *tree = [[Tree alloc] initWithTexture:[tx.trees textureNamed:name]];

                tree.position = CGPointMake([treePos[@"x"] floatValue],
                        [treePos[@"y"] floatValue]);
                tree.zPosition = self.layerSize.height - tree.position.y;

                [self addChild:tree];
            }
        }

    }


}

- (void)setBlendMode:(Tile *)tileToBlend {
    tileToBlend.blendMode = SKBlendModeReplace;
    tileToBlend.texture.filteringMode = SKTextureFilteringNearest;
}

@end
