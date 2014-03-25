//
// Created by Dan Malone on 20/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Villager.h"



@interface Builder : Villager
- (void)animateWalk:(SKTextureAtlas *)atlas :(NSInteger)direction;
@end