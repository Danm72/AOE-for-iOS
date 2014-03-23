//
// Created by Dan Malone on 23/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Unit.h"
#import "Constants.h"
#import "TouchUtilities.h"

@implementation Unit {

}

-(void) move:(CGPoint) newPos{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Builder_walk"];

    int direction = -1;

    if (newPos.y > self.position.y && ![TouchUtilities accuracyOfTouchX:self.position :newPos])
        direction = NORTH;
    if (newPos.y < self.position.y && ![TouchUtilities accuracyOfTouchX:self.position :newPos])
        direction = SOUTH;
    if (newPos.x > self.position.x && [TouchUtilities accuracyOfTouchY:self.position :newPos])
        direction = EAST;
    if (newPos.x < self.position.x && [TouchUtilities accuracyOfTouchY:self.position :newPos])
        direction = WEST;
    if (newPos.y > self.position.y && ![TouchUtilities accuracyOfTouchX:self.position :newPos])
        direction = NORTH_EAST;
    if (newPos.y > self.position.y && ![TouchUtilities accuracyOfTouchX:self.position :newPos])
        direction = NORTH_WEST;
    if (newPos.y < self.position.y && ![TouchUtilities accuracyOfTouchX:self.position :newPos])
        direction = SOUTH_EAST;
    if (newPos.y < self.position.y && ![TouchUtilities accuracyOfTouchX:self.position :newPos])
        direction = SOUTH_WEST;

    [self animateWalk:atlas :direction];
    int speed = [TouchUtilities getSpeed:self.position :newPos];

    SKAction *moveTo = [SKAction moveTo:newPos duration:speed];
    [moveTo setTimingMode:SKActionTimingEaseOut];

    [self runAction:moveTo completion:^{
        {
            [self removeAllActions];
            //idle
        }
    }];

}
@end