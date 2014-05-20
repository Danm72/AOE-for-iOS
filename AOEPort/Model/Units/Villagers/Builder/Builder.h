//
// Created by Dan Malone on 20/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Villager.h"
#import "Building.h"



@interface Builder : Villager
//- (void)animateWalk :(NSInteger)direction;
@property (weak, nonatomic) SKTextureAtlas *atlas;
- (SKAction*)createBuilding:(Building *)building;

@end