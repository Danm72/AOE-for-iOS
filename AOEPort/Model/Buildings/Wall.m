//
//  Wall.m
//  AOEPort
//
//  Created by Dan Malone on 14/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Wall.h"
#import "Constants.h"
#import "DrawDebugger.h"


@implementation Wall
- (id)initWithTexture:(SKTexture *)texture {
    if (self = [super initWithTexture:texture]) {
        texture.filteringMode = SKTextureFilteringNearest;

        if (self = [super initWithTexture:texture]) {
            self.name = @"Building";
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setValue:@"Wall" forKey:@"Type"];

            self.userData = data;
            self.buildType = @"Wall";
            [self setupPhysicsBody];

        }
    }
    return self;
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"Wall contact");

    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    if (collision == (CNPhysicsCategoryBuilding | CNPhysicsCategoryUnit)) {
        NSLog(@"BUILD UNIT");
        [contact.bodyA.node runAction:[Building selectedBuildingAction]];
    }
    if (collision == (CNPhysicsCategoryBuilding | CNPhysicsCategoryBuilding)) {
        NSLog(@"BUILDING");
    }
//    if (collision == (CNPhysicsCategoryCat|CNPhysicsCategoryEdge)) {
//        NSLog(@"FAIL"); }
}



@end
