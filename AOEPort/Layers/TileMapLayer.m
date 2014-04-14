//
//  TileMapLayer.m
//  PestControl
//
//  Created by Main Account on 9/1/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "TileMapLayer.h"

@implementation TileMapLayer {
    SKTextureAtlas *_atlas;
}

- (CGPoint)positionForRow:(NSInteger)row col:(NSInteger)col {
    return
            CGPointMake(
                    col * self.tileSize.width + self.tileSize.width / 2,
                    self.layerSize.height -
                            (row * self.tileSize.height + self.tileSize.height / 2));
}

- (CGPoint)pointForCoord:(CGPoint)coord {
    return [self positionForRow:coord.y col:coord.x];
}

- (BOOL)isValidTileCoord:(CGPoint)coord
{
    return (coord.x >= 0 &&
            coord.y >= 0 &&
            coord.x < self.gridSize.width &&
            coord.y < self.gridSize.height);
}

- (CGPoint)coordForPoint:(CGPoint)point
{
    return CGPointMake((int)(point.x / self.tileSize.width),
            (int)((point.y - self.layerSize.height) /
                    -self.tileSize.height));
}

- (SKNode*)tileAtCoord:(CGPoint)coord
{
    return [self tileAtPoint:[self pointForCoord:coord]];
}

- (SKNode*)tileAtPoint:(CGPoint)point
{
    SKNode *n = [self nodeAtPoint:point];
    while (n && n != self && n.parent != self)
        n = n.parent;
    return n.parent == self ? n : nil;
}

@end
