//
// Created by Dan Malone on 23/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <Foundation/Foundation.h>

int direction_graphic_start;
int direction_graphic_end;
BOOL flipGraphic;
NSMutableArray *textures;

@interface Unit : SKSpriteNode  <SKPhysicsContactDelegate>


@property (readwrite) NSString *movementSpeed;

+ (NSArray *)getAllPointsFromPoint:(CGPoint)fPoint toPoint:(CGPoint)tPoint;

- (void)animateWalk:(SKTextureAtlas *)atlas :(NSInteger)direction;

- (void)move:(CGPoint)newPos;

- (void)evaluateMovementDirection:(NSInteger)direction;
@end