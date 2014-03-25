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
            CGSize size = CGSizeMake(self.size.width*2, self.size.height*2);
            self.physicsBody =
                    [SKPhysicsBody bodyWithRectangleOfSize:size];
            self.physicsBody.categoryBitMask = CNPhysicsCategoryBuilding;
            self.physicsBody.collisionBitMask = CNPhysicsCategoryUnit | CNPhysicsCategoryBuilding | CNPhysicsCategoryBoundary;
            self.physicsBody.contactTestBitMask = CNPhysicsCategoryBoundary | CNPhysicsCategoryUnit;
            self.physicsBody.dynamic = NO;
            // self.physicsBody.usesPreciseCollisionDetection = YES;
            self.physicsBody.allowsRotation = NO;
            //self.physicsBody.restitution = 1;
            self.physicsBody.friction = 1;
            self.physicsBody.linearDamping = 0;
            [DrawDebugger attachDebugRectWithSize:self.size:self];
//            CGFloat minDiam = MIN(self.size.width, self.size.height);
//            minDiam = MAX(minDiam-8, 8);
//            self.physicsBody =
//            [SKPhysicsBody bodyWithCircleOfRadius:minDiam/2.0];
//           //self.physicsBody.categoryBitMask = PCBugCategory;
//            self.physicsBody.collisionBitMask = 0;
        }
    }
    return self;
}


//- (id)init{
//    
//    if( self = [super init]){
//        self.name = @"Building";
//        NSMutableDictionary *data =  [[NSMutableDictionary alloc] init];
//        [data setValue:@"Wall" forKey:@"Type"];
//        
//        self.userData = data;
//        
//    }
//    
//    return self;
//}
- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"SUCCESS");

    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    if (collision == (CNPhysicsCategoryBuilding | CNPhysicsCategoryUnit)) {
        NSLog(@"SUCCESS");
    }
//    if (collision == (CNPhysicsCategoryCat|CNPhysicsCategoryEdge)) {
//        NSLog(@"FAIL"); }
}



@end
