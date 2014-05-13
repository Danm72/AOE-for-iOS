//
// Created by Dan Malone on 22/04/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Tree.h"
#import "Constants.h"

@implementation Tree {

}
- (id)initWithTexture:(SKTexture *)texture {
    if (self = [super initWithTexture:texture]) {
        texture.filteringMode = SKTextureFilteringNearest;

        if (self = [super initWithTexture:texture]) {
            self.name = @"Tree";
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setValue:@"Tree" forKey:@"Type"];

            self.userData = data;
            [self setupPhysicsBody];

        }
    }
    return self;
}

- (void)setupPhysicsBody {
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    self.physicsBody =
    [SKPhysicsBody bodyWithRectangleOfSize:size];
    self.physicsBody.categoryBitMask = CNPhysicsCategoryResource;
    self.physicsBody.collisionBitMask = CNPhysicsCategoryUnit;
    self.physicsBody.contactTestBitMask = CNPhysicsCategoryUnit | CNPhysicsCategoryBuilding;
    //    self.physicsBody.dynamic = YES;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.allowsRotation = NO;
    //self.physicsBody.restitution = 1;
    self.physicsBody.dynamic = NO;
    self.physicsBody.friction = 0;
    self.physicsBody.linearDamping = 0;
    
    //    [DrawSelectionBox attachDebugRectWithSize:self.size :self];
}

@end