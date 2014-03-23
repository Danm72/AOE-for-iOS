//
// Created by Dan Malone on 23/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Unit : SKSpriteNode
@property (readwrite) NSString *movementSpeed;

- (void)animateWalk:(SKTextureAtlas *)atlas :(NSInteger)direction;

- (void)move:(CGPoint)newPos;
@end